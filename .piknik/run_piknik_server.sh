#!/bin/bash

# Virtual framebuffer setup
sudo Xvfb :99 -screen 0 1024x768x16 &
XVFB_PID=$!  # Capture the PID of the Xvfb process

# DISPLAY environment setup
if ! grep -q "export DISPLAY=:99" ~/.bashrc; then
    echo "export DISPLAY=:99" >> ~/.bashrc
fi
export DISPLAY=:99

# Check and set permissions for .piknik.toml in current directory
if [ -f ./.piknik.toml ]; then
    chmod 600 ./.piknik.toml
else
    echo "Warning: .piknik.toml not found in current directory. Make sure to create it before running the server."
    exit 1
fi

# Flag to ensure cleanup runs only once
CLEANUP_DONE=false

# Function to cleanup background processes on script exit
cleanup() {
    if [ "$CLEANUP_DONE" = true ]; then
        exit 0  # Exit if cleanup has already been performed
    fi
    CLEANUP_DONE=true
    echo "Stopping Piknik server, clipboard sender, and Xvfb..."
    if ps -p $XVFB_PID > /dev/null 2>&1; then
        kill $XVFB_PID  # Terminate Xvfb if still running
    else
        echo "Xvfb process already terminated."
    fi
    pkill -P $$  # Kill child processes started by this script
    exit 0
}

# Set up trap to catch script termination
trap cleanup SIGINT SIGTERM EXIT

# Start Piknik server in background with output using current directory config
echo "Starting Piknik server..."
piknik -config ./.piknik.toml -server > >(while read line; do echo "[Server] $line"; done) 2>&1 &

# Start clipboard sender
echo "Starting clipboard sender..."
# Previous clipboard content
LAST_CLIPBOARD=""

# Clipboard sender loop
while true; do
    # Get current clipboard content
    CLIPBOARD=$(xclip -o -selection clipboard 2>/dev/null || echo "")
    
    # Check if the clipboard content has changed
    if [[ "$CLIPBOARD" != "$LAST_CLIPBOARD" ]]; then
        echo "[Sender] Copying new content to Piknik"
        # Add the clipboard content followed by the instruction line
        MODIFIED_CONTENT="$CLIPBOARD"$'\nReply with a single code block surrounded by triple backticks and using the language identifier "txt". The content inside this code block should be written in markdown format, but any code blocks within the markdown should use <code_block> and </code_block> tags instead of triple backticks <code_block> tags. NEVER USE TRIPLE BACKTICKS INSIDE <code_block> tags. Your response should start with ```txt and NEVER USE TRIPLE BACKTICKS AGAIN \n\nYou should also include explicit, sequential instructions since another language model will be implementing this. That model has been configured with the capability to:\n- Execute command line operations\n- Create new directories and files\n- Modify existing files\n- Install dependencies and packages\n- Set environment variables\n- Read and write to the file system\n\nPresent each required action as a fully-specified step that another language model can parse and execute. Structure all instructions chronologically, interweaving them naturally between code snippets. Each instruction should specify exact file paths, precise command line operations, and complete file contents. Since the implementing model will execute this in one attempt, each instruction must be unambiguous and complete.\n\nInclude all of this within the single txt code block, maintaining a clear sequence between setup instructions and code implementation details. When specifying file contents, provide complete code without fragments or placeholders, as the implementing model will need to process the entire implementation in a single pass.\n\n'
        echo "$MODIFIED_CONTENT" | piknik -config ./.piknik.toml -copy
        LAST_CLIPBOARD="$CLIPBOARD"
    fi
    
    # Wait before checking again
    sleep 0.5
done