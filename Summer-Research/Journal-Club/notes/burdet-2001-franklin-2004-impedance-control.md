# Burdet et al. (2001) & Franklin et al. (2004) — Impedance control of the arm

## Burdet et al. (2001) — The central nervous system stabilizes unstable dynamics by learning optimal impedance
**Journal:** Nature, 414(6862), 446–449
**DOI:** [10.1038/35106566](https://doi.org/10.1038/35106566)

### Introduction
- **Hypothesis:** The CNS learns to control the arm's mechanical impedance (resistance to imposed motion)
  to stabilize movement in an unstable dynamic environment.
- **Motivation:** Many everyday tasks (e.g., keeping a screwdriver in a screw slot) are mechanically
  unstable. Prior work modeled how the CNS learns *stable* interaction dynamics; this study asks how it
  handles instability.

### Methods
- 9 subjects (5 used for analysis) made horizontal reaching movements in a robotic manipulandum that
  produced a divergent force field (DF) — negative stiffness perpendicular to the movement direction.
- Endpoint stiffness was estimated by briefly displacing the hand mid-movement and measuring the restoring
  force ("endpoint stiffness was estimated from the mean change in hand force and position over a 60-ms
  interval during the perturbation, starting from 120 ms after onset of the perturbation").
- Unclear terms flagged at the time: "mechanical impedance," "stiffness ellipses."

### Results
- Movements were initially unstable in the DF, but subjects adapted with practice to produce straight
  trajectories.
- Subjects selectively increased stiffness *in the direction of instability*, without significantly
  changing stiffness in the perpendicular direction.
- After the DF was unexpectedly removed (after-effects), trajectories were even straighter than in the
  null field — evidence of a learned, predictive adaptation (not just reactive).

### Discussion
- The CNS can control the shape, magnitude, and orientation of arm stiffness — not just uniformly
  co-contract all muscles (which would be more metabolically costly and less selective).
- Demonstrates a sophisticated, selective impedance-control strategy for stabilizing unstable interactions.

---

## Franklin et al. (2004) — Impedance control balances stability with metabolically costly muscle activation
**Journal:** Journal of Neurophysiology, 92(5), 3097–3105
**DOI:** [10.1152/jn.00364.2004](https://doi.org/10.1152/jn.00364.2004)

### Introduction
- Extends Burdet (2001): does the CNS maintain a *constant* margin of stability as the level of
  environmental instability varies, or does it scale impedance to the specific level of instability?

### Methods
- 5 right-handed subjects, reaching movements in divergent force fields of varying strength (multiple DF
  levels rather than a single strength).
- Measured how endpoint stiffness changed with DF strength after adaptation.

### Results
- Subjects learned to make straight movements even in unstable conditions after practice.
- Stiffness increased specifically in the direction of instability, scaling with the strength of the DF,
  without changing stiffness in the perpendicular direction.
- After learning, the *net* stiffness (arm + environment) in the direction of instability remained similar
  across DF strengths — i.e., similar to that in stable (null-field) conditions.

### Discussion
- The brain finely tunes arm stiffness to just enough to stabilize movement, rather than over-shooting with
  generalized co-contraction — balancing stability against metabolic cost.

---

## Combined summary / discussion notes
- Key difference to keep in mind between this pair of papers and the animal/single-fiber work (Horslen):
  timescale. These are whole-arm, human, multi-joint behavioral studies; Horslen is isolated single muscle
  fiber.
- Should consider the role of antagonist muscles and reflexes (short- vs. long-latency stretch reflex) when
  interpreting these impedance-control results.
- Neural control is not stationary — it's continuously active, not just reactive to perturbations.
- Some modeling assumptions in these papers may not hold *in vivo* (e.g., in more naturalistic, unconstrained
  movement).
