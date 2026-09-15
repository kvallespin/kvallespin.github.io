---
title: "A hundred million tokens later"
subtitle: "How a tired student, a sticker-covered laptop, and three local models accidentally proved that the boring worker wins."
author: "Ken Vallespin"
date: "2026-08-29"
tags: [AI, local-llm, machine-learning, computer-vision, agents, public-web]
description: "I benchmarked local models on a personal laptop, trained an aircraft classifier while I slept, and accidentally proved that the boring worker model was the one I actually needed."
---

# A hundred million tokens later

*How a tired student, a sticker-covered laptop, and three local models accidentally proved that the boring worker wins.*

***Disclaimer:*** *I use AI as a writing partner to refine my prose and structure, but the ideas, analysis, and first drafts originate entirely with me.*

The counter flipped at some point between finishing a notebook and opening another. One hundred million tokens. Five hundred and forty-four sessions. I did not notice in the moment, which is the kind of thing that makes you stop and realize you have drifted into the background of your own work.

This is the post about that number. And about how it happened.

It did not happen because I was curious about local inference. It happened because I was tired of paying cloud prices for chores.

---

## The irritation

I run my Data Science, Machine Learning, Deep Learning, and Computer Vision coursework through Borges, my planner agent. He is good at the thinking parts: framing the problem, spotting mistakes, keeping me honest about what I actually proved versus what I wanted to be true.

But I kept giving him everything. Strategy, debugging, code generation, formatting, checking, and the small mechanical tasks that pile up when you are learning four things at once. And every one of those small tasks cost the same as the thinking parts.

The thought would not leave me: if the planner is expensive, why is he mopping the floor?

So I asked a narrower question. Could a local model on a modest laptop handle the boring worker jobs, with Borges staying above it as planner and verifier? The local model would get a bounded task, a file allowlist, and no authority. Garbage in, Borges rejects it. Something real, we keep it.

That was the whole experiment.

---

## The machine

This laptop is not low-end. It is not a workstation, either. An MSI I bought about three years ago: i7-1280P, 16GB RAM, Intel Iris Xe graphics. It handles normal personal use without complaint. For local AI work the RAM ceiling shows up fast, and the integrated GPU mostly watches the CPU and memory do the actual labor.

Also, my daughter has covered it in girly stickers, which is probably the most honest description of this setup. A machine powerful enough to run inference, rebranded by a child who thinks it looks pretty. I do not mind. The stickers feel more accurate than the spec sheet.

---

## The candidates

I tested three local models as worker candidates. Borges was not one of them; he ran through the Codex/OpenAI provider on GPT-5.5.

| Role | Model | Source | Use |
| --- | --- | --- | --- |
| Planner / verifier | GPT-5.5 via Codex/OpenAI | Proprietary provider | Orchestration, writing, inspection, verification |
| Broad local tutor | [qwen3.5:9b](https://huggingface.co/Qwen/Qwen3.5-9B) | Alibaba Qwen | Notebook helper and general explanation |
| Reasoning backup | [deepseek-r1:8b](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B) | DeepSeek | Math and reasoning fallback |
| Winning local worker | [qwen2.5-coder:7b](https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct) | Alibaba Qwen | Small Python coding tasks |

NVIDIA hosted inference was available during this period and useful for exploration. But coursework wants something different from exploration. It wants repeatable runs, local files, and artifacts I can inspect without wondering whether an API quota or rate limit killed the job halfway through. Remote inference is powerful. It is also another variable between me and a result I can actually verify. So the serious work pulled back toward a setup I controlled completely.

---

## The benchmark

I ran a clean benchmark on June 27, 2026. Each model got the same set of small coding tasks: file operations, script scaffolding, data reporting. The scoring was straightforward. Did it finish? Did it work? How long did it take? What was the initial quality?

The results came back clean and not surprising.

Qwen2.5-Coder finished all 10 tasks. Zero timeouts. Average task time of 94.2 seconds, which was 7.8 times faster than Qwen3.5 on the same work.

Qwen3.5-9B had the best initial quality at 4.56 out of 5, but it took forever. On a 16GB laptop the larger model spent most of its time thinking.

DeepSeek-R1-8B timed out on 6 of 10 tasks, hitting the 1200-second ceiling thinking aloud. The remaining four completed, but six empty timeout boxes is not a worker profile.

Only Qwen2.5-Coder felt like a worker. The others felt like consultants.

---

## The other character in this story

Borges is my personal agent, named with the appropriate level of literary overreach. Jorge Luis Borges is my favorite author in the whole wide world, which I admit has the energy of a child pointing at a bookshelf and declaring a permanent alliance. He wrote about labyrinths, mirrors, infinite libraries, and systems that are elegant until you get lost in them. That feels uncomfortably close to modern AI tooling on some days.

In this experiment, Borges was not the thing being benchmarked. He was the planner, critic, file wrangler, and inconvenient adult who kept asking whether the output actually existed. The local models were workers. Borges sat above them, turning vague ideas into bounded tasks, checking the results, rejecting hallucinated artifacts, and occasionally reminding me that a thin laptop with 16GB of RAM is not a datacenter just because I want it to be one.

The workflow is deliberately unromantic. Borges plans and verifies. The local worker drafts or patches small pieces. The artifact gets executed. If it fails, it goes back through the loop.

---

## The aircraft dataset

To test the whole pipeline on something real I used the [Mendeley Aircraft Image Dataset](https://data.mendeley.com/datasets/mdmczsr5fy/1): 4,520 public aircraft images across eight classes, licensed CC BY 4.0. The class distribution was reasonably balanced, which made it suitable for a lightweight recognition baseline. Image dimensions varied, so preprocessing mattered before training.

Qwen2.5-Coder helped draft the data reporting scripts, contact sheets, verification scaffolding, and the first pass of the training script. That was enough to matter. The model was not becoming a research assistant; it was becoming a useful mechanic, and that distinction kept the whole thing honest.

---

## Training while I slept

I left PyTorch training the aircraft model while I slept. That sentence sounds fancier than the setup deserves. It was a MobileNetV3 Small transfer-learning run on a personal laptop, with the backbone frozen and the classifier head trained on CPU. Nothing heroic.

When I woke up I asked for status. The answer was the useful kind: completed, exit code 0, test accuracy 84.8%, artifacts written to disk.

Training accuracy rose steadily. Validation accuracy settled in the mid-80s, with mild overfitting signs but nothing surprising for a small CPU-only baseline. The confusion matrix showed most signal on the diagonal, with Airbus/Boeing and Sukhoi/F16 confusions standing out. Those make sense: similar silhouettes, similar operating envelopes, similar photography angles in the dataset.

To make the recognition test tangible I pulled a random sample of 20 public images from the dataset and panelized them with approximate bounding boxes for presentation. These were not YOLO detections; the trained model was a classifier, not an object detector. That distinction matters.

| ID | Class | File | Source |
| --- | --- | --- | --- |
| 01 | Boeing | Boeing - (112).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 02 | KAI | KAI - (402).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 03 | KAI | KAI - (369).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 04 | Boeing | Boeing - (327).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 05 | Grob | Grob - (387).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 06 | F16 | F16 - (68).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 07 | KAI | KAI - (210).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 08 | Sukhoi | Sukhoi - (294).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 09 | ATR | ATR - (382).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 10 | Sukhoi | Sukhoi - (486).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 11 | ATR | ATR - (466).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 12 | ATR | ATR - (162).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 13 | KAI | KAI - (377).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 14 | C130 | C130 - (43).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 15 | Airbus | Airbus - (452).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 16 | Boeing | Boeing - (547).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 17 | F16 | F16 - (420).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 18 | C130 | C130 - (181).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 19 | F16 | F16 - (229).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |
| 20 | Boeing | Boeing - (542).jpg | Mendeley Aircraft Image Dataset, CC BY 4.0, DOI 10.17632/mdmczsr5fy.1 |

The ceiling is clear enough. A stronger backbone, better augmentation, proper validation splits, actual object detection would all improve future runs. Qwen stays useful in that loop for scaffolding, tests, cleanup, and reporting, right up until something better arrives, or until I become a millionaire overnight and install a proper GPU in the spare bedroom. (The RAM problem would also solve itself.)

---

## I orchestrated from Telegram

This whole thing did not happen in a lab. It happened in a chat thread on my phone, while I was mostly lying down after a full day of class. The installs, model shortlist, benchmark run, dataset study, recognition panel, overnight PyTorch training, and this draft all moved through the same place where I would normally send a quick note.

No ceremony. No dashboard theater. Just messages, files, tool calls, corrections, and the occasional moment where I had to ask whether my modest sticker-covered laptop was being brave or just warm.

It sounds ridiculous when written down. It also worked.

---

## What I am actually taking from this

The local model was not the win. The useful part was learning where it belongs. A small model on a RAM-constrained laptop should not be treated like a second brain or a tiny senior engineer living inside Ollama. That is how you get confident garbage at local speed.

But as a bounded worker it becomes interesting. Give it a narrow job. Make the output executable. Make the planner inspect it. Run the thing. Keep what survives. Throw away what does not.

That is not glamorous. It is the kind of workflow that can remove friction from coursework, notebooks, and technical writing without pretending the laptop became a workstation overnight.

So the answer was not "run everything locally." The answer was more specific: keep the strong planner, add the cheap worker, and never skip verification.

---

## If you are building your own local LLM bench

Start with your actual workflow, not a leaderboard. The best local worker is the one that finishes the boring job correctly enough to survive review. You do not need the smartest model. You need the one that does not time out and does not hallucinate its way past the verifier.

If you want the prompts, the scoring sheet, the setup notes, and a walkthrough of the parts that went sideways, those are available. Just ask.

---

## Sources

- Mendeley Aircraft Image Dataset (Siddiqui, S. A., CC BY 4.0, 4,520 images across 8 aircraft classes): https://doi.org/10.17632/mdmczsr5fy.1
- Qwen3.5-9B (Alibaba Qwen): https://huggingface.co/Qwen/Qwen3.5-9B
- DeepSeek-R1-Distill-Llama-8B (DeepSeek): https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B
- Qwen2.5-Coder-7B-Instruct (Alibaba Qwen): https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct
- MobileNetV3 architecture (Howard, A. et al., "Searching for MobileNetV3," ICCV 2019): https://arxiv.org/abs/1905.02244
