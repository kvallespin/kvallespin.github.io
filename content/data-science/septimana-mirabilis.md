---
title: "Septimana Mirabilis"
subtitle: "Why the future of AI fits on a desk, runs offline, and belongs to whoever plugs it in."
author: "Ken Vallespin"
date: "2026-08-29"
tags: [AI, local AI, sovereign AI, DGX Spark, open models]
description: "A week of local AI releases from Meta, Unsloth, DeepSeek, and Qwen, and what they mean for owning intelligence instead of renting it."
---

# Septimana Mirabilis

*Why the future of AI fits on a desk, runs offline, and belongs to whoever plugs it in.*

> **Disclosure:** I use AI as a writing partner to refine my prose and structure, but the ideas, analysis, and first drafts originate entirely with me.

Between August 10 and 14, four separate companies released four separate tools in five days. None of them seemed to be coordinating. And yet they all pointed in the same direction: the stuff you need to build, run, and train AI is leaving the cloud and moving onto machines you actually own.

That matters to me because I do this every day.

I keep a DGX Spark on my desk. It's about the size of a loaf of bread, has 128 gigabytes of memory, and runs on a Blackwell chip. I've loaded a model called Qwen-3.6-27B onto it. No internet needed. No prompts sent to some company's servers. No per-token fees. If my connection drops, the model still works. If the company that built it decides to raise prices, I don't care. I already have it.

That's not just a technical preference. It's the same instinct that makes me keep a flashlight in my car. Except instead of light, I'm preparing for thinking.

Here's what happened that week.

## Monday: Meta gives away a really good model

![Muse Glimmer running on desktop](../assets/septimana-mirabilis/muse-glimmer-desktop.png)
*Muse Glimmer: 30 billion parameters, Apache 2.0, under 20GB compressed.*

Meta dropped something called Muse Glimmer. It has 30 billion parameters, which sounds like a math problem until you realize what that means in practice. It's big enough to be genuinely smart, but small enough to fit on a decent gaming GPU or a Mac. Compressed down to 4-bit quantization, which is just a fancy way of saying "squished," it takes up less than 20 gigabytes. You could put it on a USB stick and carry it around.

The license is what caught my eye. It's Apache 2.0. You can download it, use it, modify it, build things with it, and even sell those things. No account required. No cloud connection. You just run it.

Meta usually builds models that only work through their API. This is different. Glimmer is designed for agents. It's tuned to do real work like writing code, debugging, calling other tools, reading images, and tracking long tasks without getting confused. It handles over a hundred languages.

Why would Meta give this away? Because they don't make money selling AI access. They make money from ads and hardware. A free, good model hurts the companies that charge you monthly subscriptions. It's a business play, sure. But it's a business play that happens to help people like me.

## Tuesday: An app that trains models on your laptop

![Unsloth Desktop app interface](../assets/septimana-mirabilis/unsloth-desktop.jpg)
*Unsloth Desktop: inference, fine-tuning, dataset prep, and export in one app.*

This is the one I care about most.

A company called Unsloth released a desktop app that lets you train AI models on your own computer. Not rent someone else's training cluster. Not fine-tune a hosted model. Actually train one, locally.

Before this, training a model on your own machine meant wrestling with Python environments, fighting CUDA version conflicts, and copy-pasting code from random blog posts and hoping nothing explodes. It felt like building a car engine in your garage with instructions written in a language you're still learning.

Unsloth Desktop bundles everything into one app. Load a model. Prepare your data. Train. Export the result. It runs on Windows, Mac, and Linux, including Apple Silicon. They claim it's twice as fast as the old way and uses 70 percent less memory.

What will I use this software for you ask? Model fine-tuning. Right now I use a workaround called RAG, which stands for Retrieval-Augmented Generation. In plain English, I paste chunks of my own documents to the model when I ask questions, and it answers based on what I gave it. It works, but it's clumsy. The model doesn't actually know my work. It reads what I paste, answers, and then forgets.

Fine-tuning is different. A fine-tune means the model learns my work and bakes it into its weights. It becomes part of how the model thinks. I want to feed it years of my writing and notes and projects and have a model that I own remember all of it. Unsloth Desktop makes that sound like a Saturday evening project instead of a six-month research endeavor.

It's in beta, version 0.1.701. It still works best with NVIDIA cards. I haven't tested it deeply. But it's on my machine now, and that's new.

## Thursday: The plumbing goes open source

![DeepSeek Harness interface](../assets/septimana-mirabilis/deepseek-harness.png)
*DeepSeek Harness: everything is a plugin, including the model itself.*

DeepSeek was supposed to release a new model that week, and they did. But the more interesting release was the tool that came with it.

They called it DeepSeek Harness, or dsh for short. It's the scaffolding that turns a raw model into an agent that can actually do things.

Think about it this way. A model is a brain. But a brain in a jar can't do anything useful. It needs hands to type, eyes to see, a memory of what happened earlier, and a way to decide what to do next. That's what the harness provides. The tool registry. The sandbox that stops the model from accidentally deleting your hard drive. The session log that remembers the conversation. The loop that goes: look at the task, figure out which tool to use, use it, check the result, decide what's next.

Most companies treat this layer as a trade secret. You can use their agent, but you can't see how it works or change how it behaves. DeepSeek did the opposite. They made the whole thing open source under the MIT license. Their first design rule is that everything is a plugin.

The model is a plugin. The tools are plugins. Memory is a plugin. The interface you see is a plugin. You can swap any piece out for a different one. You can even run Claude Code or OpenAI's Codex as a sub-agent inside it.

Here's the part I actually find cool. The framework it's built on, called Cordis, is nine years old. It was originally designed to let people add plugins to a chatbot. Someone in 2019 figured out how to build software that lets you plug pieces in and out safely, and now that same idea is the foundation for how AI agents modify their own working environment. An agent could write a tool, test it, keep it if it works, and delete it if it doesn't. That's not science fiction anymore. That's what this architecture allows. Not to mention the portability of this software (I'm already running this in my own personal laptop and lets it handle my agentic work surprisingly well!). To date, only dsh gives transparency and observability among all of the top-tier harnesses and coding agents in circulation. This, at least for me, signals that my data, my work, all my tool calls, and everything that goes on with my agentic workflows and pipelines are traceable and auditable. A kind of refreshing feature one sees very rarely these days.

DeepSeek picked up 30,000 GitHub stars in a few hours. That's a lot of developers saying the same thing: I want to build my own agent, and now I can.

## Friday: A new model that might replace my daily driver

![Qwen 3.8-27B model card](../assets/septimana-mirabilis/qwen-3-8-27b.jpg)
*Qwen 3.8-27B: 262K context, multimodal, fits on a 4090.*

Alibaba's Qwen team released Qwen 3.8-27B on Friday afternoon. It's the successor to the model I use every day, and it's supposed to be noticeably better.

The specs are interesting. It has 28 billion parameters. It's multimodal out of the box, meaning it can see and read. It handles 262,000 tokens of context natively, which is about 200,000 words or roughly a whole novel. When compressed, it runs in about 16 to 17 gigabytes of memory, so it fits on a 3090 or 4090 graphics card. Unsloth had a compressed version ready the same day.

The benchmark numbers look impressive. Qwen claims it beats Claude Opus 4.6 on some coding tests. On SWE-bench Pro, they list 61.7 for Qwen versus 53.4 for Opus. Those are big margins.

But here's the catch. Those are Qwen's numbers. They ran the tests. Several of the benchmarks are modified versions of public tests, which is a polite way of saying they're tuned so Qwen does well. A developer named Simon Willison tried it the day it came out and said the numbers look good but we should wait for independent testing. I agree with him.

There's also a weird quirk. The model ships with its reasoning set to "extra high" by default. Someone asked it what two plus two is, and it spent several thousand tokens thinking about it before answering four. You can turn it down, but you have to know to do that.

## What this actually means for me

![DGX Spark on desk](../assets/septimana-mirabilis/dgx-spark-desk.jpg)
*The DGX Spark: 128GB unified memory, the size of a loaf of bread.*

All four releases fit into my workflow without major changes.

Unsloth Desktop is where my models live and where I'll eventually train new ones. Harness is the thing that could turn a model from something that just talks into something that actually does work for me. Glimmer is a new model I can test alongside Qwen. And Qwen 3.8-27B is the upgrade waiting on my hard drive.

But here's the honest part: I'm still using Qwen-3.6-27B. The newer version is downloaded and sitting on my disk. I haven't switched because the old one works and I know what it's going to do. I know where it fails. That's worth something.

I'll switch when the new version earns it on my actual tasks, on my actual hardware, at my actual pace. Nobody is pushing updates on me. Nobody is shutting down the old version and forcing an upgrade. That's the whole point of owning your stack.

## The real story

![Sovereign AI concept](../assets/septimana-mirabilis/sovereign-ai-mit-smr.jpg)
*Sovereign AI for individuals and small teams starts with local control. (Image: Carolyn Geason-Beissel/MIT SMR | Getty Images)*

Forget the benchmark numbers and the launch events (I never even bothered to benchmark my past/current setups anyway). The real story of this week is that usable AI is moving toward hardware you own and licenses you can actually read.

Meta gave away a capable model. Unsloth made model training feel like normal software instead of a PhD project. DeepSeek opened up the scaffolding that makes agents work (and worked well, they did!). Qwen put serious performance into a model that fits on a gaming card.

All of them can run on my machine. None of them need the cloud. My data stays where I put it. The model can't be deleted from under me. The price can't change next quarter. The terms of service can't be rewritten while I'm asleep. And God forbid, if Anthropic, OpenAI or indeed, the US Government decides to pull another Fable-type lock-out, I won't be left grasping at straws.

And more importantly, if the internet goes down for an hour or a day or a week, I can still work.

That's not paranoia. That's basic planning. I keep cash at home in case the bank is closed, jugs of drinking water in case another lockdown happens, I know you, dear reader, can catch my drift. This is the same thing. I'm all in on AI. I use it constantly. Which is exactly why I want a version that doesn't depend on someone else's service staying online.

I won't oversell it. Most of the benchmarks were self-reported (as with every shipped software and models from AI labs these days!). Everything is still in preview or beta. Running AI locally still has a lot of setup pain that doesn't show up in screenshots. The big companies will probably keep the edge on raw power for a while.

But the rest of us are getting something they can't sell and can't take back. Models we own, on machines we control, that keep working when the lights flicker.

It was just one week. But for me, this is a step in the right direction.

---

## Sources

- Meta Research: Introducing Muse Glimmer: <https://research.meta.ai/blog/introducing-muse-glimmer-open-agentic-model>
- Hugging Face: Muse-Glimmer-30B: <https://huggingface.co/meta-models/Muse-Glimmer-30B>
- Unsloth: Introducing Unsloth Desktop: <https://unsloth.ai/docs/desktop>
- DeepSeek Harness on GitHub: <https://github.com/deepseek-ai/deepseek-harness>
- arXiv: Spatiotemporal Composability Paper: <https://arxiv.org/abs/2608.25512>
- Hugging Face: Qwen3.8-27B: <https://huggingface.co/Qwen/Qwen3.8-27B>
- Simon Willison on Qwen 3.8 27B: <https://simonwillison.net/2026/Aug/16/qwen-38-27b/>
- MIT Sloan: What CEOs Need to Know About Sovereign AI: <https://sloanreview.mit.edu/article/what-ceos-need-to-know-about-sovereign-ai/>
