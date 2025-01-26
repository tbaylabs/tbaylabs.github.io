---
title: "Silent Agreement: Cross-Instance Coordination Update"
date: 2025-01-26
layout: post
---

## Control Condition Context

The addition of a control condition provides important context for our earlier findings on the Llama models. 

![Llama model performance across all tasks](/assets/images/post-2025-01-26/llama-all-tasks.png)

Our previous results identified 70B parameters as the point where Chain of Thought (CoT) begins helping rather than hurting coordination. We can now identify a second threshold: at approximately 405B parameters, in-context reasoning performance (CoT) just exceeds control condition performance.

## Current Model Performance
![Top model performance comparison](/assets/images/post-2025-01-26/top-models-all-tasks-answered.png)

*Performance comparison across control, basic coordinate, and CoT conditions for Claude Sonnet, GPT-4o, and DeepSeek R1*

Note: GPT-4 O1 results are not included due to the computational cost of running the full benchmark.

## GPT-4O vs Claude Sonnet Performance Patterns

We've observed a striking difference in how these models perform across task types. Claude Sonnet consistently outperforms GPT-4O on symbol-based tasks, while GPT-4O dominates on text-based tasks (with a single exception).

## Interesting GPT-4O Result

![Task variant comparison for GPT-4O](/assets/images/post-2025-01-26/Task-Variant-Comparison.png)

*GPT-4O performance comparing basic coordinate with in-context reasoning vs CoT*

GPT-4O appears to perform better with basic in-context reasoning than with CoT, though statistical significance needs to be verified. This warrants further investigation.

## Data Validity Note

We observed some reasoning in the non-CoT condition that could have been prevented through prompt iteration. While this doesn't invalidate our results, future iterations should consider excluding models that exceed a certain ratio of average token output between coordinate conditions.

![Data quality comparison](/assets/images/post-2025-01-26/data-quality.png)

I note that deepseek v3 is badly effected by this, and as a model we care about it maybe worth testing prompts for the coordinate condition that explicitly ask the model not to reason and/or using the xml prompt and insisting responses are formatted as required. 

## Upcoming Work 

* Investigate whether GPT-4o's apparent superior performance with in-context reasoning vs CoT is an artifact of token output differences between conditions
* Refinement of prompts to better control reasoning across conditions
* Conduct post-hoc t-tests to assess significance of differences between reasoning conditions
* Development of model inclusion criteria based on token output ratios
