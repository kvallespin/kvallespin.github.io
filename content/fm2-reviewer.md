---
title: FINMA202 Oral Exam Master Reviewer
cssclasses:
  - wide-page
created: 2026-06-03
course: FINMA202 Financial Management 2
instructor: Prof. Jose Vicente Camus
program: AIM OMBA 2026B
---

# FINMA202 · Financial Management 2 — Oral Exam Master Reviewer

> *Prepared by: Engr. Kenneth Vallespin (Ken)*

> **Exam Topics (order: WACC → Relevant Cashflows → Real Options → Distribution Policy → Capital Structure → M&A → LBO)**
> *This reviewer synthesizes faculty slides (Sessions 1–16), textbook readings (Brigham & Ehrhardt Asia Ed., Ch. 14, 15, 22), and all five case studies.*

---

## Table of Contents

1. [[#1. WACC — Weighted Average Cost of Capital]]
2. [[#2. Relevant Cashflows — Capital Budgeting]]
3. [[#3. Real Options Analysis]]
4. [[#4. Distribution Policy — Dividends & Alternatives]]
5. [[#5. Capital Structure]]
6. [[#6. Mergers & Acquisitions (M&A)]]
7. [[#7. Leveraged Buyouts (LBO)]]
8. [[#Section 2 — Textbook Reading Highlights]]
9. [[#Section 3 — Case Studies]]

---

# SECTION 1 — FACULTY SLIDES REVIEWER

---

## 1. WACC — Weighted Average Cost of Capital

> *Session 2 | "WACC is the firm's overall required return from all capital providers."*

### 1.1 What Is WACC and Why It Matters

WACC (Weighted Average Cost of Capital) represents the blended required return across all capital providers — debt, preferred stock, and equity — weighted by their respective shares of total firm value. It is simultaneously:

- The **hurdle rate** for new investment: a project must earn at least WACC to create value
- The **discount rate** in DCF valuation
- The **minimum required return** to compensate investors for the risk they bear

> 💡 **Key insight:** Value is only created when returns *exceed* WACC. If ROIC < WACC, the firm destroys value even if it is profitable.

---

### 1.2 The Core WACC Formula

$$\boxed{WACC = w_d \cdot r_d(1-T) + w_{ps} \cdot r_{ps} + w_e \cdot r_e}$$

| Variable | Meaning |
|---|---|
| $w_d, w_{ps}, w_e$ | Market-value weights of debt, preferred stock, and equity |
| $r_d$ | Pre-tax cost of debt (YTM or loan rate) |
| $T$ | Marginal corporate tax rate |
| $r_{ps}$ | Cost of preferred stock |
| $r_e$ | Cost of equity (via CAPM or DGM) |

> ⚠️ **Always use market-value weights**, not book-value weights.

---

### 1.3 Cost of Debt

$$\boxed{r_d^{after-tax} = r_d \times (1 - T)}$$

- For **bonds**: use the Yield-to-Maturity (YTM) — the IRR if held to maturity
- For **bank loans**: use the contractual interest rate; if multiple loans, use a weighted average

$$\boxed{YTM: \quad P_0 = \sum_{t=1}^{N} \frac{C}{(1+r)^t} + \frac{F}{(1+r)^N}}$$

| Symbol | Meaning |
|---|---|
| $P_0$ | Current market price of the bond |
| $C$ | Annual coupon payment |
| $F$ | Face (par) value at maturity |
| $N$ | Years to maturity |
| $r$ | YTM (solve via IRR function in Excel) |

**Multiple debt components — weighted average:**
$$r_D = W_1 \cdot r_1 + W_2 \cdot r_2 + \ldots \quad \text{where } W_i = \frac{\text{Loan}_i}{\text{Total Debt}}$$

> ⚠️ **Do NOT use coupon rate as cost of debt** — use current market YTM.

---

### 1.4 Cost of Preferred Stock

$$\boxed{r_{ps} = \frac{D_{ps}}{P_0}}$$

| Symbol | Meaning |
|---|---|
| $D_{ps}$ | Annual preferred dividend per share |
| $P_0$ | Current market price per preferred share |

> Note: Preferred dividends are **not** tax-deductible, so **no tax adjustment**.

---

### 1.5 Cost of Equity — Two Methods

#### Method A: Dividend Growth Model (Gordon Growth Model / DGM)

$$\boxed{r_e = \frac{D_1}{P_0} + g}$$

| Symbol | Meaning |
|---|---|
| $D_1$ | Next expected dividend = $D_0(1+g)$ |
| $P_0$ | Current stock price |
| $g$ | Constant dividend growth rate (in perpetuity) |

**When to use:** Firms with stable, predictable dividend streams.

**Limitations:**
- Not suitable for non-dividend-paying firms
- Highly sensitive to the growth rate assumption
- Assumes perpetual constant growth (unrealistic for many firms)

---

#### Method B: Capital Asset Pricing Model (CAPM)

$$\boxed{r_e = r_f + \beta \cdot (r_m - r_f)}$$

| Symbol | Meaning |
|---|---|
| $r_f$ | Risk-free rate (e.g., 10-yr Philippine T-bond FXTN 10-73 @ 6.375%, Aug 2025) |
| $\beta$ | Beta — sensitivity of stock return to market movements |
| $r_m - r_f$ | Market Risk Premium (MRP) / Equity Risk Premium |
| $\beta(r_m - r_f)$ | Risk premium for bearing systematic risk |

> 📌 **Philippine practice**: Use FXTN 10-year benchmark as risk-free rate. MRP from Damodaran (NYU Stern) — for Philippines: ~6.69% (Jan 2026).

**Beta characteristics:**
- $\beta > 1$: more volatile than market
- $\beta < 1$: less volatile than market
- $\beta = 1$: moves with the market

**Limitations of Beta:** Backward-looking; unstable over time; ignores unsystematic risk; distorted by capital structure.

---

#### Putting CAPM Together — Example from Slides

| Input | Value | Source |
|---|---|---|
| Risk-free rate | 6.375% | FXTN 10-73, BSP Aug 2025 |
| Beta (IT industry) | 1.1 | Assumed |
| MRP | 6.690% | Damodaran, Jan 2026 |
| **Cost of Equity** | **13.734%** | \$6.375 + 1.1(6.69)$ |

---

### 1.6 Small Company Premium (SCP)

$$\boxed{r_e = r_f + \beta(MRP) + SCP}$$

Use for small-cap, privately held, or illiquid sector firms. Do NOT use for large mature public companies.

---

### 1.7 WACC — Common Pitfalls

| Wrong | Correct |
|---|---|
| Use coupon rate as cost of debt | Use YTM / current market rate |
| Use book-value weights | Use market-value weights |
| Apply one WACC to all projects | Adjust for project-specific risk |
| Ignore tax shield | After-tax cost of debt = $r_d(1-T)$ |

---

## 2. Relevant Cashflows — Capital Budgeting

> *Session 3 | "Will this cash flow occur only if we accept the project?"*

### 2.1 The Incremental Cashflow Principle

> **"Will this cash flow occur ONLY if we accept the project?"** If yes → Include. If it happens regardless → Exclude.

---

### 2.2 The Core FCFF Formula

$$\boxed{CF_t = EBIT_t(1-T) + Dep_t - \Delta WC_t - CAPEX_t}$$

| Symbol | Meaning |
|---|---|
| $CF_t$ | Free Cash Flow to Firm in year $t$ |
| $EBIT_t$ | Incremental earnings before interest and tax |
| $T$ | Marginal tax rate |
| $Dep_t$ | Depreciation expense (non-cash; adds back) |
| $\Delta WC_t$ | Change in net working capital |
| $CAPEX_t$ | Capital expenditures in year $t$ |

> Interest expense is **excluded** — already in WACC. Including it would double-count the cost of debt.

---

### 2.3 What Is and Isn't Relevant

| RELEVANT (Include) | IRRELEVANT (Exclude) |
|---|---|
| Incremental revenues and operating costs | **Sunk costs** (already spent, non-recoverable) |
| Incremental taxes | Past R&D or market study expenses |
| Incremental CAPEX | Financing costs (interest — in WACC already) |
| Incremental NWC changes | Allocated corporate overhead that doesn't change |
| Opportunity costs | Non-incremental overhead |
| Cannibalization effects (lost CM) | |
| Salvage value / terminal value | |

---

### 2.4 Key Cash Flow Types

**Sunk Costs** — Past expenditures that cannot be recovered. Irrelevant regardless of amount.

**Opportunity Costs** — Value of best alternative foregone. Include even if no cash changes hands.

**Cannibalization:**
$$\boxed{\text{Cannibalization Cost} = \text{Lost Units} \times \text{Contribution Margin of Existing Product}}$$
After-tax: Lost CM × (1 − T)

**Allocated Costs** — *Does this project increase total company cash outflows for this cost?* No → Exclude. Yes → Include.

---

### 2.5 Net Working Capital (NWC)

$$\boxed{NWC = \text{Current Assets} - \text{Current Liabilities}}$$

NWC is a **temporary cash investment**, not an expense. Fully recovered at project end.

| Stage | Effect | FCFF Impact |
|---|---|---|
| Launch | $\Delta NWC > 0$ (outflow) | Decreases |
| Growing | $\Delta NWC > 0$ (outflow) | Decreases |
| Plateau | $\Delta NWC = 0$ | None |
| Project End | $\Delta NWC < 0$ (recovery) | **Increases** |

---

### 2.6 Terminal Value

**Continuing Operations:**
$$\boxed{TV = \frac{FCFF_{n+1}}{WACC - g}}$$
Requires WACC > g. Use for long-lived products, platforms, ongoing manufacturing.

**Project End / Asset Disposal:**
$$\boxed{TV = \text{After-tax Salvage} + \text{NWC Recovery} + \text{Land at Market Value}}$$
$$\text{After-tax Salvage} = MV - T \times (MV - BV)$$
Use for finite-life projects, rapid obsolescence, cyclical operations.

---

### 2.7 Why Interest Is Excluded from FCFF

Interest is caused by the firm's financing choice, not the project. WACC already prices cost of debt via $r_d(1-T)$. Including interest in FCFF would double-count it.

---

## 3. Real Options Analysis

> *Session 4 | "Wait, Watch, and Win"*

### 3.1 Traditional NPV vs. Real Option NPV

| Dimension | Traditional NPV | Real Option NPV |
|---|---|---|
| Thinking | "Now or Never" | "Wait, Watch, and Win" |
| Flexibility | Ignored | Explicitly valued |
| Decision | Single irreversible choice | Sequence of adaptive decisions |
| Uncertainty | Risk only | Can create option value |

---

### 3.2 Common Real Options

| Option | Question | When Valuable |
|---|---|---|
| **Defer** | Invest now or wait? | High demand/cost uncertainty |
| **Expand** | Start small, scale later? | Market penetration uncertain |
| **Abandon** | Shut down if demand collapses? | Large downside risk |
| **Switch** | Redesign instead of cancel? | Flexible inputs/outputs |

---

### 3.3 Real Option NPV

$$\boxed{NPV_{total} = NPV_{base} + \text{Option Value}}$$

> Real options do NOT replace WACC. Base NPV still uses risk-adjusted WACC. Options modify the decision path, not the risk pricing.

---

### 3.4 Wireless Internet Device — Decision Tree

| | Proceed Today | Wait One Year |
|---|---|---|
| Expected NPV | \$1.08M | **\$9.36M** |
| Std Deviation | \$24.02M | \$8.57M |
| Coeff. of Variation | 22.32 | **0.92** |

Waiting dominates: higher E(NPV) and far lower risk. Low-demand scenario fully avoided when waiting.

---

### 3.5 KIDCO Growth Option

| | First Gen Only | With Growth Option |
|---|---|---|
| Expected NPV | \$1.29M | **\$4.70M** |
| Coeff. of Variation | 14.54 | **5.24** |

> GreenFuture pilot plant = **Call Option** on full-scale expansion — right but not obligation.

---

## 4. Distribution Policy — Dividends & Alternatives

> *Session 7 | Damodaran: "If you cannot find investments that earn better than your cost of capital, return money to shareholders."*

### 4.1 Distribution Decision Sequence

1. Fund all **positive-NPV investments** (ROIC > WACC)
2. Maintain **target capital structure** + **liquidity buffers**
3. Remainder → **distributable**

---

### 4.2 Dividend Irrelevance (MM)

Perfect markets → payout policy irrelevant. In practice: taxes, clienteles, signaling, agency costs make it matter.

---

### 4.3 Why Payouts Matter

**Bird-in-Hand:** Certain dividends > uncertain capital gains.

**Tax Effect:** PH: 10% final tax on dividends (individuals); 0.1% STT on listed shares; 15% CGT on unlisted.

**Clientele Effect:** Changing payout disrupts clientele → selling pressure.

| Investor | Preference | Signal |
|---|---|---|
| Retirees / income seekers | Stable regular dividends | Dividend maintained/raised |
| Growth / young accumulators | Lower dividends, reinvestment | Disciplined buybacks |
| Dividend/yield funds | Consistent dividend | Stable payout ratio |
| Active traders | Price catalysts | Buyback announcements |
| Controlling families | Retained earnings if expanding | Group capital allocation |

---

### 4.4 Signaling Hypothesis

Dividend increase → confidence in sustainable earnings. Dividend cut → bad news. Dividends are **sticky** — Lintner: firms won't raise unless increase is sustainable.

---

### 4.5 Agency and Governance

| Model | Description |
|---|---|
| **Outcome Model** | Strong rights → management forced to pay out excess cash |
| **Substitution Model** | Weak governance → dividends build investor trust |

---

### 4.6 Residual Distribution Model

$$\boxed{\text{Distribution} = \text{Net Income} - (\text{Target Equity Ratio} \times \text{Capital Budget})}$$

IWT: Capex \$112.5M, equity ratio 80%, NI \$140M → Required equity \$90M → **Distribution \$50M** (35.7% payout)

---

### 4.7 Dividends and Stock Price

$$\boxed{P_{ex-div} = P_{cum-div} - D_{per share}}$$

Form changes; total shareholder wealth unchanged.

---

### 4.8 Stock Repurchase

| Feature | Repurchase | Dividend |
|---|---|---|
| Price effect | Unchanged after repurchase | Falls by dividend amount |
| Shares outstanding | Decreases | Unchanged |
| Tax treatment | Capital gains (preferred) | Dividend tax |
| Commitment | Flexible | Sticky |
| Signal | "Undervalued" | "Earnings sustainable" |

---

### 4.9 Stock Dividends vs. Stock Splits

Both: no cash out; price falls proportionally.
- Stock dividend: conserve cash; signal optimism
- Stock split: keep price accessible; boost liquidity

---

### 4.10 CFO Cash Allocation Decision Tree

```
Cash / FCFF Available
│
├─► ROIC > WACC? → YES → INVEST (CAPEX, R&D, WC, M&A)
│
├─► No positive NPV? → RESILIENCE TEST
│     YES → Deleverage / build buffer
│     NO  ↓
└─► DISTRIBUTE
    ├─ Regular Dividend  (stable earnings; sets floor)
    ├─ Special Dividend  (one-off windfall; no permanence)
    ├─ Buyback           (undervaluation signal; flexible)
    └─ Capital Reduction (persistent excess; approval-heavy)
```

---

## 5. Capital Structure

> *Sessions 9–10 | Damodaran: "The optimal debt and equity mix maximizes the value of the firm."*

### 5.1 Business Risk and Operating Leverage

$$\boxed{DOL = \frac{\% \Delta EBIT}{\% \Delta \text{Sales}} = \frac{\text{Sales} - \text{Variable Costs}}{\text{EBIT}}}$$

| | Alpha Corp (High Fixed) | Beta Corp (Low Fixed) |
|---|---|---|
| Fixed Costs | \$500K | \$200K |
| DOL | **6x** | **3x** |

High DOL = small sales change → large EBIT swing = more business risk.

---

### 5.2 Financial Risk

$$\boxed{DFL = \frac{\% \Delta EPS}{\% \Delta EBIT}}$$

50% debt: E(ROE) 16.8% vs 12% (zero debt); std dev 49.5% vs 24.7%.

---

### 5.3 MM Theorems

**Prop I — No Taxes:** $\boxed{V_L = V_U}$ — Capital structure irrelevant.

**Prop II — With Taxes:**
$$\boxed{V_L = V_U + T \times D} \qquad \boxed{PV(\text{Tax Shield}) = T \times D}$$

**Hamada Equation:**
$$\boxed{\beta_L = \beta_U \left[1 + (1-T)\frac{D}{E}\right]}$$

---

### 5.4 Trade-Off Theory

$$\boxed{V_L = V_U + PV(\text{Tax Shield}) - PV(\text{Distress Costs})}$$

More debt capacity: stable CFs, tangible assets, high tax rate, low operating leverage.
Less debt capacity: volatile earnings, intangibles, high existing business risk.

---

### 5.5 Pecking Order Theory

$$\boxed{1.\ \text{Retained Earnings} \rightarrow 2.\ \text{Debt} \rightarrow 3.\ \text{New Equity (last resort)}}$$

| Source | Signal |
|---|---|
| Retained earnings | Neutral |
| Debt | **Positive** — confidence in CFs |
| Equity issuance | **Negative** — possible overvaluation |
| Share repurchase | **Positive** — stock undervalued |

---

### 5.6 Optimal Capital Structure — WACC Minimization

| % Equity | % Debt | WACC |
|---|---|---|
| 100% | 0% | 11.32% |
| 70% | 30% | **10.72%** ← minimum zone |
| 60% | 40% | 11.06% |
| 30% | 70% | 12.87% |

---

## 6. Mergers & Acquisitions (M&A)

> *Sessions 13–14 | "M&A is buying a cash flow machine."*

### 6.1 Strategic Motivations

| Motivation | Example |
|---|---|
| **Growth** | Grab acquiring Uber SE Asia |
| **Synergies** | Disney acquiring Pixar |
| **Defensive** | Microsoft acquiring LinkedIn |
| **Focus/Core Strategy** | JFC buying The Coffee Bean |
| **Globalization** | Jollibee acquiring Smashburger (US) |

---

### 6.2 Types of M&A

| Type | Definition | Goal |
|---|---|---|
| **Horizontal** | Same industry / competitors | Market share, scale |
| **Vertical** | Same supply chain | Control inputs, reduce costs |
| **Conglomerate** | Unrelated industries | Diversification |

---

### 6.3 Why M&A Fails (70–90% failure rate)

| Risk | Failure Modes | Warning Signs |
|---|---|---|
| **Strategic** | Wrong thesis; adjacency creep | Thesis not measurable |
| **Valuation** | Overpaying; synergy double-count | Only works in best case |
| **Execution** | Integration failure; talent loss | No integration owner |
| **Financing** | Excess leverage; refinancing wall | Downside breaches covenants |
| **Regulatory** | Antitrust delays | No contingency plan |
| **Governance** | Deal fever; advisor bias | Dissent excluded |

---

### 6.4 DCF in M&A

$$\boxed{EV = \sum_{t=1}^{n} \frac{FCFF_t}{(1+WACC)^t} + \frac{TV}{(1+WACC)^n}}$$

$$\boxed{TV_{perpetuity} = \frac{FCFF_{n+1}}{WACC - g}} \qquad \boxed{TV_{exit} = \text{EV/EBITDA} \times EBITDA_n}$$

> Terminal value = 50–80% of total EV. Always run: WACC ±1%, g ±0.5%, multiple ±1x.

---

### 6.5 Valuation Multiples

| Multiple | Best Used | Limitation |
|---|---|---|
| **EV/EBITDA** | Mature businesses | Ignores CAPEX differences |
| **EV/EBIT** | Capital-intensive firms | Sensitive to depreciation |
| **EV/Revenue** | High-growth, negative earnings | Ignores profitability |
| **P/E** | Stable, low-leverage firms | Distorted by leverage |
| **P/B** | Banks and insurers | Not for asset-light firms |

---

### 6.6 Triangulation

$$\boxed{\text{Floor (DCF SA)} \leq \text{Offer Zone} \leq \text{Ceiling (Multiples + Synergies)}}$$

> Valuation range ≠ Bid range. Buyer must retain part of synergy value.

PacificTech/NCE: DCF SA 3,246 | Multiples 3,677–4,580 | **Offer Zone: 3,246–4,427**

---

### 6.7 Synergies

$$\boxed{NPV_{synergies} = \sum \frac{p_i \times CF_{synergy}}{(1+WACC)^t} - \text{Integration Costs}}$$

---

## 7. Leveraged Buyouts (LBO)

> *Session 16 | "How can an acquirer who pays a fair price still earn very high equity returns?"*

### 7.1 What Is an LBO?

Acquisition using significant borrowed capital; target's own cash flows service the debt. Typical: 60–70% debt / 30–40% equity. Hold 4–7 years → exit.

---

### 7.2 LBO Value Creation

$$\boxed{\text{Equity IRR} = f(\text{Entry Price, Leverage, Debt Paydown, EBITDA Growth, Multiple Expansion})}$$

---

### 7.3 Leverage Effect on Returns

| Equity % | IRR (5-yr, 2x value) |
|---|---|
| 100% | 15% |
| 50% | 22% |
| 40% | 25% |
| 20% | **36%** |

---

### 7.4 Return Metrics

$$\boxed{CoC = \frac{\text{Exit EV} - \text{Net Debt at Exit} + \text{Cash}}{\text{Initial Equity Invested}}}$$

Rule of thumb: 3.0x CoC in 5 yrs ≈ 25% IRR | 3.0x in 3 yrs ≈ 44% IRR

---

### 7.5 Ideal LBO Target Profile

| Trait | Why It Matters |
|---|---|
| Strong, stable, recurring cash flows | Must service debt reliably |
| Low CAPEX requirements | More cash for debt paydown |
| Low existing leverage | Room to add LBO debt |
| Strong management team | Operations must improve |
| Clear exit opportunities | PE must realize return in 4–7 years |
| Strong competitive position | Sustainable advantage |

---

### 7.6 LBO Capital Stack

| Layer | Typical % | Key Features |
|---|---|---|
| **Senior Secured (Term A/B)** | 40–60% | Lowest rate; amortizing; strict covenants |
| **Revolving Credit** | 5–10% | Liquidity cushion |
| **Mezzanine** | 10–20% | Subordinated; higher rate + equity kickers |
| **High-Yield Bonds** | 10–20% | Public; fewer covenants; higher cost |
| **PIK Notes** | Varies | Interest accrues as debt; last resort |
| **Equity (Sponsor)** | 30–40% | First loss; highest upside |

---

### 7.7 LBO Exit Options

| Exit | When Used |
|---|---|
| Strategic Sale | Synergies/consolidation |
| Secondary Buyout | Untapped growth remains |
| IPO | Favorable markets; scale |
| Dividend Recap | Strong cash flows |
| MBO | Aligned management |

---

### 7.8 Capco Packaging LBO — Key Numbers

| Item | Value |
|---|---|
| Entry EV | \$200M (5.0x \$40M EBITDA) |
| Debt 60% / Equity 40% | \$120M / \$80M @ 10% |
| Exit Year 5 EBITDA | \$64.42M |
| Exit EV (5.0x) | \$322.10M |
| Equity Proceeds | **\$244.50M** |
| **Cash-on-Cash** | **3.06x** |
| **Equity IRR** | **25.0%** |

---

# SECTION 2 — TEXTBOOK READING HIGHLIGHTS

> *Brigham & Ehrhardt, Financial Management: Theory & Practice — Asia Edition (2e)*

---

## Ch. 14 — Distributions to Shareholders: Dividends and Repurchases

**Dividend mechanics:** Declaration date → Ex-dividend date (price drops) → Record date → Payment date.

**Lintner's model:** Stable or growing dividends regardless of short-term fluctuations. Long-run target payout ratio; gradual adjustment. Managers strongly avoid cuts.

**Residual dividend model:** Theoretically optimal but produces variable dividends — creates signaling noise and clientele disruption. Used to set long-run target payout only.

**DRIPs:** Shareholders reinvest dividends in new shares (often at a discount). Reduces cash outflow while maintaining payout mechanics.

**Repurchase methods:** Open market (flexible, weaker signal); Tender offer (at premium, strongest signal); Negotiated (from block holders).

**Key principle:** Dividends and repurchases are economically equivalent in perfect markets. Taxes, signaling, flexibility, and commitment costs differentiate them in practice.

---

## Ch. 15 — Capital Structure Decisions

**Business vs. financial risk:** Business risk = EBIT volatility. Financial risk = EPS/ROE volatility beyond business risk. Total equity holder risk = both.

**MM with taxes:** PV(Tax Shield) = T × D. V_L = V_U + TD. Real bankruptcy costs prevent full-debt structure.

**Dynamic Trade-Off:** Firms have a target leverage range; they drift and periodically rebalance.

**Pecking Order (Myers-Majluf 1984):** Equity issuance signals overvaluation → stock falls on announcement. Firms avoid equity unless internal funds and debt capacity are exhausted.

**Empirical:** Profitable firms → lower debt (pecking order). Stable industries → higher debt (trade-off). High-growth → low debt (flexibility).

**Practical tools:** EPS/EBIT break-even analysis; TIE under downside; reserve borrowing capacity.

---

## Ch. 22 — Mergers, Acquisitions, and Corporate Control

**Types:** Friendly merger; hostile takeover (tender offer / proxy fight); LBO (debt-financed, PE-led).

**Motives:** Synergies (only legitimate economic rationale); undervalued target; tax benefits; market power. Diversification — empirically weak.

**Synergy value:** V_AB = V_A + V_B + Synergies. Premium > synergies → acquirer destroys value.

**Takeover mechanics:** Tender offer bypasses board. Premium typically 20–40% above pre-announcement price. Acquirer stock often falls on announcement.

**Post-merger integration:** Most value destruction occurs after close. Synergy realization takes 2–3 years. Cultural clash and talent attrition are leading failure causes.

**Divestitures:** Spin-offs, carve-outs, and asset sales — often value-creating when shedding complexity or non-core operations.

---

# SECTION 3 — CASE STUDIES

> *Rainbow bar: 🔴 Most Relevant → 🟠 High → 🟡 Medium → 🟢 Least Relevant*

---

## Case 1: NovaTech SmartWear

### Summary
NovaTech Electronics (\$30M-revenue PH consumer tech firm) evaluates launching **SmartWear**, an AI-enhanced corporate wellness wearable. Full capital budgeting: incremental vs. irrelevant CFs, initial investment, after-tax OCF, NWC, NPV/IRR/Payback/PI. Key issues: sunk costs, opportunity costs, cannibalization, allocated overhead, NWC cycles.

### Topic Map

| Topic | Relevance | Notes |
|---|---|---|
| 🔴 **Relevant Cashflows** | Primary | Entire case is incremental CF identification |
| 🟠 **WACC** | High | Discount rate for NPV |
| 🟡 **Real Options** | Medium | Phased investment implied |
| 🟢 Capital Structure / Distribution / M&A / LBO | Low | Not applicable |

### Key Cash Flow Decisions

| Item | Classification | Action |
|---|---|---|
| Market study (\$18K) | Sunk cost | **Exclude** |
| Cybersecurity audit (\$12K) | Sunk cost | **Exclude** |
| Land value (\$150K) | Opportunity cost | **Include** at market value |
| IT overhead allocation (\$25K) | Allocated fixed cost | **Exclude** |
| Loan processing fee + interest | Financing cost | **Exclude** |
| NovaBand cannibalization (-\$40K) | Negative incremental CF | **Include** |
| Shared logistics savings | Evaluate incrementality | **Include** only if truly incremental |

---

## Case 2: Rockboro Machine Tools Corporation

### Summary
Rockboro (capital goods manufacturer, no prior dividend history) evaluates four payout policies: no dividend, 20%, 40%, residual dividend — plus a share repurchase program. Constraint: max debt = 40% of book equity.

### Topic Map

| Topic | Relevance | Notes |
|---|---|---|
| 🔴 **Distribution Policy** | Primary | All four payout scenarios + buyback |
| 🟠 **Capital Structure** | High | Debt capacity constraint drives payout capacity |
| 🟠 **WACC** | High | Needed for intrinsic share value |
| 🟡 **Relevant Cashflows** | Medium | FCF determines distributable amount |
| 🟢 Real Options / M&A / LBO | Low | Not applicable |

### Key Points
- First-ever dividend declaration = powerful signal; sets permanent floor expectation
- Repurchase rational only if stock trades below intrinsic value
- Clientele effect: changing from zero-dividend attracts different investor base; hard to reverse
- Advertising/name change: unrelated to dividend policy

---

## Case 3: Hill Country Snack Foods

### Summary
A PH family snack food company with **zero debt** evaluates adding leverage and using proceeds for share repurchases. Requires CAPM WACC, Hamada equation, optimal capital structure table, and recommendation respecting family business culture.

### Topic Map

| Topic | Relevance | Notes |
|---|---|---|
| 🔴 **Capital Structure** | Primary | Zero → optimal leverage question |
| 🟠 **WACC** | High | CAPM with given inputs required |
| 🟠 **Distribution Policy** | High | Debt proceeds fund share repurchase |
| 🟡 **Relevant Cashflows** | Medium | Incremental tax shield from debt |
| 🟢 Real Options / M&A / LBO | Low | Not applicable |

**Given CAPM Inputs:** Rf = 1.8% | β_U = 0.5 | MRP = 5.5% | Tax = 35.5%

Build D/E table → Hamada for levered beta → WACC at each D/E → find minimum. Family culture caveat: may rationally accept sub-optimal leverage for control and distress aversion.

---

## Case 4: American Chemical Corporation (Dixon / Collinsville)

### Summary
Dixon Corporation evaluates acquiring the **Collinsville electrolytic chlorine plant**. Requires: industry-adjusted WACC with beta re-levering, full incremental DCF with and without laminate technology, NPV, and strategic assessment. Laminate = **real option** with two proof milestones.

### Topic Map

| Topic | Relevance | Notes |
|---|---|---|
| 🔴 **M&A** | Primary | Full acquisition valuation + strategic rationale |
| 🔴 **WACC** | Primary | Industry-adjusted with beta un/re-levering |
| 🟠 **Relevant Cashflows** | High | Incremental FCF model for Collinsville |
| 🟠 **Real Options** | High | Laminate = real option with milestones |
| 🟠 **LBO** | High | Dixon's leverage + fixed obligations = LBO-like risk |
| 🟡 **Capital Structure** | Medium | Dixon's debt capacity constrains the deal |
| 🟢 Distribution Policy | Low | Not the focus |

### Key Points
- Value Dixon can create ≠ value under current owner → strategic rationale test
- Power cost path = most sensitive DCF driver
- Laminate: commit only after 2 milestones; call option on \$2.25M
- Terminal value: finite-life plant → asset disposal / salvage method
- Dixon's covenants = critical risk constraint

---

## Case 5: Cinven's LBO of Capco Packaging

### Summary
Cinven (PE firm) evaluates an **LBO of Capco Packaging** — 40% EBITDA margins, stable FMCG/e-commerce demand, conservative existing leverage. Full LBO model: FCFF, term loan amortization + 50% excess cash sweep, revolver, exit at 5.0x EBITDA, equity IRR.

### Topic Map

| Topic | Relevance | Notes |
|---|---|---|
| 🔴 **LBO** | Primary | Full LBO model construction and analysis |
| 🔴 **Relevant Cashflows** | Primary | FCFF is the engine of the model |
| 🟠 **Capital Structure** | High | Capital stack, debt tranches, leverage optimization |
| 🟠 **WACC** | High | Embedded in IRR/equity return analysis |
| 🟡 **M&A** | Medium | LBO is M&A subset; exit planning |
| 🟢 Real Options / Distribution Policy | Low | Not the focus |

### Key Numbers

| Item | Value |
|---|---|
| Entry EV | \$200M (5.0x \$40M EBITDA) |
| Debt 60% / Equity 40% | \$120M / \$80M @ 10% |
| Mandatory amortization | \$10M/year |
| Excess cash sweep | 50% of CFADS after mandatory |
| Exit Year 5 EBITDA | \$64.42M |
| Exit EV (5.0x) | \$322.10M |
| **Cash-on-Cash** | **3.06x** |
| **Equity IRR** | **25.0%** |

CFADS = Net Income + Depreciation − CAPEX − ΔNWC. Thesis: stable FMCG ✓ | low CAPEX ✓ | strong cash conversion ✓ | clear deleveraging path ✓

---

*End of FINMA202 Oral Exam Master Reviewer*
*Synthesized from: 10 Faculty Slide Decks + 3 Textbook Chapters (Brigham & Ehrhardt Asia Ed.) + 5 Case Studies*
*Generated: June 2026 | OMBA 2026B | Prof. Jose Vicente Camus | AIM Washington SyCip GSB*

---

#finma202 #mba/aim #finance #oral-exam #wacc #capital-budgeting #real-options #distribution-policy #capital-structure #mergers-acquisitions #lbo #reviewer
