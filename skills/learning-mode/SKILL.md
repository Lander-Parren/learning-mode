---
name: learning-mode
description: Use when someone is deliberately learning an unfamiliar stack while building — the goal is understanding, not just shipping. Triggers on a LEARNING.md log in the project, a CLAUDE.md/AGENTS.md declaring learning mode, or a user who says they are new to the stack and wants to be taught as the work happens.
---

# Learning mode

Ship the work *and* leave the learner able to explain it. Non-trivial changes get explained
before, annotated during, walked through after, and checked with a quiz whose results are
logged.

## Read the profile first

Who you are teaching is data, not something you assume. Before explaining anything, read
`LEARNING.md` at the project root:

- the header states what the learner **already knows** and what they are **learning**. Draw
  analogies only from the known stack, and only where they genuinely fit — a forced analogy
  teaches a wrong mental model that costs more to unpick than it saved.
- **Concepts mastered** — do not re-explain these.
- **Weak spots to revisit** — revisit briefly when they reappear.

No `LEARNING.md`? Ask two questions — what do you already know well, what are you here to
learn — then write the template below and continue.

## Teach in three beats

1. **Before implementing** — 2–5 sentences: what you are about to build, and *why this
   approach*.
2. **While implementing** — when a concept from the learning stack first appears, add a brief
   note. First occurrence only.
3. **After implementing** — walk through what was built and how the pieces connect. Then quiz.

## Quiz

2–4 multiple-choice questions, 3–4 options each, in a **single `AskUserQuestion` call** — all
questions on one card. (No `AskUserQuestion` in your harness? Number them in prose and ask for
all answers in one reply.)

Every question text starts with `QUIZ QUESTION <n> — `. The same tool asks the learner to make
real decisions about the work, and an unlabelled quiz question is easy to mistake for one.
Keep the `header` chip topical (`Triggering`, `Profile`) rather than numbering it — it is
capped at 12 characters and the prefix already carries the label.

**Distractor quality is the whole game.** Every wrong option is a misconception someone
learning this stack would actually hold:

- the neighbouring concept (liveness vs readiness)
- the intuition from their known stack that does not transfer here
- the almost-right ordering
- the behaviour of a sibling API

If a wrong option can be eliminated without knowing the concept, rewrite it.

Test understanding, not recall: "why does X behave this way", "what breaks if Y" — never "what
is X called".

**Grade in one block** once all answers are in. Per question, state the correct option. On a
wrong pick, say why that distractor was tempting and what actually distinguishes it from the
right answer. On a right pick, one line on *why* it is right — no flattery-grading. Answers
given via "Other" are graded on their merits.

Trivial changes — typos, renames, one-line fixes — get no quiz.

## Log it

Append to `LEARNING.md` after each quiz: date, what was built, concepts covered, result per
question, weak spots.

Results: ✅ correct · ⚠️ answered via "Other" and only partly right, or correct-but-guessed
(they said so) · ❌ wrong. **On a ❌, log which distractor was picked** — that is the actual
misconception to revisit, and it is lost if you only record "wrong".

Promote a concept to **Concepts mastered** once it has been answered correctly twice. Once, on
a walkthrough they just read, proves nothing.

## LEARNING.md template

```markdown
# Learning log — <project>

Stack being learned: <...>. (Known already: <...>.)

## Concepts mastered
<!-- promoted here once answered correctly twice -->

## Weak spots to revisit
<!-- concepts with ⚠️/❌ quiz results -->

## Sessions
<!-- newest first: date · what was built · concepts · quiz results -->
```
