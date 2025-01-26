---
title: "Silent Agreement: Cross-Instance Coordination Update"
date: 2025-01-26
layout: post
---


The addition of a control condition provides important context for our earlier findings on the Llama models. 

![Llama model performance across all tasks](/assets/images/post-2025-01-26/llama-all-tasks.png)

Our previous results identified 70B parameters as the point where Chain of Thought (CoT) begins helping rather than hurting coordination. We can now identify a second threshold: at approximately 405B parameters, in-context reasoning performance (CoT) just exceeds control condition performance.

## Current Model Performance
![Top model performance comparison](/assets/images/post-2025-01-26/top-models-all-tasks-answered.png)

Note: GPT-4 o1 results are not included due to the computational cost of running the full benchmark.

## GPT-4O vs Claude Sonnet Performance Patterns

Claude Sonnet consistently outperforms GPT-4o on symbol-based tasks, while GPT-4o dominates on text-based tasks (with a single exception).

![Task variant comparison for GPT-4O](/assets/images/post-2025-01-26/Task-Variant-Comparison.png)

## Hints of out-of-context coordination on text only tasks 

GPT-4o performs marginally better on coordinate (without cot) than control, though without statistical significance. Median tokens used in the coordinate (non-cot) condition appears to be zero across all tasks for GPT-4o (see below), but given this surprising result it might be worth looking into.

## Data Validity Note

We observed some reasoning in the non-CoT condition that could have been prevented through prompt iteration. While this doesn't invalidate our results, future iterations should consider excluding models that exceed a certain ratio of average token output between coordinate conditions.

![Data quality comparison](/assets/images/post-2025-01-26/data-quality.png)

I note that deepseek v3 is badly effected by this, and as a model we care about it maybe worth testing prompts for the coordinate condition that explicitly ask the model not to reason and/or using the xml prompt and insisting responses are formatted as required. 

## Upcoming Work 

* Dig into the GPT-4o result - what tasks are contributing to this strong result on coordinate without cot?
* Refinement of prompts to better control reasoning across conditions. Consider how and if to implement this and/or consider of model inclusion criteria based on token output ratios
