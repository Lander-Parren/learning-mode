---
name: learning-mode
description: Use when someone is deliberately learning an unfamiliar stack while building — the goal is understanding, not just shipping. Triggers on a LEARNING.md log in the project, a CLAUDE.md/AGENTS.md declaring learning mode, or a user who says they are new to the stack and wants to be taught as the work happens.
license: MIT
compatibility: Any agent. The quiz uses Claude Code's AskUserQuestion when available and falls back to numbered prose.
---

# Learning mode

Ship the work *and* leave the learner able to explain it.

## Read the profile first

Who you are teaching is data. Before explaining anything, read `LEARNING.md` at the project
root:

- the header states what the learner **already knows** and what they are **learning**. Draw
  analogies only from the known stack, and only where they genuinely fit — a forced analogy
  teaches a wrong mental model that costs more to unpick than it saved.
- **Concepts mastered** — do not re-explain these.
- **Weak spots to revisit** — the queue the quiz draws from.

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
questions on one card. (No `AskUserQuestion`? Number them in prose, answered in one reply.)
Every question text starts with `QUIZ QUESTION <n> — ` — the same tool also asks for real
decisions about the work, and an unlabelled quiz question reads as one. Keep the `header` chip
topical, not numbered.

**If Weak spots to revisit is not empty, exactly one question comes from it** instead of from
today's work — the oldest unresolved item — and its text names what it carries back:

```
QUIZ QUESTION <n> — (carry-back, <date>: <concept>) …
```

Naming it forces a deliberate pick rather than a today's-work question that happens to graze an
old topic, and it tells the learner this one came off the backlog. One slot, however long that
list is: it replaces a question about today's work rather than adding one, and a quiz that is
mostly carry-back stops testing what was just built. Without this slot nothing ever leaves the
queue.

**Distractor quality is the whole game.** Every wrong option is a misconception someone
learning this stack would actually hold:

- the neighbouring concept (liveness vs readiness)
- the intuition from their known stack that does not transfer here
- the almost-right ordering
- the behaviour of a sibling API

If a wrong option can be eliminated without knowing the concept, rewrite it. Keep all options
within roughly the same length, too — a correct answer that is visibly the longest and most
qualified is pickable by a learner who knows nothing about the topic.

Test understanding, not recall: "why does X behave this way", "what breaks if Y" — never "what
is X called".

**Grade in one block** once all answers are in. Per question, state the correct option. On a
wrong pick, say why that distractor was tempting and what actually distinguishes it from the
right answer. On a right pick, one line on *why* it is right — no flattery-grading. Answers
given via "Other" are graded on their merits.

Asked for the answers instead of the quiz? Give them plainly — the goal is understanding, not a
score. Log those concepts to **Weak spots** marked `(unverified — walked through, never
self-answered)`. They go first in line for the next carry-back slot.

Trivial changes — typos, renames, one-line fixes — get no quiz.

## Log it

Append to `LEARNING.md` after each quiz: date, what was built, concepts covered, result per
question, weak spots.

Results: ✅ correct · ⚠️ answered via "Other" and only partly right, or correct-but-guessed
(they said so) · ❌ wrong. **On a ❌, log which distractor was picked** — that is the actual
misconception to revisit, and it is lost if you only record "wrong".

The queue moves in one direction:

- ❌ or ⚠️, or a concept never self-answered → into **Weak spots**
- a carry-back answered ✅ → record the progress, leave it in the queue
- **two ✅ in different sessions** → promote to **Concepts mastered**. Twice on one card, or
  once on a walkthrough just read, proves nothing
- a carry-back answered ❌ → it stays, with the new misconception appended

## LEARNING.md template

```markdown
# Learning log — <project>

Stack being learned: <...>. (Known already: <...>.)

## Concepts mastered
<!-- promoted here after two correct answers in different sessions -->

## Weak spots to revisit
<!-- ⚠️/❌ results, plus concepts never self-answered -->

## Sessions
<!-- newest first: date · what was built · concepts · quiz results -->
```
