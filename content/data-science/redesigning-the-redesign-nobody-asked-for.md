---
title: Redesigning the redesign nobody asked for
subtitle: DVSAI203, a homework critique, and the sentence that wouldn't let me go.
author: Ken Vallespin
date: "2026-08-06"
tags:
  - data-science
  - data-visualization
  - mba/aim
description: A small data visualization detour about replacing a tidy procurement score bar chart with a radar chart, then a faceted dot plot that makes the comparison easier to trust.
---

> **Disclosure:** I use AI as a writing partner to refine my prose and structure, but the ideas, analysis, and first drafts originate entirely with me.

![Big data and insurance visualization](assets/redesign-of-the-redesign/big-data-insurance.jpg)

*Source: [WaterStreet Company](https://www.waterstreetcompany.com/)*

Here's how you accidentally assign yourself homework.

You're writing a critique for a data visualization course. The brief says: critique the charts, then write a short paragraph on what you'd explore next. You write it. You submit. You move on.

Except you wrote this one sentence: "I would also explore a faceted dot plot as an alternative."

And then you never did it.

The sentence sat in the deck for a week, unexplored, every time I opened the file to fix some other thing. It was the data viz equivalent of a browser tab you keep meaning to close.

![Screenshot of the Deliverable 3 critique paragraph proposing a faceted dot plot as a next step](assets/redesign-of-the-redesign/critique-next-step.jpg)

Eventually I opened PyCharm on a Saturday and actually built the damn thing. No audience. No grade on the line. Just me settling a debt to my future self.

Here's what I built and why the bar chart got me to the radar chart got me to the dot plot got me nowhere fast.

---

## The problem with "who won"

The original chart was a single bar per vendor. Three bars. Three total weighted scores. Vendor B at 79.5.

![Original Deliverable 1 bar chart showing total weighted scores](assets/redesign-of-the-redesign/original-bar-chart.jpg)

Clean. Simple. And almost completely useless for the decision it was supposed to inform.

Three technology vendors were being evaluated for a connectivity contract. Six criteria. Different weights. And this chart collapsed all of it into three numbers. If Vendor A was brilliant on price but barely passable on reliability, and Vendor C was the inverse, the chart showed two similar-height bars and said nothing about the tradeoff. It told you who won but not how they won or whether you should care.

---

## The prettier lie

So I redesigned it as a radar chart. Six axes, one per criterion. The winning vendor in a bright saturated color, the other two in flat gray, pushed back so the winner visually dominates. I also rewrote the title to state the conclusion instead of describing the chart.

![Deliverable 2 radar chart redesign with winning vendor highlighted](assets/redesign-of-the-redesign/radar-redesign.jpg)

This was better. You could see the winner pulling ahead on the two criteria that actually mattered: reliability and technical depth. The shape of the polygon told the story.

Until you remember that radar charts lie to you.

The eye reads the area of the polygon, not the position of each point. Two vendors with genuinely different score profiles can look like similar-sized blobs depending on the order of the axes. For a chart supporting a real procurement decision, that's not a quirk. It's a defect.

I knew this. I wrote it down in the critique. Then I closed the laptop and forgot about it.

---

## The chart an engineer would trust

The faceted dot plot is boring. One row per criterion. One dot per vendor. All on a shared scale. No angles, no polygons, no tricks.

![Faceted dot plot comparing raw scores and weighted points across evaluation criteria](assets/redesign-of-the-redesign/faceted-dot-plot.jpg)

The left panel shows raw scores. The right converts them to weighted points, so you see both how each vendor scored and how much that score mattered to the final total. The weights are printed next to each criterion label so you don't have to remember that technical proposal counts more than delivery readiness.

Same winner. Same 79.5. Same data. Different relationship to it.

With the dot plot you can answer specific questions without leaving the chart. Who's strongest on the technical proposal? Look at that row. The dots sit on a number line and they tell you what's happening. No flipping back to a scoring table. No squinting at overlapping shapes.

It's not dramatic. The radar chart looks like something you'd put on a slide titled "The Data Tells a Story." The dot plot looks like something you'd show the person signing the check.

---

## What data visualization is actually for

The three charts all told the same factual story: Vendor B scored highest. They just did it with three different relationships to the truth.

The bar chart was accurate but inert. It gave you the conclusion without the evidence. The radar chart was dramatic but distorted. It made the decision feel obvious when it wasn't. The dot plot was plain but complete. It showed you everything and let you decide.

There's a creative element here that people don't talk about. You're not just picking a chart type from a menu. You're thinking through what point needs to be made, what decision is hanging in the balance, and which of the dozens of visualization techniques available to you will drive it home without lying. You have a whole arsenal: bar charts, dot plots, slope graphs, heatmaps, small multiples, diverging stacked bars, you name it. The creative act is matching the problem to the tool.

In this case, the problem was verification. Someone was about to sign a multi-year contract and they needed to be able to defend their choice to an auditor six months later. The creative answer wasn't to make the chart prettier. It was to make the comparison mechanical and transparent. That's why the dot plot worked. It wasn't the flashiest option. It was the right one.

Good data visualization is for making data actionable: for giving someone enough honest information to make a decision, verify the logic, and defend it later if it goes sideways. When a chart makes a decision feel inevitable, you should be suspicious. When it makes the comparison boringly mechanical, you're probably in the right place. The purpose isn't to convince. It's to make the evidence available.

The homework lesson was small: I wrote "I would also explore" and then didn't explore. But the pattern is everywhere. We sketch charts in our heads, describe them in meetings, promise we'll get back to them, and then the quarter moves on and the sentence is just text again.

If I'm actually trying to get better at this work, the sentence isn't the deliverable. The chart is. The rendered, tested, verified chart that someone can actually look at and use.

So I made it. Same data, three different ways of seeing it, one conclusion that never changed. The bar chart said who won. The radar chart showed where they won. The dot plot let you check the math.

Next time I write "I would also explore," I'm going to explore it before I hit submit. Probably on a weekend. Probably for no one. But done, and actually useful.

---

## Sources

- Pierre-Henry Soria, "[Pie vs Dots: A Power System Case Study](https://pierreh.eu/pie-vs-dots-powersystem/)"
- Seaborn, "[Pair grid with dot plots](https://seaborn.pydata.org/examples/pairgrid_dotplot.html)"
- Ed Berinato, "[Visualizations That Really Work](https://d13p3a2zlg772x.cloudfront.net/5b/a6/5ba664bc4fba432849b4910003e8e5177856a4f0?response-content-disposition=inline%3Bfilename%3D%22Berinato%20-%20Visualizations%20That%20Really%20Work.pdf%22&response-content-type=application%2Fpdf&Expires=1789994700&Signature=e22vbvERMC85OXyQ~hzpRG0JxmPmlldvjNFVwa5kQJQc-jnzFGLsdBnbO9rvTrm104AwIzBWmcJAFJF2dkBZD48zZx8aH4fRXGaxktQ6ziKNJ5ViQiNttJgaEvqzsQw83ko9bbhoI555IcmUPMrI9cv-3lfa-OQTLROjrrdVB7SncqnsUikLfT69c~g-S0PtUbK1Bt5L6ivJob-AXRqOWiN6rzKVuFyp~-U86tQPRogOEi8vyKPyIdZeVm5iheH-NDARqD4UaDQXxrGHejFE2-LCynlnruD19Pr-dvqvn3KVdtYBIgm4dsB6-QJVnh2Ask9RUZ16LKKN~5bs1zB89A__&Key-Pair-Id=K3A60Y9EZR4XTT)" (O'Reilly Media)
- Cole Nussbaumer Knaflic, "[Storytelling with Data](https://archive.org/details/storytellingwith0000knaf)"