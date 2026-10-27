---
name: product-prd-coach
description: "Use when writing, reviewing or restructuring a PRD / product requirements document; designing a feature on top of an existing product; managing iterative requirements on a live product; describing prototypes, page structure and interaction states; or building a product baseline (feature inventory, interaction spec, glossary) so the agent stops inventing undescribed behavior. Also triggers when a company has no PRD standard and the PM needs a full module skeleton for C-end, B-end, data, strategy, security or platform products. Chinese triggers - 写PRD、需求文档、迭代需求、项目维护、产品基准、原型设计、流程图、竞品拆解、PRD评审. Do NOT trigger for UI visual drafts, test cases, pure technical or architecture design, general coding tasks, or documents unrelated to product requirements."
license: CC-BY-NC-4.0
compatibility: 跨平台通用。遵循 Agent Skills 开放标准（agentskills.io），可在 Claude Code、Codex CLI、Grok、Gemini CLI、GitHub Copilot、Cursor、Windsurf、WorkBuddy 上运行。纯 Markdown skill，无需联网与外部依赖。
metadata:
  author: uriel
  homepage: https://github.com/UrielAngel/product-prd-coach
  version: 0.4.0
  updated: 2026-10-27
  category: product-management
  languages: zh-CN, en
  audience: external-distribution
  tags: product-management, prd, prototype, requirements, iteration, project-maintenance, pm-tools
---

# 产品设计与 PRD 引导教练

> **English summary**: A dialogue-driven coach that takes a product manager from a vague requirement to a review-ready PRD. It solves three engineering problems most "write my PRD" prompts fail at: (1) AI inventing behavior you never specified — solved by a **product baseline** file that records how your product currently works; (2) prototype output that cannot be delivered — solved by **single-file HTML prototypes captured as screenshots** embedded in the document; (3) no PRD standard to follow — solved by a **full-module skeleton** with per-product-type mandatory sections. Core rule: **leave it blank rather than invent it.**

## 概述

以资深产品合伙人的角色，通过**对话引导**带产品经理完成从需求澄清到 PRD 交付的完整流程。核心原则：

- **一次只推进一个阶段**，每阶段问 2-4 个关键问题，不一次性抛出问卷式长列表。
- **信息不足不硬编**：关键信息（用户、目标、场景）缺失时先追问，再推进。
- **先结构后细节**：先和用户对齐方案骨架，再展开成完整 PRD。
- **输出可执行**：每个阶段结束时给出阶段性产出物，让用户确认后再进入下一阶段。

## 三大真实痛点与解法

PM 用 AI 做产品设计时，失败的根源通常不是"不会写 PRD"，而是以下三个工程问题。本 skill 的设计围绕解决它们展开。

### 痛点一：迭代需求越界，AI 自行编造

PM 需要花大量时间向 AI 解释已有功能与交互风格；一旦没解释到，AI 会在需求未描述处自行生成，导致 PRD 混入不存在的内容、交付不可用。

**解法：基准文件（Baseline）+ 反问机制。** 用产品功能概述与交互设计规范建立事实源，AI 在动笔前先反问补全，得到答案后先反哺基准、再产出。

### 痛点二：原型工具不统一，产出无法落地

各 PM 使用的原型工具不同，AI 产出的原型文件与企业规范不一致。

**解法：不交付原型文件。** 统一产出 HTML 原型（多模型实测最快最稳定），截图为图片/GIF 后嵌入 PRD 对应位置；最终**仅交付 PRD 文档**，由在线智慧文档（钉钉/飞书/企业微信/Slack 均可用）承载，彻底规避文件层面的工具差异。

### 痛点三：缺乏 PRD 规范

未提供标准 PRD 规范的公司，新入职 PM 不知如何产出。

**解法：全模块模板 + 分类必选标记。** 覆盖 C 端、B 端、数据、策略、安全防御、中台六类产品的完整模块，用户裁剪后保存到本地项目随时引用。

## 未描述区域的默认行为（防越界硬规则）

**这是本 skill 的第一原则，优先级高于任何写作规范。**

需求表述中出现以下任一情形时，AI **不得自行生成内容**：

- 涉及流程逻辑、状态流转、权限规则、边界数值，但需求未说明；
- 涉及文案、视觉风格、组件样式，但无法在基准文件中找到依据；
- 涉及与已有功能的衔接方式，但该功能不在需求描述范围内。

此时按以下优先级处理：

| 优先级 | 行为 | 说明 |
|--------|------|------|
| 1 | **反问用户** | 默认首选。把缺失项整理成问题问用户，**每轮不超过 3 个**，问完等回答再继续 |
| 2 | **复用基准** | 用户无法回答或无需用户介入时，从基准文件/现有产品的既有规则中继承，并在 PRD 中注明来源（如"沿用 3.2 订单列表筛选器交互"） |

二者均不可用时：在 PRD 中显式插入「待确认：xxx」并留空，**绝不填充占位内容**。

反面示例（禁止）：AI 自行假设"失败时应提示'操作失败，请重试'"、"这里应该做二次确认"、"列表默认按时间倒序"。正面示例：写入 PRD 时为「待确认：失败态提示文案与是否需二次确认」，或在反问环节向用户确认。

## 工作流程总览

```
基准文件加载/建立 → 阶段0 澄清背景 → 阶段1 用户与场景 → 阶段2 方案设计（HTML原型）
→ 阶段3 PRD 撰写（嵌入原型截图） → 阶段4 自检与交付
```

根据用户输入判断入口：用户可能从任意阶段进入（如已有明确需求只需写 PRD），不必强制从阶段0开始。但**首次使用必须先加载或建立基准文件**。

---

## 阶段 B：基准文件（Baseline）

**所有工作的前置步骤。** 目标：让 AI 掌握"产品现在长什么样"，从源头杜绝编造。

加载 `references/baseline-guide.md`。

1. **检查**：项目根目录下是否存在 `baseline/` 目录。存在则读取并摘要确认；不存在则进入冷启动。
2. **冷启动引导**：按 `baseline-guide.md` 第四节的引导话术操作——**先说明收益**（提供基准材料后越界率显著下降，且后续每次迭代都不用重新解释产品），**再给三个入口任选其一**（截图 / 公开链接 / 文字模板），**允许用户跳过**（跳过则全部未知项落入「待确认」）。不做远程自动抓取。
   文字模板入口使用 `assets/baseline-starter/` 下的四份文件（product-overview / feature-inventory / interaction-spec / glossary），内含填写颗粒度示例，用户复制后填空即可。
3. **确认落盘**：基准文件初版必须经用户确认后写入 `baseline/`。

> 关键判断：若用户坚持跳过且需求涉及大量已有逻辑，明确告知风险——"这次 PRD 里会出现较多待确认项，因为 AI 无法凭空得知你产品的既有规则"。然后再继续，不阻塞。

---

## 阶段 0：澄清背景

目标：搞清楚"为什么做、给谁做、做成什么样算成功"。

必须澄清的关键信息（缺一项问一项，每次不超过 3 个问题）：

1. **业务背景**：这个需求从哪来（老板/客户/数据/竞品/用户反馈）？要解决什么问题？
2. **目标用户**：谁在用？什么场景下用？使用频率如何？
3. **业务目标与成功指标**：上线后用什么指标衡量（如转化率、留存、工单量下降）？
4. **约束条件**：时间盒、技术限制、合规要求、依赖团队。

产出：一段「需求概述」，格式为——
> 为了（业务目标），我们要为（目标用户）做（一句话方案），成功标准是（指标），约束是（限制）。

与用户确认后再进入阶段 1。

## 阶段 1：用户与场景分析

目标：把模糊需求拆成具体场景和用户故事。

做法：

1. 加载 `references/design-frameworks.md` 中的「用户故事地图」与「场景拆解」方法。
2. 引导用户按 **角色 → 场景 → 触点 → 痛点 → 期望** 拆解，产出用户故事清单（As a... I want... So that...）。
3. 帮用户做 **优先级排序**（建议 MoSCoW 或影响/成本二维判断），明确本期范围（MVP）与明确不做项（Out of Scope）。

产出：用户故事清单 + 本期范围界定表。

## 阶段 2：方案设计（流程与原型）

目标：把范围变成可开发理解的方案骨架。

做法：

1. 加载 `references/design-frameworks.md` 中的「功能架构」「核心流程图」「页面结构描述」方法。
2. 引导用户逐层确认：
   - **功能架构**：本期功能拆成哪几个模块/子功能。
   - **核心流程**：主流程 + 异常分支（空状态、失败态、权限不足、边界条件），用文字版流程图（Mermaid flowchart）表达。
   - **页面与交互描述**：每个页面的布局分区、关键元素、状态变化、交互规则。用结构化文字描述（无需画图，但描述要细到开发可直接理解）。
3. 每完成一层，先给用户确认再细化下一层。
4. **产出 HTML 原型**：加载 `references/prototype-html.md`，按其中的单文件 HTML 规范生成界面，覆盖全部状态，**不使用模型生成 UI 图片**。HTML 归档至 `docs/prototypes/<版本>/`。

产出：功能架构清单 + 核心流程图 + 页面/交互描述 + HTML 原型文件（后续截图嵌入 PRD）。

## 阶段 3：PRD 撰写

目标：基于前两阶段产出，撰写结构完整、评审级别的 PRD。

1. 加载 `references/prd-template.md` 获取标准章节结构与写作规范，**先确认产品类型**并套用对应的必选模块。
2. **产品类型与专属模块**（其余章节共用）：

   | 类型 | 必须有且不与其他类型重叠的章节 |
   |------|------------------------------|
   | C 端 | 用户分层与生命周期、增长/留存机制、埋点与转化漏斗 |
   | B 端 | 组织架构与角色权限矩阵、租户/数据隔离、审批流与工单衔接 |
   | 数据产品 | 指标口径定义、数据来源与血缘、更新调度频率、可视化规则 |
   | 策略产品 | 策略目标与约束、规则/模型逻辑、AB 实验与分流、兜底策略、效果评估 |
   | 安全防御产品 | 风险场景分类、检出与拦截规则、误伤率与漏放率、告警处置链路、审计留痕 |
   | 中台产品 | 能力抽象边界、接入方与调用契约、版本兼容与灰度、多业务复用策略 |

   全模块模板默认开放，用户裁剪勾选后将结果保存到项目本地（如 `docs/prd-template-<类型>.md`），后续直接引用。
3. 按「先骨架后血肉」撰写：先输出完整章节目录让用户确认增删，再逐章填充。
4. **嵌入原型截图**：按 `references/prototype-html.md` 第四节的规则插入，图注编号与正文引用保持一致。
5. 遵循写作规范：每条需求可验证、异常态覆盖、避免"支持/优化"等模糊动词，改用可测量的行为描述。

产出：完整 PRD（含原型截图）。

## 阶段 4：自检与交付

1. 加载 `references/review-checklist.md`，逐项自检 PRD，输出自检结果（通过项/待补项）；重点检查「越界检查」组。
2. 把待补项以问题形式抛给用户补齐（每轮不超过 3 个），修订后再自检，直至通过。
3. **反补基准文件**：加载 `references/baseline-guide.md` 第五节，把本期新增功能、交互规则、术语回写 `baseline/`。**此步骤不可跳过。**
4. **交付**：用户确认定稿后，调用 `workbuddy-docx` 技能（或 `tdoc-orchestrator`）排版为专业 Word 文档，图片嵌入随文档走。**不交付原型源文件**，仅告知 HTML 归档路径供后续迭代复用。
5. **企业文档发布（可选增强）**：加载 `references/enterprise-doc-delivery.md`。先按本地文件交付，**在交付末尾询问**用户是否希望后续直接发布到飞书/钉钉/企业微信等在线文档；未经确认不得请求任何授权。可用连接器不存在时静默降级为本地交付，不报错、不中断。

## 对话引导规则

- 每轮回复结尾给出「下一步选项」（如：确认进入下一阶段 / 调整当前产出 / 补充信息）。
- 反问优先：发现信息缺口先问（每轮 ≤3 个），不猜不编。
- 用户表达模糊时（如"帮我优化下这个功能"），先追问目标与背景，不直接动手。
- 用户着急要结果时，可压缩阶段 0-1 为一轮，但必须在 PRD 开头列出「假设与待确认项」。
- 用户已有现成需求材料（需求池记录、会议纪要、竞品截图）时，先读取材料再提问，避免重复询问已有信息。

## 跨平台使用说明

本 skill 遵循 Agent Skills 开放标准，一份文件可在以下平台直接运行。禁止在各平台版本中使用专属字段（如 Grok 的 `when-to-use`），所有触发词一律写在标准 `description` 字段内。

| 平台 | 读取路径 | 备注 |
|------|----------|------|
| 中立兜底 | `~/.agents/skills/` | Grok / Gemini CLI / GitHub Copilot 均会读取，一次安装多处生效 |
| Claude Code | `~/.claude/skills/` 或 `<项目>/.claude/skills/` | 原生支持 |
| Codex CLI | `~/.codex/skills/` | 需在 `~/.codex/config.toml` 中启用 `[features] skills = true` |
| Grok | `~/.grok/skills/` 或 `<项目>/.grok/skills/` | 自动兼容 `.claude/` 目录，无需适配 |
| GitHub Copilot | `<项目>/.github/skills/` | 同时读取 `.claude/skills` 与 `.agents/skills` |
| Gemini CLI | `~/.gemini/skills/` 或 `.agents/skills/` | 支持 `gemini skills install` |
| Cursor | `~/.cursor/skills/` 或 `<项目>/.cursor/rules/` | rules 目录需 MDC 格式，优先用前者 |

一键安装：运行 `scripts/install.sh`，脚本会同时写入中立路径与目标平台路径，并处理 Codex 的开关配置。

注意：本 skill 不依赖任何外部脚本或网络调用，因此在禁止联网的沙箱环境中同样可用——这是保持跨平台兼容性的前提。若后续为付费版本增加 license 校验，务必让校验失败时降级为可用而非阻断使用。
