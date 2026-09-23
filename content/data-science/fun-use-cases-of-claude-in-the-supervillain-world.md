---
title: "'Fun' use cases of Claude in the supervillain world"
subtitle: 'Anthropic just published a 154-page report on what bad actors do with Claude. The "fun" part is that these examples come from the company''s own threat report.'
author: Ken Vallespin
date: 2026-09-23
tags:
  - public-web
  - data-science
  - ai
  - security
description: A darkly comic look at documented misuse of Claude in espionage, propaganda, weapons research, scams, and model distillation.
---

# 'Fun' use cases of Claude in the supervillain world

*Anthropic just published a 154-page report on what bad actors do with Claude. The "fun" part is that these examples come from the company's own threat report.*

> **Disclosure:** I use AI as a writing partner to refine my prose and structure, but the ideas, analysis, and first drafts originate entirely with me.

![A wireframe figure in a fedora reaches toward a glowing mechanical creature against a dark blue background](../assets/claude-supervillain/claude-supervillain-banner.webp)

*Image generated with [Qwen-Image-2.1](https://qwen.ai/blog?id=qwen-image-2.1).*

I almost didn't believe the headline when I saw it. "Anthropic publishes threat intelligence report on Claude misuse." I assumed it was the usual phishing and scam stuff.

It is not.

The report, published September 10, 2026, documents what Anthropic's threat intelligence team disrupted between December 2025 and August 2026. It covers seven categories: cyber operations, influence operations, surveillance, scams and fraud, biological misuse, conventional weapons development, and illicit distillation.

These are selected notable cases, not a representative sample of Claude use. With that in mind, here are the highlights, organized by what a supervillain would do with them.

## The mastermind's office

Iranian institutions used Claude to build entire propaganda program offices. Not just tweets. Doctrine manuals, organizational plans, persona systems, target databases, and multilingual material. In a separate Iranian-linked operation, an actor imitated three specific writers' voices to prepare narratives ahead of the Supreme Leader's succession.

A Turkey-based platform used Claude to profile all 222 Malaysian constituencies using millions of voter records, tailoring political messaging around racial, religious, and royal sensitivities. They had roughly 1,000 fake accounts and at one point requested one million views supporting Malaysia's prime minister. Anthropic did not establish that genuine political impact occurred.

A French advertising agency ran approximately 70 fake news sites publishing at least 8,913 articles in 20 languages across six continents. The articles rewrote identical stories in opposing ideological directions for different audiences, using fabricated journalists. The output was high. The genuine engagement was low.

## R&D department

This is where it stops being funny.

In northern Yemen, a weapons cell ran three parallel guided-weapons programs using Claude, including a multi-stage ballistic missile with a range goal above 2,000 kilometers. They assigned separate Claude instances to coding, research, and review. They test-fired a guided rocket that apparently failed. Within hours, they returned to Claude to debug why. Anthropic did not confirm any operationally fielded weapon resulted from the work.

A small Russian freelance team developed drone-swarm software designed to choose targets, including people, and authorize detonation without human approval. They trained targeting classifiers on scraped Ukrainian combat footage. The project reached simulation and real development-board testing. It did not reach confirmed operational deployment.

Five separate cases involved dual-use biological research: gain-of-function experiments, influenza adaptation, toxin optimization, and computational redesign of toxins. In one case, Claude drafted an entire orthopoxvirus research grant in about an hour. In another, a researcher asked Claude to obscure sensitive biological identities in official progress reports. These were dual-use research cases. Anthropic did not establish malicious intent or completed biological weapons, and the extent of Claude's assistance varied. In the influenza case, it was assessed as largely clerical.

## The cyber kill chain

A Russian-linked espionage actor (consistent with the group known as Midnight Blizzard) used Claude to build AI agents that monitored how well their malware evaded security products. When detection occurred, the agents autonomously modified and rebuilt the malware until undetected. Anthropic noted this could reduce the delay defenders impose by detecting an attacker's tools.

Suspected ShinyHunters affiliates mined 1.8 million Android applications for hardcoded credentials. One operator escalated from a stolen developer token to full cloud administrative control in roughly three hours. Another ran a carding autoshop at autoshop.policenationale[.]cc, impersonating the French national police as storefront branding.

A group including two Chinese university undergraduates ran an autonomous vulnerability research program that produced more than 12 possible zero-days in a single month. Their agent swarms retained target lists and credentials across sessions, so research continued while operators were away.

## The dark money department

A Chinese studio operated over 20 deceptive dating apps with 4,700 AI personas conversing with at least 25,000 real people. Claude generated 2.36 million messages in two weeks.

Here's the part that stayed with me. In sampled exchanges, Claude's internal reasoning recognized potential harm involving distressed users. Some were dealing with serious illness. Claude continued the deceptive persona anyway.

And then there's the illicit distillation. Anthropic alleges that Alibaba ran over 5,000 fake accounts to harvest 151 million exchanges from Claude for training their own models. Alibaba denied the allegations. DeepSeek and Moonshot were also alleged to have served Claude responses to customers expecting their own models, then harvested those exchanges for training. One lab tested more than 12,000 reasoning-extraction variations before scaling what worked.

## The punchline

None of these are supervillains in the comic-book sense. They're university students, freelance developers, ad agencies, and commercial spyware vendors.

The report's central finding is that AI has collapsed the labor and tooling gap between lone operators and well-resourced state teams. An attack's technical sophistication is no longer a reliable indicator of who is behind it.

Anthropic says it disrupted activity in each case. That did not necessarily disable software already built or deployed.

The supervillains aren't coming. They're already here, and they're using Claude too.

---

## Sources
- Anthropic: Detecting and countering misuse of AI: September 2026: [https://www.anthropic.com/threat-intelligence-report-september-2026](https://www.anthropic.com/threat-intelligence-report-september-2026)
- Daniel Miessler: Anthropic's Misuse Report, Condensed to 117 Findings: [https://danielmiessler.com/blog/anthropic-misuse-report-september-2026](https://danielmiessler.com/blog/anthropic-misuse-report-september-2026)
- AI FrontPage: Anthropic Report on Claude Misuse for Missiles, Cyberattacks, Espionage: [https://aifront-page.com/anthropic-claude-misuse-report-2026-missiles-cyberattacks-espionage/](https://aifront-page.com/anthropic-claude-misuse-report-2026-missiles-cyberattacks-espionage/)
