#!/bin/bash

set -e  # Exit on error
set -u  # Treat unset variables as errors
set -o pipefail  # Detect pipeline errors

# Update .gitignore
echo "Updating .gitignore..."
GITIGNORE_ENTRIES=(
    "*.aider"
    ".env.local"
    "node_modules"
)
for ENTRY in "${GITIGNORE_ENTRIES[@]}"; do
    if ! grep -qx "$ENTRY" .gitignore; then
        echo "$ENTRY" >> .gitignore
    fi
done

# Install Python dependencies
echo "Installing Python dependencies..."
pip install --upgrade pip
# pip install -r requirements.txt
python -m pip install aider-install
aider-install

# Perform an editable install if applicable
if [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
    pip install -e .
fi

#piknik install
wget https://github.com/jedisct1/piknik/releases/download/0.10.2/piknik-linux_x86_64-0.10.2.tar.gz
tar xzf piknik-linux_x86_64-0.10.2.tar.gz
sudo mv linux-x86_64/piknik /usr/local/bin/piknik
sudo chmod +x /usr/local/bin/piknik
rm -rf piknik-linux_x86_64-0.10.2.tar.gz linux-x86_64

#clipboard syncing
sudo apt-get update
sudo apt-get install xclip -y
sudo apt-get install xvfb -y

echo "Post-create script has been executed successfully!"