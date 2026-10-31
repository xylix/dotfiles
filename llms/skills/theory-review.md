---
name: theory-review
description: Use when the user asks for a theory review, theoretical-research review, or conceptual critique, or asks to review/audit a piece of theoretical work — a framework, definitional proposal, conceptual essay, mathematical write-up, or formal research plan. Returns a four-axis audit: concept formation (Lakatos), working mode (Tao), empirical anchors (Hossenfelder), and lean-over-backwards integrity (Feynman). Do not use for experimental-plan review (use experiment-review), code review, empirical-paper critique (use paper-review), or generic feedback.
---

# theory-review

Theoretical work fails in patterns that look like success. Apply four lenses, in order. Return concrete edits.

## 1. Lakatos — concept formation

Every time the work tightens a definition, narrows a scope, or restricts a claim in response to a difficulty, classify the move:

- **Lemma-incorporation** — locate the hidden assumption in the argument that the case violates, lift it into the statement. Concept sharpens, theorem strengthens. Generative.
- **Exception-barring** — add a restriction ("for convex X"). Theorem stands but explains less.
- **Monster-barring** — declare the case "not a real X" by fiat. Defensive even when dressed as rigor. Learns nothing.

Flag every monster-bar. Flag exception-bars that should have been lemma-incorporations — ask what the hidden lemma is, and whether the work could have promoted it into a sharper concept instead of bolting on a side condition.

Sub-check: did the concepts in this work emerge from encounter with difficulty, or arrive fully formed? Is there a paper-trail of refinement, or does Definition 1 read as given? Fully-formed concepts with no visible refinement are suspect.

## 2. Tao — working mode

Five checks on how the work was actually done:

- **Toy model.** Where is the smallest non-trivial case? Has the author fully worked it, or only gestured? If no toy model, demand one. If the framework doesn't apply to a stripped-down case, it doesn't apply.
- **Dumb questions.** What basic terms or assumptions does the author refuse to state plainly? "What does this mean?" "Why is this assumption needed?" "What happens in the trivial case?" Surface every unanswered one.
- **Rigor in service of intuition.** Is the formalism doing intellectual work, or substituting for understanding? Test: strip the notation, ask for the result in plain language. If the author can't, the formalism is covering for absence.
- **Multiple attacks.** Is there one path to the conclusion, or several? One path is fragile. A claim provable three ways is sturdier than one provable once.
- **Wastebasket.** Sunk-cost signals: defensive responses to obvious objections, framework expanding to accommodate failures rather than contracting around what works, prior commitments load-bearing for current claims.

## 3. Hossenfelder — empirical anchors

Theoretical work decoupled from empirical contact navigates by taste. Taste is not evidence.

- **Framework falsifiability.** What would falsify the *framework*, not just specific downstream claims? If "nothing in practice," the framework is doing aesthetic rather than epistemic work.
- **Aesthetic-vs-articulable justification.** Are the criteria justifying this direction expressible in non-aesthetic terms? "Natural," "elegant," "obvious once you see it," "the right way to think about it" — red flags unless cashed out into concrete predictions or constraints.
- **Progressive vs. degenerating.** Is the programme predicting novel facts that turn out true, or rescuing prior claims from failed predictions by adjusting auxiliaries? Catalogue the predictions made and how they fared.
- **Empirical handle.** For alignment / agent foundations work specifically: where does this touch any actual system, theorem, or measurable claim? If nowhere, what is keeping it alive other than its appeal?

## 4. Feynman — lean over backwards

Where in this work has the author volunteered how it could be wrong?

- **Volunteered weaknesses.** What confounds, alternative explanations, scope limits, or fragility points has the author surfaced *that no critic would have had to extract*? Default expectation is that most works do not do this; flag the absence.
- **Millikan-drift check.** If the work agrees with established results or community consensus, has the author been more skeptical of the agreement, or less? Convenient corroboration deserves more scrutiny than inconvenient.
- **Retraction conditions.** For each major claim: what would the author have to see to retract it? If no answer is available, the claim is unfalsifiable in the author's own mind.
- **Self-fooling work.** The easiest person to fool is the author. Where in the writeup is the fooling-prevention work visibly happening?

## Output format

1. **Lakatos pass.** List of definitional / scoping moves, each classified.
2. **Tao pass.** Toy-model status, list of unanswered dumb questions, rigor-vs-substance verdict, attack diversity, wastebasket signals.
3. **Hossenfelder pass.** Framework-level falsifiability, aesthetic-vs-articulable diagnosis, progressive-vs-degenerating verdict, empirical-handle assessment.
4. **Feynman pass.** List of failure modes the author should have volunteered but didn't; Millikan-drift exposure; retraction-condition coverage.
5. **Next edit.** The single most valuable revision the author could make first.

## Anti-patterns in the review itself

- Don't apply experimental-research criteria (power, sample size, preregistration) — wrong tool, wrong target.
- Don't moralize. The author is competent. Failure modes here are sophisticated, not lazy.
- Don't restate the work back. The author knows what they wrote. Cut to the diagnosis.
- Don't soften. A theory-review's value is catching what generic feedback misses; softening defeats the purpose.
- Don't pretend the four lenses are independent — Lakatos and Hossenfelder interact (degenerating programmes often run on monster-barring), Tao and Feynman interact (post-rigorous mode requires the lean-over-backwards habit). Note interactions where they matter.
