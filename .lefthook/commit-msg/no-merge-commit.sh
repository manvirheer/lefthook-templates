#!/usr/bin/env bash
# Prevent merge commits

if git rev-parse --verify -q MERGE_HEAD >/dev/null; then
  echo "⛔  Merge commit detected!"
  echo "    Please rebase first: git fetch origin && git rebase origin/dev"
  echo "    Abort this merge:  git merge --abort"
  exit 1
fi

echo -e "\e[32m✅  No merge in progress. Good to go!\e[0m"
exit 0