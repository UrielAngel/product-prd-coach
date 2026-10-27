#!/usr/bin/env bash
# product-prd-coach 跨平台一键安装脚本
# 用法: bash scripts/install.sh [--global|--project] [--version x.y.z]
# 默认安装到用户级目录中立路径 ~/.agents/skills/（Grok / Gemini CLI / GitHub Copilot 通用），
# 并同步到检测到的各平台目录。

set -euo pipefail

SKILL_NAME="product-prd-coach"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODE="${1:---global}"

if [ "$MODE" = "--project" ]; then
  BASE="."
  echo "📦 安装模式：项目级"
else
  BASE="$HOME"
  echo "📦 安装模式：用户级"
fi

# 目标目录清单：中立路径优先，保证一次安装多处生效
TARGETS=(
  "$BASE/.agents/skills"          # Grok / Gemini CLI / GitHub Copilot 通用
  "$BASE/.claude/skills"          # Claude Code
  "$BASE/.codex/skills"           # Codex CLI（需启用 skills 开关，脚本会自动处理）
  "$BASE/.grok/skills"            # Grok
  "$BASE/.gemini/skills"          # Gemini CLI
  "$BASE/.cursor/skills"          # Cursor
  "$BASE/.workbuddy/skills"       # WorkBuddy
)

install_to() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    return 0
  fi
  local dest="$dir/$SKILL_NAME"
  mkdir -p "$dest"
  cp -R "$SOURCE_DIR"/. "$dest/"
  echo "   ✅ 已安装 -> $dest"
}

echo ""
echo "🔍 检测已安装平台..."
INSTALLED=0
for dir in "${TARGETS[@]}"; do
  parent="$(dirname "$dir")"
  # 目标平台存在（配置目录已建立）才写入，避免创建一堆用不到的工作台目录
  if [ -d "$parent" ]; then
    mkdir -p "$dir"
    install_to "$dir"
    INSTALLED=$((INSTALLED + 1))
  fi
done

# 未检测到任何平台时，兜底装到中立路径
if [ "$INSTALLED" -eq 0 ]; then
  echo "   ⚠️  未检测到已知平台配置目录，安装到中立路径 ~/.agents/skills/"
  mkdir -p "$HOME/.agents/skills/$SKILL_NAME"
  cp -R "$SOURCE_DIR"/. "$HOME/.agents/skills/$SKILL_NAME/"
fi

# Codex CLI：skills 属于实验特性，需显式开启
CODEX_CONFIG="$HOME/.codex/config.toml"
if [ -d "$HOME/.codex" ]; then
  if [ -f "$CODEX_CONFIG" ]; then
    if ! grep -q "^\[features\]" "$CODEX_CONFIG"; then
      printf '\n[features]\nskills = true\n' >> "$CODEX_CONFIG"
      echo "   ✅ 已在 codex config.toml 中启用 skills 开关"
    elif ! grep -q "skills = true" "$CODEX_CONFIG"; then
      sed -i.bak 's/^\[features\]/[features]\nskills = true/' "$CODEX_CONFIG"
      echo "   ✅ 已在 codex config.toml 中启用 skills 开关"
    else
      echo "   ⏭️  codex skills 开关已启用，跳过"
    fi
  else
    printf '[features]\nskills = true\n' > "$CODEX_CONFIG"
    echo "   ✅ 已创建 codex config.toml 并启用 skills 开关"
  fi
fi

echo ""
echo "🎉 安装完成。请重启对应 Agent 客户端以加载最新 skill 元数据。"
echo "   验证安装：ls ~/.agents/skills/$SKILL_NAME"
