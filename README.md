# product-prd-coach

> An [Agent Skills](https://agentskills.io) package that coaches product managers from a vague requirement to a review-ready PRD — **without letting the AI invent what you never asked for.**
>
> 中文说明见文末 | English first

Most "write me a PRD" prompts fail for engineering reasons, not writing reasons. This skill targets the three that actually break delivery:

| Symptom | Root cause | What this skill does |
|---|---|---|
| The PRD contains things you never asked for | The agent has no idea how your product currently works, so it fills every blank with industry defaults | Builds a **product baseline** (feature inventory / interaction spec / glossary) that acts as the single source of truth |
| The prototype output can't be delivered | Your team's prototyping tool never matches what the agent emits | Produces **single-file HTML prototypes**, captured as screenshots / GIFs and embedded into the document. No prototype file is ever delivered |
| Nobody knows what a PRD should contain | No company standard, and no template matched to product type | A **full-module skeleton** with mandatory sections per product type (C-end / B-end / data / strategy / security / platform) |

Core rule: **leave it blank rather than invent it.** Anything missing becomes a `待确认` (TBD) item, never a guess.

---

## Install

```bash
# Any agent, recommended
npx skills add UrielAngel/product-prd-coach

# Install globally for Codex CLI
npx skills add UrielAngel/product-prd-coach --agent codex --global

# Install a specific agent target
npx skills add UrielAngel/product-prd-coach --agent claude-code
npx skills add UrielAngel/product-prd-coach --agent cursor
npx skills add UrielAngel/product-prd-coach --agent gemini-cli
npx skills add UrielAngel/product-prd-coach --agent github-copilot
```

Manual install — clone this repo and run the bundled script, or copy the folder yourself:

```bash
bash skills/product-prd-coach/scripts/install.sh          # user-level, all detected agents
bash skills/product-prd-coach/scripts/install.sh --project # project-level (./.agents/skills)
```

| Agent | Path |
|---|---|
| Codex CLI | `~/.codex/skills/` (script sets `skills = true` in `config.toml` automatically) |
| Claude Code | `~/.claude/skills/` |
| Grok | `~/.grok/skills/` or `~/.agents/skills/` |
| Gemini CLI | `~/.gemini/skills/` |
| GitHub Copilot | `~/.agents/skills/` |
| Cursor / Windsurf | `.cursor/skills/` |
| WorkBuddy | `~/.workbuddy/skills/` |
| Repo-level (any of the above) | `$REPO_ROOT/.agents/skills/` |

Restart the agent client after installing so it reloads skill metadata. In Codex you can list skills with `/skills` or invoke this one explicitly with `$product-prd-coach`.

## Compatibility

- Format: Agent Skills open standard (`SKILL.md` + optional `references/` `assets/` `scripts/`)
- Runtime requirement: none. Instruction-only Markdown — no binaries, no API keys, no MCP server.
- Network requirement: **none.** The skill never performs remote fetching, so it works on internal products and behind firewalls.
- Tested clients: WorkBuddy, Codex CLI. Other targets follow the same standard; please open an issue if anything behaves differently.

## Permissions & security

This skill is **instruction-only**. It does not read credentials, does not execute code during a session, and makes no outbound network requests.

The one exception is `scripts/install.sh`, which you run deliberately:

- It writes the skill folder into the agent config directories listed above (only those whose parent already exists).
- For Codex it appends `[features] skills = true` to `~/.codex/config.toml`, creating the file if absent.
- It performs no deletions and no destructive operations. Read it in full before running — it is 86 lines.

Maintainer: `UrielAngel`. Please report security concerns privately via GitHub security advisories rather than public issues.

## Example prompts

Positive triggers:

```
Write the PRD for adding bulk export to the existing order list
```

```
Our team's prototyping tool doesn't match what the AI outputs — give me a PRD with embedded screenshots I can send straight to review
```

```
Our company has no PRD standard. Restructure this requirement into a standard framework and self-check it
```

Negative — it should **not** activate for: UI visual drafts, test-case writing, pure technical or architecture design, general coding tasks, or any document unrelated to product requirements.

Repeatable outcome test: give it a one-line requirement for a feature on top of an existing product. A correct run will (1) ask whether a baseline exists, (2) ask at most three blocking questions per round, (3) mark every unspecified behaviour as `待确认` instead of filling it in, (4) end with a self-check that includes five boundary-violation checks.

## Repository layout

```
skills/product-prd-coach/
├── SKILL.md                      Agent-facing source of truth
├── README.md                     What the skill does and how to use it
├── DEMO.md                       Full walkthrough script, including what a baseline-less AI gets wrong
├── references/
│   ├── baseline-guide.md         Building and maintaining the baseline
│   ├── design-frameworks.md      User stories, flows, page/interaction description
│   ├── prototype-html.md         Single-file HTML prototype + screenshot rules
│   ├── prd-template.md           Full module skeleton per product type
│   ├── review-checklist.md       26 checks incl. 5 boundary-violation checks
│   └── enterprise-doc-delivery.md  Optional delivery to Feishu / DingTalk / WeCom docs
├── assets/baseline-starter/      4 fill-in-the-blank templates for cold start
└── scripts/install.sh            Cross-platform installer
```

## Version history

| Version | Change |
|---|---|
| 0.4.0 | English-first frontmatter and description for cross-directory compatibility; English summary block added to body |
| 0.3.0 | Baseline mechanism, HTML prototype spec, six product-type modules, boundary checks |
| 0.2.0 | Open-standard metadata, license and compatibility declarations |
| 0.1.0 | Initial five-stage guided workflow |

## License

[CC BY-NC 4.0](LICENSE) — free to use, share and adapt for non-commercial purposes, with attribution. Commercial use requires a separate licence; open an issue to discuss.

---

# 中文说明

一个遵循 Agent Skills 开放标准的产品经理技能包：把一句不完整的需求，做成一份能过评审的 PRD。

**它的核心立场是「宁可留白，不许编」。** 需求没说清的地方，优先级是反问 → 复用基准文件并注明来源 → 标记为「待确认」，绝不按行业惯例替你补齐。

## 它解决的三个问题

1. **迭代需求越界** — AI 不知道你的产品现在长什么样，只能在空白处自行发挥。解法是建立 `baseline/` 产品基准文件（功能清单 / 交互规范 / 术语表），让 AI 有事实源可依。
2. **原型无法交付** — 团队用的原型工具永远和 AI 产出对不上。解法是产出单文件 HTML 原型，截图 / GIF 嵌入 PRD，**不交付任何原型源文件**。
3. **没有 PRD 规范** — 公司没模板、市面上也没有按产品类型分的模板。解法是六类产品的全模块骨架 + 专属必选章节。

## 上手

```bash
npx skills add UrielAngel/product-prd-coach
```

或直接下载本仓库，把 `skills/product-prd-coach/` 整个文件夹放进你的 Agent 技能目录（路径见上方表格），重启客户端即可。

第一次使用建议先看 `DEMO.md`——它先演示「没有基准文件时 AI 会犯的三个错」，再演示正确做法。

## 使用场景

首次冷启动时会引导你建立基准文件（给截图 / 公开链接 / 填模板，任选其一，也可以跳过），全程**不做任何远程抓取**，所以内网产品、未发布产品都能安全使用。

---

## 给使用者的一句话提醒

涉及公司内部素材请先脱敏。本技能产出的每条逻辑都要求可追溯到「你的原话 / 基准文件 / 反问得到的答案」三者之一，追溯不到的一律标注待确认。
