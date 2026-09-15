---
title: An engineer's valuation of the Mynt/GCash IPO
description: I valued the GCash IPO from the prospectus using the tools from my MBA finance courses, got PHP 2.33 a share against a PHP 10.00 offer, and then had the whole package audited.
tags:
  - finance
  - valuation
  - ipo
  - philippines
  - public-web
source: notes
created: 2026-07-28
updated: 2026-07-28
---

# An engineer's valuation of the Mynt/GCash IPO

![Mynt and GCash at the Philippine Stock Exchange](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/banner.jpg)

*Image credit: [iTech Solution PH](https://www.itechsolutionph.com/).*

***Disclaimer:*** *I use AI as a writing partner to refine my prose and structure, but the ideas, analysis, and first drafts originate entirely with me.*

## The short version

The GCash IPO is priced at PHP 10 a share. I could not get there.

I ran three separate valuation methods on the prospectus. Discounted cash flow to equity gave PHP 2.33. To the firm, PHP 2.08. A method that uses no forecast at all, just the company's own return on equity and two discount rates, gave me a range of PHP 1.71 to PHP 2.25. Three different approaches, entirely different machinery, all landing in the same neighborhood. All of them about a quarter of what investors are being asked to pay.

I let the assumptions I trust least vary and ran the whole model ten thousand times. The median came back at PHP 2.47. The single most favorable of all ten thousand runs reached PHP 5.02. Not one of them cleared PHP 10.

There is one method that does clear it. Put the median peer earnings multiple, around 40 times, on Mynt's 2025 earnings, and you get PHP 10.33, just above the offer. That is what you are buying if you buy at this price. Not the cash flows. The multiple the market is currently paying Sea and Grab.

![Valuation summary: four methods all land at a quarter of the offer price](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v4_football_field.png)

So the honest version of my conclusion is narrow. I cannot tell you the shares are not worth PHP 10. I can tell you that you do not get there from the prospectus using the tools I was taught, and that anyone who does get there is paying for something my model cannot see.

## The disclaimer, first

I am not a finance major. I'm a true blue, full blooded engineer. My corporate finance grounding comes from New Language of Business and Financial Management 1 and 2 in the AIM MBA program, plus some asset leasing and buy-side transaction work in an aviation finance course at UCD Smurfit. This exercise is not comparable to what a practitioner would produce. They have the data subscriptions, the institutional backing, and the judgment that only comes from doing this for a living. I have none of that.

What I have is a working grasp of first principles and more local compute than is reasonable for a student. So this is an MBA student applying textbook methods with minimal Excel, orchestrated almost entirely through large language models running on my own hardware. I like AI and data science, so when the GCash IPO came up, I decided to crack this walnut with a tank. Five AI model tanks, actually.

## Why this one caught my eye

The Mynt IPO landed on my radar a few weeks ago when the filing went public.

GCash began in 2004 as a Globe Telecom SMS-based money transfer service. It is now the largest mobile wallet in the country, used every month by roughly half the adult population and reaching about four times as many people as its nearest competitor. Revenue and net income have both more than doubled since 2023. The business is already profitable, which is not the usual starting point for a wallet going public.

Mynt, Inc. (Globe Fintech Innovations) is the holding company, running the wallet through GXI and a lending arm through Fuse. The cap table is a strategic coalition rather than a venture roster. Globe Telecom and Ant Group hold roughly a third each, and Ayala's joint vehicle with Mitsubishi holds the next largest block, with MUFG, Warburg Pincus, Bow Wave and management behind them. Globe is itself an Ayala and Singtel joint venture, so the Ayala group's interest runs both directly and through Globe. Most of the shares on offer are secondary, sold by existing holders rather than issued by the company.

Two things this makes plain that a list of names does not. Ant's stake is split across two Singapore vehicles that the prospectus footnotes confirm are the same ultimate owner, so the real position is 27.66% rather than the 21.44% that appears at the top of the table. And 87.8% of the company sits with five holders, none of whom is selling out, which is what a 12% float looks like from the inside.

## On size, and on the float

At the top of the indicative range the offer raises about PHP 92 billion, roughly double the PHP 49 billion Monde Nissin raised in 2021. That is a record by proceeds, not by market value. The implied valuation lands near \$11 billion, which would be the largest debut in Philippine history but would still leave Mynt behind ICTSI, SM Investments and BDO once it starts trading. Call it top five, not number one. The indicative price is also a ceiling set for filing purposes. Book-building decides the real number, and earlier reporting had the target closer to \$8 billion.

Mynt is selling 12% of itself, a little under 14% if the overallotment is exercised. That figure is not a preference. It is the legal floor, and it did not exist a year ago. Until February the requirement was a flat 20% for everyone going public. The SEC replaced it with a sliding scale: the smaller the company, the more it has to sell, down to 15% for the largest issuers, with discretion to go as low as 12% for the very biggest. Mynt sits exactly on that floor. The exchange was still writing its matching rules in May, and the offer timeline moved with them.

The trade-off is interesting. Inclusion in the main Philippine index currently requires a 20% float, and the global index providers want something similar. At 12%, one of the largest companies on the exchange sits outside the benchmark that most passive money tracks. Less dilution and thinner day-one supply, bought at the price of that demand.

Jakarta has spent the past year finding out what happens when too little of a company actually trades. Indonesia's benchmark index has the thinnest average free float in Asia-Pacific, with a large share of its members closely held and lightly traded. When most of a stock sits with founders and affiliates, the price is set by a small pool of shares. It moves on little volume, and the index built on top of it stops describing the market it is supposed to describe.

Foreign money noticed. MSCI moved in January to measure Indonesian free float more strictly, and brokers estimated that index funds would have to pull roughly \$2 billion out as weightings fell. By the end of March the Jakarta exchange had rewritten its listing rules, tightening what counts as free float and raising the minimum, after warnings that Indonesia risked losing its emerging-market classification over thin float, unclear ownership and signs of coordinated trading.

So the two regulators moved in opposite directions in the same quarter. Manila lowered its floor to land a listing it had wanted for years. Jakarta raised its floor after a thin float was blamed for a distorted index and a sharp selloff.

Manila's bet is that a small float in a profitable consumer business with millions of users behaves differently from a small float in a closely held holding company. That may well be right. It is also the part of the story no valuation model will tell you.

That is what pulled me into the rabbit hole.

## How this was built

Everything below runs off the prospectus dated 27 June 2026 and a live formula-linked Excel model. Nothing is transcribed by hand. The charts read their numbers from the same file the model writes, so if an assumption changes, the chart changes with it. The workbook and the code are linked at the end for anyone who wants to disagree with a specific cell rather than with the conclusion.

This is not financial advice. It is one model built in the open. Its failure modes are labeled.

## What Mynt actually sells

My initial assumption was wrong. I was valuing a payments company. That is the mental model most of us carry. We scan a QR code. We send money. We pay bills. The audited numbers say something different.

![Adjusted revenue grew 61.1% in 2024 and 47.2% in 2025. In Q1 2026 it slowed to 14.8%. Source: Mynt Preliminary Prospectus, 27 June 2026.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/01_revenue_and_margins.png)

Adjusted Revenues were PHP 33.6 billion in 2023, PHP 54.1 billion in 2024, and PHP 79.7 billion in 2025. These figures exclude the cost of over-the-air prepaid load. Total revenues are higher at PHP 39.9 billion, PHP 62.8 billion, and PHP 79.8 billion. The two series converge in 2025 because the company moved to a platform fee model for prepaid load effective January 1, 2025. I use the Adjusted Revenues series throughout because the company itself treats it as the comparability metric.

Growth is decelerating. It was 61.1 percent in 2024, 47.2 percent in 2025, and 14.8 percent in the first quarter of 2026. That is not a gentle slowdown. My first model assumed 20 percent growth for 2026. The first quarter had already come in well below it.

The margin panel contains the second surprise. Net margin rose from 25.0 percent in the first quarter of 2025 to 27.0 percent in the first quarter of 2026. The press picked that up. Over the same period EBITDA margin fell from 30.6 percent to 28.8 percent. Interest income on deposits rose 54 percent and the effective tax rate dropped from 28.2 percent to 23.6 percent. The improvement in net margin did not come from the business getting better at its business. It came from interest on the cash pile and a lower tax bill.

### The business is becoming a lender

Payment Solutions was 68.7 percent of adjusted revenues in 2023. By the first quarter of 2026 it was 56.8 percent. CreditTech, the lending book behind GLoan and GGives, is now 43.2 percent and climbing.

![Payment Solutions fell from 68.7% to 56.8% of revenue. CreditTech is now 43.2% and climbing. Source: Mynt Preliminary Prospectus.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v1_revenue_mix.png)

The loan book itself grew from PHP 11.9 billion at the end of 2023 to PHP 48.8 billion at the end of March 2026. Four times larger in a little over two years.

The mental model has to change. Mynt is becoming a consumer lender that happens to own the best payment rails in the country. Payments is the acquisition channel and the underwriting dataset. Lending is the engine.

The scale is genuine and I am not disputing it. 40.4 million monthly active users. Roughly 55 percent of Philippine adults. 7.5 million active borrowers.

## Two things I missed before the prospectus

The first draft missed two data points. Both change the valuation narrative.

### The BSP gambling directive

In August 2025 the Bangko Sentral issued Memorandum M2025-029, requiring all supervised institutions to remove in-app access to gambling. The prospectus considers the effect material enough to give it its own defined term, "Affected Revenues," meaning the Payment Solutions revenues hit by the directive.

![Gross transaction value grew 23.2% YoY while Payment Solutions revenue fell 1.5%. Take rate dropped from 0.31% to 0.25%. Source: Mynt Preliminary Prospectus.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v8_take_rate.png)

You can see it in the take rate. Payment monetization ran at 0.24 percent, then 0.28, then 0.30 percent of gross transaction value. In the first quarter of 2026 it was 0.25 percent, against 0.31 percent a year earlier. Volume kept compounding: gross transaction value reached PHP 17.03 trillion in 2025 and PHP 4.75 trillion in the first quarter of 2026, up 23.2 percent year on year.

But Payment Solutions revenue actually fell 1.5 percent year on year, from PHP 11,966.3 million to PHP 11,784.8 million. More transactions, less money. The payments half of the business is currently shrinking in revenue terms.

Before the prospectus, I listed "regulation stays supportive" as an unpriced future risk. It is not a future risk. It already happened, and it is in the numbers I am valuing.

### The lending spread is compressing

Before the prospectus, I presented a net interest margin of 23.4 percent as a structural moat against traditional bank margins of 3 to 5 percent. The moat is real. But the series is 31.5 percent, then 26.1, then 23.7, then 23.4. It has fallen by eight percentage points in just over two years, and I showed only the last point.

![Net interest margin fell from 31.5% to 23.4% in just over two years. A drop of eight percentage points. Source: Mynt Preliminary Prospectus.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v2_credit_economics.png)

**Key insight.** The valuation question is not "what is a payments network worth?" It is "what is a fast-growing consumer lender worth, when its payments engine has stopped monetizing and its lending spread is compressing every year?" Those are very different questions.

## The one number that looked like good news

Credit quality is now observable rather than guessed at. The non-performing loan ratio was 7.5 percent at the end of 2025 and 5.1 percent at the end of March 2026, where non-performing means more than 90 days past due. The prospectus describes this as "a sharp decline."

![Headline NPL ratio fell while management raised the cushion. NPL ratio: 7.5% to 5.1%. Allowance on performing loans: 3.64% to 5.57%. Source: Mynt Preliminary Prospectus.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/10_npl_writeoffs.png)

It is the single most favorable operating datapoint in the document, so I went looking for the note behind it.

The full series tells a different story. The ratio was 9.2 percent at the end of 2023, dropped to 4.8 percent at the end of 2024, rose to 7.5 percent at the end of 2025, then fell to 5.1 percent at the end of March 2026. That is a ratio bouncing inside a wide band, not a clean deterioration. Today's 5.1 percent is well below where the disclosure starts.

But what actually moved the ratio matters more. Here is the roll-forward of loans in default over the first quarter of 2026:

| Q1 2026, loans in default (PHP millions) | Amount |
|---|---|
| Opening balance | 3,578.7 |
| Collections | (276.1) |
| **Write-offs** | **(3,397.9)** |
| Transfers out | (20.2) |
| **New defaults formed** | **+2,996.4** |
| Closing balance | 2,880.9 |

Mynt wrote off PHP 3,397.9 million of defaulted loans during the quarter, while PHP 2,996.4 million of fresh loans rolled into default. The numerator fell by PHP 697.8 million only because the write-offs slightly exceeded the new arrivals. Over the same three months the gross book grew 17.0 percent, which enlarged the denominator.

The ratio improved because bad loans were removed from the top and good loans were added to the bottom. Borrower behavior did not have to improve for that to happen.

### The better question

A single quarter cannot be compared with a full year on default formation, since a loan written inside a three-month window cannot be ninety days overdue by the end of it. When a loan book nearly triples in a year, normalizing against the opening balance is meaningless.

Average balances are the standard basis, and the prospectus uses them itself: its own net interest margin is defined on average on-book gross loans. On that basis, comparing full year against full year:

| Against the average gross book | 2024 | 2025 |
|---|---|---|
| New defaults formed | 22.6% | **35.3%** |
| Written off | 16.5% | **25.1%** |

Both rose sharply. Measured against the opening balance instead, both appear to fall slightly, which is the answer I published before I checked what the denominator was.

One honest qualification. Even average balances flatter 2024, because a book growing 173 percent was small for most of the year. Direction: worsening. Magnitude: uncertain.

### Provisioning tells the same story

Provisions as a share of revenue rose from 13.7 percent in 2023 to 19.3 percent in the first quarter of 2026, but that ratio partly measures business mix since CreditTech went from 32 to 43 percent of the company. The metric that isolates credit is the cost of risk: provisions against the average gross loan book.

| Provisions as % of average gross loans | Rate |
|---|---|
| 2024 | 25.3% |
| 2025 | 29.0% |
| Q1 2026, annualized | 30.8% |

Nearly a third of the book is expected to go bad annually. That is not a distressed number for this kind of lending, because the yields are high enough to carry it. It is still worth sitting with.

**Key insight.** The clearest signal is in the provisioning against loans that have not defaulted. Allowance held against performing loans was 4.06 percent at the end of 2024 and 3.64 percent at the end of 2025. At the end of March 2026 it was **5.57 percent**. Management sharply increased the cushion on loans that are still paying. That is what a lender does when it expects deterioration it has not yet seen.

The provisioning looks honest rather than aggressive. Coverage of defaulted loans has been stable and high throughout, at 92.9, 93.7, and 94.5 percent. Nobody is hiding losses, and writing off unrecoverable loans promptly is correct accounting.

But putting the pieces together, the picture is not reassuring. The headline ratio improved for mechanical reasons. Default and write-off intensity rose on the proper denominator. Provisions are approaching a fifth of revenue. And management raised its own cushion on performing loans by nearly two percentage points in three months.

One related detail worth carrying forward: the MD&A attributes part of revenue growth to recoveries on loans written off in earlier periods. So heavy write-offs today feed reported revenue tomorrow, which flatters growth in exactly the periods following a bad vintage.

## The discount rate, and the mistake I nearly made twice

In the earlier draft, I assumed Mynt had no debt, could not verify it, and said plainly that it was the weakest link in the model. If there were meaningful borrowings at a rate below my discount rate, I wrote, the true cost of capital would be lower and every valuation would be too low.

The prospectus settles it. **Total debt is PHP 20,750.2 million** as of 31 March 2026: PHP 19,350.2 million current and PHP 1,400.0 million non-current. These are unsecured loans from local and international banks bearing **5.0 to 6.5 percent**, typically repayable within twelve months, plus a three-year term loan of PHP 1,750.0 million from the Asian Development Bank to fund MSME lending. [Prospectus, pp. 88, 117, 142, 171]

So I was wrong, in the direction I predicted. I expected that to rescue the valuation. It did almost nothing, and the reason is a pitfall from my own coursework.

### Cost of equity, from CAPM

The risk-free rate plus beta times the equity risk premium: 7.26 percent plus 1.6 times 6.7 percent, which is **17.98 percent**.

| Input | What it is | What I used | Source |
|---|---|---|---|
| Risk-free rate | The return on lending to the government instead | 7.26% | PH FXTN 10-year government bond yield, 14 July 2026 [Trading Economics] |
| Beta | How much the equity moves when the market moves | 1.6 | Midpoint of Sea, PayPal and Adyen. Mynt has never traded. [Assumption] |
| Equity risk premium | What equity investors demand over that risk-free return | 6.7% | Damodaran country premium for the Philippines, the figure I used in FM2 [Assumption] |

### Weighted average cost of capital

The debt weight times the after-tax cost of debt, plus the equity weight times the cost of equity.

After-tax cost of debt is 5.75 percent times 0.75, or 4.31 percent, using the midpoint of the disclosed range and the 25 percent CREATE Act rate. [Computed]

Now the weights, which is where it gets interesting.

| Basis | Debt weight | Equity weight | WACC |
|---|---|---|---|
| **Market value** (equity at the PHP 10 offer) | 3.0% | 97.0% | **17.57%** |
| Book value (from the capitalization table) | 22.0% | 78.0% | 14.97% |

The capitalization table shows PHP 20,750.2 million of debt against PHP 73,519.5 million of book equity, which is a 22 percent debt weight. That is the number it is tempting to use, because it is the one printed in the document.

It is also the wrong one. Market-value weights are required, and at the offer price the equity is worth PHP 668.96 billion, which makes the debt **3.0 percent** of total capital. So discovering PHP 20.75 billion of borrowings moved my discount rate from 17.98 percent to 17.57 percent. Forty-one basis points.

I find this genuinely funny, because the earlier draft contained a pitfalls table with this exact line in it:

| Common error | What it does | Correct approach |
|---|---|---|
| Using book value weights in WACC | Misstates the true cost of capital | Use market-value weights |
| Using a borrowed beta without adjustment | Imports a peer's business and financial risk wholesale | Unlever the peer beta, relever at the target's structure |
| Treating one discount rate as precise | Creates false confidence in a single output | Run a sensitivity grid and report the range |

I wrote that rule down, and then the moment real debt appeared I wanted to apply it the wrong way, because the wrong way happened to help the company. For the record, even at the book-weight WACC of 14.97 percent the valuation comes to PHP 2.56 a share, which changes nothing about the conclusion.

**Caution.** A large debt figure looks dramatic until you see the equity it sits beside. PHP 20.75 billion is a lot of money. It is also 3 percent of a company the market is pricing at nearly PHP 670 billion.

## The cash flow, and the trap inside it

The largest apology in the earlier draft is this: I did not have free cash flow. Mynt had not disclosed EBITDA, capital expenditure, or the change in working capital, so I proxied free cash flow as revenue times net margin, said clearly that this was net income wearing a different label, and warned that it flattered the company.

The prospectus has all three. It also has a trap in it.

### The reported cash flow statement is unusable

Net cash from operating activities reads: plus PHP 23.5 billion in 2023, minus PHP 38.1 billion in 2024, plus PHP 14.2 billion in 2025, and minus PHP 12.9 billion in the first quarter of 2026. Negative in two of four periods, for a business that was profitable in all four.

That is not distress. It is float. Mynt is an e-money issuer, so customer balances run through operating activities. Cash held in trust went from PHP 1.0 billion to PHP 78.9 billion over the period, and liabilities to partners and users sit near PHP 100 billion. Those two swing violently and have nothing to do with whether the business generates cash.

So rather than strip float out of the reported statement, I built cash flow from the top. **Free cash flow to the firm** is operating profit after tax, plus depreciation and amortization, less capital expenditure, less the increase in the loan book, less the change in working capital.

Excluding cash held in trust and liabilities to partners and users from working capital entirely, since they are a matched pair belonging to the e-money business rather than to operations.

### The reinvestment line is the loan book, not capex

![Loan book growth consumes PHP 6,190M of forecast 2026 cash, versus PHP 279M net for depreciation less capex. Source: Mynt Preliminary Prospectus.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v3_earnings_vs_cash.png)

Capital expenditure was PHP 298.1 million, PHP 520.7 million and PHP 456.7 million across the three years. That is under one percent of revenue. Depreciation now exceeds it. By the standards of a normal DCF this company barely reinvests at all.

That reading would be badly wrong.

The loan book grew PHP 22.2 billion in 2024 and PHP 7.1 billion in 2025. For a lender, that **is** the reinvestment. Every peso lent leaves the business before it returns as income, and a book growing this fast consumes cash exactly the way a factory build-out would.

Run the arithmetic on 2025 and the picture is stark:

| 2025, PHP millions | Amount |
|---|---|
| EBIT x (1 - 25%) | 14,797.3 |
| plus D&A | 699.3 |
| less capex | (456.7) |
| less loan book growth | (7,122.6) |
| **Sustainable FCFF** | **7,917.3** |
| Memo: net income | 17,248.5 |
| **Cash conversion** | **46%** |

Forty-six percent, and that treats the working capital release of PHP 7,189.0 million as non-repeatable, which it is, because working capital excluding float is already down to PHP 669.5 million and cannot fall much further. Include it and 2025 conversion looks like 88 percent. Exclude it and 2024 conversion is **negative**.

In the earlier draft I guessed at a cash conversion factor between 0.60 and 1.00, centered on 0.85. The real number is around 0.46 and it is driven almost entirely by how fast the loan book grows.

### The result, and why I do not trust it

On this basis, with the market-weight WACC of 17.57 percent and terminal growth of 4.5 percent, enterprise value comes to PHP 120.8 billion. [Computed]

Getting from there to a share price needs one more step that I initially got wrong. Enterprise value has to be adjusted for debt **and for cash**. I subtracted the PHP 20.75 billion of debt and forgot the cash, which is a real omission here because EBIT excludes interest income on deposits, so neither the cash nor its earnings appear anywhere in the projected flows. Leave it out and it simply vanishes from the valuation.

Working out how much cash is genuinely available turned out to need less care than I gave it. My first pass derived it: cash of PHP 67.8 billion, less the PHP 25.6 billion shortfall between the PHP 99.6 billion owed to partners and users and the PHP 74.0 billion held in trust, leaving PHP 42.2 billion. Then an audit pointed out that the company states the number outright. Printed page 35: of the total cash and equivalents, **PHP 39.2 billion** represents corporate cash at 31 March 2026, defined as balances not considered customer-related. My derivation was PHP 3.0 billion too generous. I use the disclosed figure. [Prospectus, p. 35]

Enterprise value PHP 120.8 billion, less PHP 20.75 billion of debt, plus PHP 39.2 billion of cash, over 66,895,913,057 shares, gives **PHP 2.08 per share**. [Computed]

That is 79 percent below the offer. It is also the point where I stopped and asked whether the instrument was right, rather than reaching for the conclusion.

**Caution.** Damodaran is explicit that free cash flow to the firm, discounted at WACC, is the wrong frame for financial service firms. For a lender, debt is raw material rather than financing, and reinvestment is loan book growth rather than capital expenditure. Mynt is now 43.2 percent CreditTech with a PHP 48.8 billion book funded partly by borrowings. By his own rule, the model I just built does not apply to it.

The mismatch is mechanical and it is visible in my own numbers. FCFF charges the full cost of growing the loan book against cash flow, while market-value weights leave debt at 3.0 percent of capital, so the cheap funding that pays for that growth never reaches the discount rate. The model is penalized twice for the same peso.

So PHP 2.08 is what a wrong instrument reports. I have kept it in the football field because deleting an inconvenient number is not a method, but it should carry a warning label.

### Doing it the way he would

Value the equity directly instead. **Free cash flow to equity** is net income, plus depreciation and amortization, less capital expenditure, less the increase in the loan book, plus the new debt raised to fund part of that increase.

Discounted at the cost of equity, 17.98 percent. Debt currently funds 42.5 percent of the loan book (PHP 20,750.2 million against PHP 48,792.8 million), so growth in the book is assumed to be funded in the same proportion. [Computed]

That gives **PHP 2.33 per share**. [Computed]

Then a third opinion that uses no cash flow forecast at all. The Gordon growth relation puts justified price-to-book at return on equity less growth, over cost of equity less growth: 32.1 less 4.5, over 17.98 less 4.5, which is **2.05 times**.

Against book equity of PHP 73.5 billion, that is **PHP 2.25 per share**. [Computed]

That figure needs one caveat, because it depends on which equity base the return is struck against. The 32.1 percent is the prospectus's own return on **average** equity, and I have applied the resulting multiple to **ending** book value, which mixes two bases. Recompute the return on ending equity and it is 25.5 percent, the justified multiple falls to 1.56 times, and the answer is **PHP 1.71**. Equity grew 69 percent during 2025, so a return struck on the smaller average base will not repeat on the larger one. I therefore treat this method as a range of **PHP 1.71 to PHP 2.25** rather than a point, and the lower end is arguably the more honest anchor.

FCFE at PHP 2.33 sits just above that range. FCFE forecasts five years of cash flow and a terminal value; justified price-to-book uses one year of return on equity and two rates.

![Each teal bar is one discounted year. The cerise bar is everything after 2030, compressed into a single Gordon-growth number, and it carries most of the total.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v5_sensitivity.png)

I want to be honest about how independent that really is. They are not entirely separate opinions: both use the same cost of equity, the same terminal growth, and the same earnings base. What makes the agreement meaningful is that they reach the answer through different machinery, and that their implied payout ratios line up. The justified multiple assumes the company retains 14 percent of earnings, since growth of 4.5 percent on a 32.1 percent return implies that. My FCFE model, built from the loan book upward, converts about 80 percent of 2026 net income into distributable cash. That is a different measure from the retention implied by the multiple, so I am no longer calling it a convergence, an audit was right that I had been comparing two things that are not the same. It is a coincidence of magnitude, not a second opinion.

An independent FCFE model built on different assumptions landed at PHP 3.37 against my PHP 2.33. The PHP 1.04 gap decomposes almost entirely into two offsetting items: that model uses a cost of equity 267 basis points lower than mine, and mine adds a PHP 39.2 billion corporate-cash balance that the other does not. Two models with different frameworks, discount rates, and cash treatments agreeing within 30 percent is a genuine convergence result. It is worth saying so.

Note also that neither of these adds cash back, and that is deliberate. Net income already contains the interest earned on deposits, so the cash is working inside the flow. Adding the balance on top would count it twice. The cash adjustment belongs to the enterprise-value methods only.

And across the full plausible range of the two assumptions I am least sure about, nothing approaches PHP 10. The most generous corner of that grid, a 12 percent cost of equity with 6 percent perpetual growth, does not get close.

![Implied value per share across a cost of equity from 12% to 20% and terminal growth from 3% to 6%. The offer price does not appear anywhere on the grid.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v6_reverse_dcf.png)

The offer price prices this equity at **9.6 times adjusted tangible book** (PHP 1.04 per share, after the LTIP issuance and the June 2026 dividend). The justified multiple, on the company's own return on equity, is between 1.56 and 2.05 times depending on which equity base you strike it against.

## The cash question

The PHP 39.2 billion cash add-back represents 28 percent of the FCFF value per share. It is the single largest upward force in the model, and the claim that it is distributable to equity is not established.

Three things in the prospectus cut against it:

- **Printed page 44, verbatim:** wallet funds "are held in more liquid assets and cannot be used to facilitate lending." This is a regulated e-money balance sheet, not a corporate treasury.
- The only observable distribution is the **PHP 5,001.2 million** dividend declared 17 June 2026, which is 12.8 percent of the disclosed corporate cash balance. [Prospectus, p. 84]
- In March 2026 FUSE borrowed **PHP 1,750.0 million** from the ADB on a three-year term to fund MSME lending. [Prospectus, p. 142] That is not the behavior of a company sitting on 42 billion of surplus cash.

I model three scenarios:

![FCFF model at three readings of the cash balance. This is the single largest lever in the analysis.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/e_free_cash_scenario.png)

| Free-cash treatment | PHP per share (FCFF) | PHP per share (EV/EBITDA comps, median) |
|---|---|---|
| 100% free (original) | PHP 2.08 | PHP 6.11 |
| 50% free | PHP 1.79 | PHP 5.79 |
| 0% free (strict) | PHP 1.50 | PHP 5.48 |

FCFE is unaffected by this assumption since net income already contains interest earned on deposits. At 0 percent free, FCFF falls to PHP 1.50. The offer remains 6.7 times that figure.

I keep the 100 percent case as the headline because it is the assumption a buyer would make reading the balance sheet cold, and because deleting an inconvenient number is not a method. But the strict reading is the one the prospectus text actually supports, and it takes the firm-side answer down to PHP 1.50. Note too that BSP Circular No. 1166 requires at least half the outstanding e-money balance to sit in trust, so even the corporate-cash figure is not free of regulatory claim. Nothing in this section moves the equity-side answer at all, which is part of why I trust the equity side more.

## What the market pays for companies like this

The cash flow work asks what the business is worth on its own terms. Comparables ask a more modest question: what are investors currently paying for businesses that look like this one? It replaces my assumptions with the market's, which is not the same as replacing them with the truth, but it is a genuine second opinion.

The peer set is the regional platform and payments group: Sea Limited, Grab, GoTo and PayPal. None of them is a clean match, and I want to say that plainly rather than bury it.

I also have to open with a confession. In the earlier draft I used a "peer average" of 19 times EBITDA and 36.6 times earnings. Those numbers came from press coverage. They traced to nothing I could point at, and when I finally went and pulled the multiples myself they did not survive.

Mynt's 2025 EBITDA margin of 25.6% is above every peer in the set. The margin comparison is the strongest fact in Mynt's favor anywhere in this analysis, and the prospectus confirms it rather than weakening it. Audited 2025 EBITDA was **PHP 20,429.0 million** on adjusted revenues of PHP 79,670.5 million, a margin of 25.6 percent. [Prospectus, p. 37] Against sourced peer figures that is PayPal at 20.85 percent, GoTo at 12.0 percent and Grab at 11.25 percent. [Peer, not from prospectus]

Those peer margins are lower than the ones I published in the earlier draft, where I had Grab and GoTo in the mid-teens. The corrected numbers make Mynt's advantage larger, not smaller. I have dropped Sea from the chart because I could not source a comparable EBITDA margin for it, and I would rather show three sourced bars than four with one invented.

One caveat on the comparison itself. Mynt's EBITDA comes from the prospectus definition, which explicitly subtracts interest income on deposits. The peer figures come from three different data providers, each with its own adjustments, and none of them is likely to strip out that item. So Mynt's 25.6 percent is measured on a stricter basis than the bars beside it. The direction of that bias favors Mynt, meaning the real gap is if anything wider than the chart shows, but it is a comparison of things that were not defined the same way and I would not read the individual gaps too precisely.

I will note with some relief that my earlier draft had to assume this figure, guessed 25.4 percent, and derived implied EBITDA of PHP 20.24 billion. The audited number is PHP 20.43 billion. That estimate was within one percent, so the comparables work from before stands.

So Mynt is not asking to be valued as a regional super-app that might one day reach profitability. It is already more profitable than the companies it would be compared against. That is a legitimate argument for a premium multiple and any fair analysis has to concede it.

### The peer average was hiding the whole argument

Here is what the peers actually trade at, pulled in July 2026, with what each one implies for Mynt:

![What peer multiples imply for Mynt per share. Growth platforms: PHP 7-11. Mature payments: PHP 2-2.20.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v7_comps.png)

| Peer | P/E implies | EV/EBITDA implies |
|---|---|---|
| PayPal | 7.8x **PHP 2.01** | 6.1x **PHP 2.19** |
| GoTo | not meaningful | 15.1x PHP 4.93 |
| Sea Limited | 40.1x PHP 10.33 | 22.8x PHP 7.29 |
| Grab | 43.0x **PHP 11.09** | 23.5x **PHP 7.48** |

An average of those describes no company that exists. PayPal trades at a seventh of Sea's earnings multiple. Averaging a mature, de-rated payments processor with two growth platforms produces a number that is not a valuation, it is a compromise between two incompatible views of what Mynt is.

And that is the point, so it is worth stating plainly. **The comparables do not answer the question. They restate it.**

If Mynt is a growth platform in the mold of Sea or Grab, the comps say something between PHP 7.29 and PHP 11.09, and the offer price is inside that range. If Mynt is a maturing payments business with a lending book, which is what PayPal is, the comps say **PHP 2.01 to PHP 2.19**, sitting almost exactly on top of my cash-flow methods.

I did not engineer that. PayPal's multiple and my discounted cash flow arrive at the same place from opposite directions.

Two caveats on the data. Providers disagree materially on two of the four: Sea's EV/EBITDA is reported anywhere from 19.34x to 26.27x, and GoTo's from 15.1x to 41.96x. I have used midpoints for Sea and the lower figure for GoTo, and I would not defend any of these to two decimal places. And all of it is a July 2026 snapshot of a market that reprices daily, which is a different kind of evidence from an audited annual figure.

The gap between the enterprise-value and the earnings multiples is also real, and it is worth slowing down on.

Enterprise-value multiples value the operating business. Price-to-earnings values the bottom line. For most companies the two track each other. For Mynt they diverge because the earnings quality question sits precisely between them. A lender books interest income today against loans that may default tomorrow, and provisioning decisions determine how much of that reaches net income. The P/E route accepts the reported PHP 17.2 billion at face value. The EV/EBITDA route is stricter about what counts as operating profit.

**Key insight.** The peer set splits along exactly the question this whole post is about. Growth-platform multiples put Mynt near the offer price. Mature-payments multiples put it near PHP 2. Choosing between them is not a modeling decision, it is a judgment about what kind of company this is becoming, and the prospectus says it is becoming a lender whose payments arm has stopped monetizing.

What the offer price actually implies, against the audited figures:

![What the offer price implies against audited figures and peer references.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v9_value_bridge.png)

| Measure | At the PHP 10 offer | Peer reference |
|---|---|---|
| Price / earnings, trailing | 38.8x | 7.8x to 43.0x |
| Price / earnings, 2026E | 33.7x | |
| Price / earnings, 2027E | 29.8x | |
| EV / EBITDA | **31.7x** | 6.1x to 23.5x |
| Price / adjusted tangible book | **9.6x** | justified 1.56x to 2.05x |

The offer sits above every peer on both measures except Grab's earnings multiple. On enterprise value to EBITDA, 31.7 times is above all four peers, including both growth platforms.

A note on the forward multiples, because I had these wrong too. My earlier draft quoted about 32 times on 2026 estimates and 27 times on 2027, which came from coverage assuming roughly 20 percent growth. On my own growth path, anchored to the 14.8 percent the first quarter actually printed, they are 33.7 and 29.8 times. Slower growth means the multiple compresses more slowly, so the forward path is less reassuring than the numbers I first repeated.

### Are these earnings arm's length?

Globe and Ant between them own roughly two thirds of Mynt, and both sell to it and buy from it. So before accepting reported earnings at any multiple, it is worth asking how much of the revenue is set by negotiation among owners rather than by a market.

The answer is less alarming than I expected, and the trend runs the right way.

![Ownership structure and related-party revenue trends.](assets/an-engineers-valuation-of-the-mynt-gcash-ipo/v12_ownership.png)

| Related-party revenue | 2023 | 2024 | 2025 | Q1'26 |
|---|---|---|---|---|
| Total, PHP millions | 4,573.8 | 4,499.6 | 5,648.2 | 1,508.8 |
| **Share of Adjusted Revenues** | **13.6%** | **8.3%** | **7.1%** | **7.3%** |

Related-party revenue has fallen from 13.6 percent of the business to about 7 percent. [Prospectus, pp. 297-298] The largest single line is the load service fee Mynt earns from Globe for airtime top-ups, and it is flat in absolute terms at roughly PHP 3.5 billion a year, which means it shrinks as a share of a growing company: 10.6 percent of revenue in 2023, 4.5 percent in 2025. The company is becoming less dependent on its owners, not more.

The prospectus asserts arm's-length terms, says material transactions are supported by a transfer pricing report using recognized benchmarking methods, and maintains a Related Party Transactions Committee. There is also a risk factor devoted to the possibility that related parties fail to act on fair terms, or that tax authorities challenge the transfer pricing. I have no basis to dispute any of it and I am not going to imply otherwise.

One item is worth flagging, not as an accusation but because it is unusual. Two lines appeared in 2025 that did not exist in 2024, both with Ant-affiliated counterparties. Merchant discount rate income from Alipay Connect went from zero to PHP 1,636.8 million, which is 6.4 percent of the year's entire revenue growth. In the same year, maintenance and platform service fees paid to an affiliate went from zero to PHP 1,268.8 million of expense. The two roughly offset, so the effect on profit is about PHP 368 million.

Separately, an affiliate API fee line that produced PHP 677.1 million in 2023 and PHP 835.8 million in 2024 went to zero in 2025.

**Key insight.** These arrangements appear, grow, and vanish year to year. That is not evidence of anything improper, and the disclosure is thorough. But it does mean a slice of the revenue line is governed by agreements among shareholders rather than by customers, and it is one more reason to prefer the enterprise-value methods over taking reported earnings at face value.

None of this changes my valuation. Seven percent of revenue on an improving trend is a quality-of-earnings footnote, not a thesis.

A few pitfalls I tried to avoid, and one I could not:

| Pitfall | Why it matters here | What I did |
|---|---|---|
| Comparing to listed peers without a liquidity adjustment | Listed multiples embed liquidity that a 12 percent float does not provide | Noted, not quantified. I had no defensible discount. |
| Averaging a widely dispersed peer set | An average of 6x and 43x describes nothing | Fixed in this version. I report each peer and the range. |
| Using multiples that trace to no source | Numbers get repeated until they sound official | Fixed. Every multiple now has a provider and a date, and none of them is from the prospectus. |
| Using trailing earnings for a fast-growing company | Trailing P/E looks expensive by construction when earnings compound | Reported the forward path on my own growth assumptions: 33.7x on 2026, 29.8x on 2027 |
| Picking peers that favor the conclusion | Peer selection is where bias enters unnoticed | Fixed the regional set before seeing results and did not adjust it |
| No listed Philippine comparable exists | Nothing on the PSE resembles this business | Unresolved. A real limitation. |

That last row deserves more than a table cell. There is no listed Philippine company that looks like Mynt. The PSE's large caps are banks, conglomerates, property and utilities. Every multiple above is imported from a company operating in a different market, with a different regulator, a different currency and a different investor base.

One final comparison, which I find more informative than any multiple, and which I can now source properly. Before the prospectus, I said Ayala and MUFG invested at about five billion dollars in August 2024, taken from press coverage. The prospectus documents the transaction directly: in **September 2024**, MUFG Bank subscribed to 64,205,070 common shares for US\$160,000,333, representing 3.26 percent of issued and outstanding capital. [Prospectus, p. 85] That implies a valuation of about **US\$4.91 billion**. [Computed]

At PHP 10 the IPO prices the company at about US\$11.0 billion. Over that period net income grew from PHP 11.1 billion to PHP 17.2 billion, an increase of roughly 55 percent, while the valuation rather more than doubled.

Value rose faster than earnings. The difference is multiple expansion, which is the market paying more for each peso of profit than it did two years ago. That can be justified by a genuinely improving business, but it cannot be derived from one.

## What you are buying

Let me be very direct about this. If you buy Mynt at PHP 10, you are not buying a company that generates PHP 2.33 of distributable cash per share today. You are not buying a company that the Gordon relation, which uses no forecast at all, justifies at more than PHP 2.25.

You are buying the expectation that the growth platform multiples of Sea and Grab apply to a company that is becoming a consumer lender. You are buying the expectation that the PHP 39.2 billion of corporate cash is distributable, despite the prospectus itself saying wallet funds cannot facilitate lending. You are buying the expectation that a 31.7x EV/EBITDA multiple, above every peer in the set, is the starting point rather than the ceiling.

Any one of those expectations could be correct. All of them together is a tall order.

The cash flow methods tell you what the business generates. The peer methods tell you what the market is willing to pay for stories like this one. The gap between PHP 2.33 and PHP 10 is not a calculation error. It is the price of narrative.

I can live with that. I just cannot pretend it is what valuation is for.

## A personal note

I started this because I wanted to understand a number on the front page. I ended up understanding a company, and a bit more about the difference between what a business is worth and what a market will pay for it. The first is an engineering problem. The second is not.

If you are a retail investor deciding whether to buy GCash shares, my model says the price is high. But my model is one MBA student's spreadsheet, built on assumptions I cannot fully defend and a discount rate I borrowed from peers. I am not qualified to tell you what to do with your money. What I am qualified to tell you is how I got where I got, and why I stopped where I stopped.

The rest is your judgment.

---

## Sources

- Mynt Preliminary Prospectus, 27 June 2026: https://pse.com.ph/
- Philippine 10-year government bond yield: https://tradingeconomics.com/philippines/government-bond-yield
- Damodaran country risk and equity risk premium data: https://pages.stern.nyu.edu/~adamodar/
- Sea Limited, Grab, GoTo, PayPal peer multiples: various provider data as of July 2026
- Original post: https://kvallespin.github.io/finance/an-engineers-valuation-of-the-mynt-gcash-ipo
