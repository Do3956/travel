#!/bin/bash
# 每日自动提交并推送 travel 到 GitHub master。
# 尊重 .gitignore；无改动则跳过（幂等）。
# crontab 示例：
#   0 19 * * * /Volumes/文档/data/travel/scripts/auto_git_push.sh >> /tmp/travel-auto-push.log 2>&1

set -u

REPO_DIR="/Volumes/文档/data/travel"
LOG_FILE="${TRAVEL_AUTO_PUSH_LOG:-/tmp/travel-auto-push.log}"
BRANCH="master"

ts() { date '+%Y-%m-%d %H:%M:%S'; }

mkdir -p "$(dirname "$LOG_FILE")"
cd "$REPO_DIR" || {
  echo "$(ts) 无法进入 $REPO_DIR" >> "$LOG_FILE"
  exit 1
}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "$(ts) 不是 git 仓库" >> "$LOG_FILE"
  exit 1
fi

current="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
if [[ "$current" != "$BRANCH" ]]; then
  if ! git checkout "$BRANCH" >> "$LOG_FILE" 2>&1; then
    echo "$(ts) 无法 checkout $BRANCH（当前: $current）" >> "$LOG_FILE"
    exit 1
  fi
fi

git pull --rebase --autostash origin "$BRANCH" >> "$LOG_FILE" 2>&1 || {
  echo "$(ts) git pull --rebase 失败，继续检查本地改动" >> "$LOG_FILE"
}

if git diff --quiet && git diff --cached --quiet && [[ -z "$(git ls-files --others --exclude-standard)" ]]; then
  echo "$(ts) 无更改，跳过" >> "$LOG_FILE"
  exit 0
fi

git add -A >> "$LOG_FILE" 2>&1

if git diff --cached --quiet; then
  echo "$(ts) 暂存区为空（可能全被 ignore），跳过" >> "$LOG_FILE"
  exit 0
fi

DATE="$(date '+%Y-%m-%d')"
COMMIT_MSG="auto sync ${DATE} $(date '+%H:%M')"

if ! git commit -m "$COMMIT_MSG" >> "$LOG_FILE" 2>&1; then
  echo "$(ts) commit 失败" >> "$LOG_FILE"
  exit 1
fi

if ! git push origin "$BRANCH" >> "$LOG_FILE" 2>&1; then
  echo "$(ts) push 失败" >> "$LOG_FILE"
  exit 1
fi

echo "$(ts) 已提交并推送: $COMMIT_MSG" >> "$LOG_FILE"
exit 0
