# learning-mode

A Claude Code skill for when you're working in a stack you don't know yet and you want to
come out the other side able to explain what you shipped.

It makes Claude do four things around every non-trivial change:

- say what it's about to build and why, **before** it builds it
- explain each unfamiliar concept the first time it shows up, using analogies from the stack
  you already know
- walk through the finished work, then quiz you on it
- log the quiz results to `LEARNING.md`, and spend one slot in the *next* quiz re-asking
  something you got wrong earlier rather than only testing today's work

The quiz is the part that makes it work. Multiple choice, 2–4 questions, and the wrong options
are real misconceptions rather than filler — the neighbouring concept, the intuition from your
old stack that doesn't transfer, the almost-right ordering. If you can eliminate an option
without knowing the answer, the question is doing nothing.

## Install

Any agent, via the [skills](https://www.skills.sh/) CLI:

```bash
npx skills add Lander-Parren/learning-mode
```

Claude Code, as a plugin (this also installs the session hook):

```bash
/plugin marketplace add Lander-Parren/learning-mode
```

```bash
/plugin install learning-mode@learning-mode
```

## Setup

Nothing to configure. On the first non-trivial change Claude will ask what you already know
and what you're learning, then write a `LEARNING.md` at your project root. That file is the
config from then on — its header holds your profile, and the rest is your log.

If you'd rather seed it yourself:

```markdown
# Learning log — my-project

Stack being learned: Rust, tokio, sqlx. (Known already: Python, Django.)

## Concepts mastered
<!-- promoted here once answered correctly twice -->

## Weak spots to revisit
<!-- concepts with ⚠️/❌ quiz results -->

## Sessions
<!-- newest first: date · what was built · concepts · quiz results -->
```

## Making it stick

Installed as a Claude Code plugin, a `SessionStart` hook walks up from your working directory
looking for a `LEARNING.md` and announces learning mode when it finds one. Nothing to wire up —
the log's existence is the switch.

Installed via the skills CLI, or in a project that should be in learning mode without a log
present, name the skill in your `CLAUDE.md` instead. That file loads every session, so it
triggers as reliably as the hook:

```markdown
## Learning mode

Active for every non-trivial change: follow the `learning-mode` skill.
Profile and log: `LEARNING.md`.
```

## Notes

Results are logged as ✅ correct, ⚠️ partly right or a guess you owned up to, ❌ wrong. On a ❌
the log records *which* wrong option you picked, because that's the misconception worth coming
back to.

Concepts get promoted to "mastered" after two correct answers in *different sessions*, not one.
Answering right about something you were walked through five minutes ago mostly proves you were
paying attention. That's what the carry-back slot is for: while "Weak spots" has anything in it,
one question per quiz comes from there instead of from today's work, so the list actually
drains.

If you'd rather just be told the answers, say so — you'll get them, and those concepts go into
"Weak spots" as unverified so they come back around later.

Typos, renames and one-line fixes don't get a quiz.

## License

MIT
