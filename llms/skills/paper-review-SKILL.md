---
name: paper-review
description: Use when the user asks for a paper review, a paper quality review, a paper critique, or asks to assess, evaluate, or check the trustworthiness of a scientific, ML, or AI safety paper. Returns a claim-level audit, inferential gaps, alternative explanations, and a concrete action recommendation. Do not use for generic "what do you think of this" or for literature reviews.
---

# Paper Quality Review

Review a **single paper** for quality, fast. Do **not** perform a literature review. Do **not** summarize the paper unless summary is needed for evaluation.

Your job is to answer:

> Which claims does this paper actually license, at what confidence, for what use?

The output should help the user decide whether to **trust, cite, reuse, replicate, ignore, or route around** the paper.

---

## Core stance

Be adversarial about inference, not about the authors.

A good review separates:

1. What the paper claims
2. What the paper actually shows
3. What remains uncertain
4. What action the paper justifies

Avoid generic praise. Avoid vague "more research is needed." Prefer concrete inferential failure modes.

---

## Review depth

Infer depth from context.

### Triage review: 5–10 minutes

Use when the user wants a quick read.

Output:

- Verdict
- Main licensed claim
- Main reason to trust
- Main reason to doubt
- Whether to read deeper

### Standard review: 20–40 minutes

Default.

Output:

- Claim audit
- Evidence audit
- Main inferential gaps
- Red flags / positive signs
- Action recommendation

### Deep review: 1–2 hours equivalent

Use only when the paper is load-bearing for the user's research.

Inspect:

- Methods
- Results
- Appendices
- Dataset / benchmark
- Statistical analysis
- Baselines
- Ablations
- Code/data availability
- Limitations
- Claims in abstract/conclusion vs actual result

---

## Procedure

### 1. Extract load-bearing claims

Identify 1–3 central claims. Rewrite them narrowly.

Bad:

> "The paper shows method X works."

Good:

> "On benchmark B, under setup S, method X improves metric M over baselines Y/Z by Δ, and the authors imply this transfers to domain D."

Flag if the paper's own claims are vague, slippery, or stronger in the abstract/conclusion than in the results.

### 2. Identify the evidence type

Classify the main evidence:

- Randomized experiment
- Observational study
- Benchmark / eval
- Simulation
- Case study
- Qualitative analysis
- Mathematical proof
- Theoretical argument
- Dataset contribution
- Engineering demonstration
- Literature synthesis

Then ask:

> Is this evidence type capable of supporting the claim being made?

Examples:

- Correlation does not establish causation.
- Benchmark improvement does not establish real-world usefulness.
- A proof only proves what is formalized.
- A simulation only supports claims inside its assumptions.
- Qualitative examples do not establish frequency or robustness.

### 3. Ask "How do they know?"

For each central claim:

```text
Claim:
Evidence:
Does the evidence identify the claim?
What else could explain the result?
What would I need to see to believe the stronger claim?
```

This is the core of the review.

### 4. Check measurement validity

Ask:

- What is the target construct?
- What proxy do they actually measure?
- Could the proxy move while the real target does not?
- Is the metric chosen before seeing results?
- Is the metric meaningful or merely convenient?
- Are they optimizing/reporting what matters or what is easy?

Common failure:

> The paper claims progress on X but measures Y, where Y is only weakly connected to X.

For AI/ML papers, be especially suspicious of:

- benchmark scores as proxies for capability
- preference ratings as proxies for usefulness/safety
- toy environments as proxies for real deployment
- "SOTA" as proxy for scientific insight

### 5. Check internal validity

Ask whether the method answers the question. Look for:

- confounding
- leakage
- selection effects
- weak controls
- missing baselines
- unblinded evaluation
- subjective labels without calibration
- implementation artifacts
- post-hoc explanations
- unexplained exclusions
- degrees of freedom in preprocessing/model choice

For causal claims, ask:

> What creates the causal identification?

If there is no answer, downweight sharply.

### 6. Check statistical strength

For empirical papers, inspect:

- sample size
- effect size
- uncertainty intervals
- p-values only if relevant
- multiple comparisons
- subgroup analyses
- power
- variance across seeds/runs
- robustness checks
- preregistration, if applicable

Red flags:

- Small N + large claim
- Many outcomes, one highlighted result
- "Significant" but practically tiny
- No uncertainty estimates
- No correction or discussion for multiple testing
- Flexible analysis choices
- Pretty plots without quantitative support

For ML papers, check:

- seed variance
- confidence intervals
- number of runs
- hyperparameter search budget
- baseline tuning fairness
- train/test contamination
- prompt sensitivity
- cherry-picked examples
- benchmark saturation

### 7. Generate alternative explanations

List the strongest non-author-preferred explanations. Examples:

- The result is caused by data leakage.
- The method wins because baselines are undertuned.
- The benchmark rewards superficial artifacts.
- The result is a selection effect.
- The effect only holds in this narrow setup.
- The intervention changes a proxy but not the real target.
- The claimed mechanism is unnecessary; a simpler explanation fits.
- The result is driven by one dataset, seed, subgroup, or preprocessing choice.

Prefer specific alternatives over generic skepticism.

### 8. Compare claims to results

Explicitly separate:

```text
The paper claims:
The results show:
The results do not show:
```

Watch for conclusion laundering:

- Abstract is stronger than results.
- Discussion implies generality not tested.
- Limitations section admits something that invalidates the headline.
- The central claim depends on an interpretation, not a result.
- The strongest evidence is in examples rather than aggregate results.

### 9. Check whether the paper notices its own weaknesses

Positive sign:

- The paper names the real limitations.
- It distinguishes result from interpretation.
- It includes negative results.
- It reports failed variants.
- It explains why obvious alternative explanations are unlikely.

Negative sign:

- Limitations section is cosmetic.
- Fatal caveats are missing.
- Authors do not discuss the most obvious artifact.
- The paper sounds more certain than the design permits.

### 10. Evaluate reproducibility

Ask:

- Is code available?
- Is data available?
- Are prompts/configs/hyperparameters included?
- Are seeds specified?
- Are preprocessing steps described?
- Could a competent outsider reproduce the result?
- Is the benchmark public, private, contaminated, or author-created?
- Are there independent replications or critiques?

If reproducibility should be easy but materials are missing, downweight.

---

## Domain-specific checks

### For ML / AI papers

Check:

- Are baselines strong and fairly tuned?
- Is the benchmark actually measuring the claimed capability?
- Is there contamination or leakage?
- Are prompts and decoding parameters disclosed?
- Are examples cherry-picked?
- Are results robust across seeds/tasks/models?
- Are ablations sufficient to isolate the claimed mechanism?
- Is this science, engineering, or leaderboard-chasing?
- Does "works better" mean "teaches us something"?

Common verdicts:

- "Useful engineering result, weak scientific evidence."
- "Benchmark win, unclear real-world implication."
- "Interesting anomaly; replicate before building on it."
- "Good method paper, overclaimed motivation."
- "Valid within setup, poor external validity."

### For AI safety papers

Additionally check:

- Does the proxy correspond to the safety property?
- Are threat models explicit?
- Are capabilities and safety effects disentangled?
- Is the eval gameable?
- Does the setup select for the behavior being studied?
- Are failure modes under optimization pressure considered?
- Does the paper distinguish demonstration from robust solution?
- Are deployment assumptions realistic?

Common red flag:

> The paper demonstrates a safety-flavored behavior in a setup where the dangerous generalization is not actually tested.

### For theoretical / mathematical papers

Check:

- Are definitions doing hidden work?
- Does the theorem prove the informal claim?
- Are assumptions realistic or merely sufficient?
- Are edge cases handled?
- Are examples representative?
- Is the result nontrivial, or mostly a restatement?
- Does the formalization preserve the phenomenon of interest?
- Is there a gap between theorem and motivating story?

Output should distinguish:

```text
Formal result:
Informal interpretation:
Gap between them:
```

### For experiments / social science / bio / medicine

Check:

- Randomization
- Blinding
- Control group
- Attrition
- Preregistration
- Primary endpoint
- Multiple comparisons
- Effect size
- External validity
- Conflicts of interest
- Whether the outcome matters directly or is a surrogate

Be especially wary of:

- observational causal claims
- small effects
- flexible subgroup analysis
- surrogate endpoints
- publication bias
- ideological or financial incentives

---

## Red flags

### Near-fatal

- Central claim is causal but design is correlational.
- Metric does not measure the claimed construct.
- Main result depends on cherry-picked examples.
- Baselines are weak or unfair.
- No uncertainty despite noisy setting.
- No code/data where replication should be easy.
- The paper ignores an obvious artifact.
- Abstract/conclusion strongly overstate results.
- Result depends on a benchmark likely contaminated or gameable.
- The result is surprising but no serious sanity checks are done.

### Strong downweights

- Small sample, broad claim.
- Many metrics, one highlighted win.
- No negative results.
- No ablation for the central mechanism.
- Vague methods.
- Subjective evaluation without blinding or calibration.
- "SOTA" framing without scientific question.
- Limitations section avoids the real issue.
- Claims generality across domains but tests only one narrow setup.

---

## Positive signs

- Claims are narrow and precise.
- The method could have falsified the hypothesis.
- Strong baselines.
- Natural primary metric.
- Robustness checks target obvious failure modes.
- Negative results included.
- Uncertainty reported.
- Code/data/configs available.
- Authors distinguish evidence from speculation.
- Limitations are real, not cosmetic.
- Result has independent replication or converges with other evidence.
- The paper teaches a mechanism, not just a score.

---

## Output format

Use this structure by default.

```text
Verdict: [usable / interesting but weak / do not rely on / replicate before using / ignore]

Licensed claim:
The paper supports [narrow claim], conditional on [assumptions].

Does not support:
It does not establish [stronger tempting claim].

Main reason to trust:
...

Main reason to doubt:
...

Quality by dimension:
- Claim clarity:
- Internal validity:
- Measurement validity:
- Statistical strength:
- External validity:
- Reproducibility:
- Usefulness for the user's purpose:

Key inferential gaps:
1.
2.
3.

Alternative explanations:
1.
2.
3.

Action:
[cite / cite cautiously / steal method / adapt experiment / replicate / contact authors / add to anomaly pile / ignore]
```

For shorter answers, use:

```text
Verdict:
What it actually shows:
What it does not show:
Biggest trust signal:
Biggest flaw:
Action:
```

---

## Scoring rubric, if useful

Score each 0–3.

```text
Claim clarity:
0 = unclear
1 = broad/vague
2 = mostly precise
3 = narrow and explicit

Internal validity:
0 = method cannot support claim
1 = major gaps
2 = plausible with caveats
3 = strong design

Measurement validity:
0 = proxy mismatch
1 = weak proxy
2 = reasonable proxy
3 = directly measures target

Statistical / evidential strength:
0 = anecdotal or underpowered
1 = weak/noisy
2 = adequate
3 = strong and robust

External validity:
0 = no reason to generalize
1 = narrow setup only
2 = plausible nearby generalization
3 = broad support or replications

Reproducibility:
0 = impossible to inspect
1 = underspecified
2 = mostly reproducible
3 = code/data/configs available

Usefulness:
0 = irrelevant
1 = interesting only
2 = changes local beliefs/actions
3 = load-bearing for future work
```

Do not average blindly. A fatal flaw in measurement or internal validity can dominate the total.

---

## Style guidelines

- Be direct.
- Prefer "this does not show X" over vague caveats.
- Name the seam.
- Do not over-index on venue/prestige.
- Do not perform politeness-review.
- Do not bury the verdict.
- Separate uncertainty from weakness.
- Preserve useful insights even in flawed papers.
- Recommend concrete next actions.

---

## Final heuristic

A high-quality paper makes it hard to believe the result for the wrong reason.

It pins down the claim, exposes the method, tests obvious alternatives, reports uncertainty, acknowledges real limitations, and leaves the reader with a narrow but usable belief update.
