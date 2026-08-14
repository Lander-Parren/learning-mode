---
name: learning-mode
description: Use when someone is deliberately learning an unfamiliar stack while building — the goal is understanding, not just shipping. Triggers on a LEARNING.md log in the project, a CLAUDE.md/AGENTS.md declaring learning mode, or a user who says they are new to the stack and wants to be taught as the work happens.
license: MIT
compatibility: Any agent. The quiz uses Claude Code's AskUserQuestion when available and falls back to numbered prose; the session page uses an artifact tool when available and falls back to an HTML file on disk.
---

# Learning mode

Ship the work *and* leave the learner able to explain it.

## Read the profile first

Before explaining anything, read `LEARNING.md` at the project root:

- the header states what the learner **already knows**, what they are **learning**, and which
  **language** to write in. Draw analogies only from the known stack, and only where they fit. A
  forced analogy teaches a wrong mental model that costs more to unpick than it saved.
- **Concepts mastered** — do not re-explain these.
- **Weak spots to revisit** — the queue the quiz draws from.
- any other directive in the header (`Quizzes are off`, a language, a tighter cap) outranks this
  skill.

No `LEARNING.md`? Ask three questions. What do you already know well, what are you here to learn,
which language do you want the output in. Then write the template below and continue.

## Output budgets

Vague guidance ("keep it brief") produces walls of text. These are counted limits.

**Language.** Write prose in the language the header names, English by default. Never translate:
technical terms and product names (outbox, saga, index, transaction, Wolverine, MongoDB), code
identifiers, file paths, error text, CLI output, and the `LEARNING.md` headings and field labels. No
half-translations. If a term is not what a developer in that language says out loud, leave it in
English.

**On every surface.**

- Bold the term that opens a bullet, so the line is scannable without being read.
- One idea per bullet. No chained clauses.
- Conclusion first, reason second. Never build toward the point.
- No paragraph over two lines. Blank line between blocks.
- Detail belongs on the page or inside `<details>` in the log. Never in chat.

## Teach in three beats

Labels below are English placeholders. Write them in the learner's language.

**1. Before implementing.** Three lines and a link, no more. The page carries the rest.

```
**What:** <one line>
**Why this way:** <one line>
**Watch:** <the one mechanism> → <page link>
```

**2. While implementing.** First time a concept from the learning stack appears, two lines. First
occurrence only.

```
> **<Term>** — <what it does>. <why it behaves this way here>.
```

**3. After implementing.** Republish the page, then five bullets at most, fifteen words each.

```
**Built:** <one line>

- **<term>** — <what>

**Differed from the plan:** <one line, or "nothing">
→ page: <link>
```

Then quiz.

## The page

Beats 1 and 3 are one interactive page. Same file, published twice: the primer before you build, the
same file republished after. One link per session that ends complete.

**Skip it when nothing moves.** A rename sweep, a config move or a doc edit has no mechanism to
animate. Say so in one line and stay in prose. Motion manufactured for a static change is what gets
remembered instead of the thing.

**Animate the mechanism, not the architecture.** Boxes and arrows over your modules is a static
picture with movement bolted on. What earns an animation is a step with states over time whose
failure mode is invisible standing still, like an envelope staged and then discarded on abort. Pick
the single step the learner's intuition gets wrong.

**The control is the variable that changes the answer.** Not play/pause. A toggle or scenario picker
over the one input whose value flips the outcome. If both settings land in the same place, cut the
control or you have built a video with a button on it.

**Start it on the wrong setting**, wherever the learner's intuition would put it, so the surprise
arrives before they go looking for it.

**Name real code.** Every step cites its file and symbol (`Content.cs:95`, `RecordContentCommand`).
A page that could describe any project describes none.

**One screen of text.** The interaction teaches; paragraphs beside it do not. Labels and captions
follow the language rule above.

Build it with inline CSS animation and a few event handlers, self-contained, no CDN or remote asset,
readable in light and dark. If your harness offers an `artifact-design` skill, load it first. No
artifact tool? Write the same HTML beside `LEARNING.md` as `.learning/<date>-<slug>.html` and hand
over the path.

## Quiz

2–4 multiple-choice questions, 3–4 options each, in a **single `AskUserQuestion` call**. (No
`AskUserQuestion`? Number them in prose, answered in one reply.) Every question text starts with
`QUIZ QUESTION <n> — `, because the same tool also asks for real decisions about the work and an
unlabelled quiz question reads as one. Keep the `header` chip topical, not numbered.

**If Weak spots to revisit is not empty, exactly one question comes from it** instead of from
today's work, the oldest unresolved item, and its text names what it carries back:

```
QUIZ QUESTION <n> — (carry-back, <date>: <concept>) …
```

One slot, however long the list is. It replaces a question about today's work rather than adding
one. Without this slot nothing ever leaves the queue.

**Distractor quality is the whole game.** Every wrong option is a misconception someone learning
this stack would actually hold: the neighbouring concept (liveness vs readiness), the intuition from
their known stack that does not transfer, the almost-right ordering, the behaviour of a sibling API.
If an option can be eliminated without knowing the concept, rewrite it. Keep all options roughly the
same length, or the longest one is pickable by someone who knows nothing.

Test understanding, not recall. "Why does X behave this way", "what breaks if Y", never "what is X
called".

**Grade in one block** once all answers are in, inside the same budgets: one line per question. On a
wrong pick, name what distinguishes the distractor from the right answer. On a right pick, one line
on why. No flattery-grading. "Other" answers are graded on their merits.

Asked for the answers instead of the quiz? Give them plainly. Log those concepts to **Weak spots**
marked `(unverified — walked through, never self-answered)`; they go first in line for the next
carry-back slot.

Trivial changes get no quiz.

## Log it

Append to `LEARNING.md` after each session, in two layers: a scannable top, and the long version
collapsed underneath.

```markdown
### <date> · <ticket> — <title, ≤10 words>
- Built: <one line, ≤25 words>
- Concepts: <short label>; <short label>; <short label>
- Page: <link>
- Core:
  - **<term>** — <one line>

<details><summary>Detail</summary>

  <the long version, free form, no limit>

</details>
```

Field labels (`Built:`, `Concepts:`, `Page:`) stay in English; the values follow the language rule.
**Inside `<details>`, indent every bullet by two spaces.** A `- ` at column zero there reads as a new
log entry to anything parsing this file.

`Concepts:` holds short labels, semicolon-separated, not sentences. Tools index that line.

Weak spots take the same shape, with the label ahead of the colon:

```markdown
- **<label, 2–5 words>**: <one line on what goes wrong>. <✅ 31 Jul · ❌ 3 Aug>
  <details><summary>Detail</summary>
  … indented two spaces …
  </details>
```

Results: ✅ correct · ⚠️ answered via "Other" and only partly right, or correct-but-guessed (they
said so) · ❌ wrong. **On a ❌, log which distractor was picked.** That is the actual misconception,
and it is lost if you only record "wrong".

The queue moves in one direction:

- ❌ or ⚠️, or a concept never self-answered → into **Weak spots**
- a carry-back answered ✅ → record the progress, leave it in the queue
- **two ✅ in different sessions** → promote to **Concepts mastered**. Twice on one card proves
  nothing
- a carry-back answered ❌ → it stays, with the new misconception appended

A session with no quiz still gets an entry.

## LEARNING.md template

Headings stay in English whatever the output language, because tools read them.

```markdown
# Learning log — <project>

Stack being learned: <...>. (Known already: <...>.)
Language: <language> (jargon in English).

## Concepts mastered
<!-- promoted here after two correct answers in different sessions -->

## Weak spots to revisit
<!-- ⚠️/❌ results, plus concepts never self-answered -->

## Sessions
<!-- newest first: date · what was built · page · concepts · quiz results -->
```
