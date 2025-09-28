#!/usr/bin/env bash
# Commit message validator: <Type>: <lowercase summary>

FILE="$1"
FIRST_LINE="$(head -n1 "$FILE" | tr -d '\r')"

TYPES='PR|Docs|Task|Bug|Fix|Test|Refactor|Feature|DevOps'
ALLOWED='a-z0-9~!@#\$%^&*()_+=\-{}\[\]|\\:;"'"'"'<>,.?/'

PATTERN='^('"$TYPES"'): ['"$ALLOWED"']['"$ALLOWED"' ]*$'

if [[ ! "$FIRST_LINE" =~ $PATTERN ]]; then
  echo -e "\e[31m⛔  Invalid commit header:\e[0m \"$FIRST_LINE\""
  echo "ℹ️  Format: <Type>: <lowercase summary>"
  echo "👉  After type, use a colon and a single space"
  echo "     Types: PR, Docs, Task, Bug, Fix, Test, Refactor, Feature, DevOps"
  echo "     Example: Fix: handle null input in auth service"
  echo "💡  Ignore the check with --no-verify"
  exit 1
fi

# Detect and show non-ASCII characters
if LC_ALL=C grep -q '[^[:print:][:space:]]' <<<"$FIRST_LINE"; then
  NON_ASCII=$(LC_ALL=C grep -o '[^[:print:][:space:]]' <<<"$FIRST_LINE" | tr -d '\n')
  echo -e "\033[31m⛔  Non-ASCII characters detected in commit message:\033[0m"
  echo -e "    Offending characters: $NON_ASCII"
  exit 1
fi

echo -e "\e[32m✅  Valid commit message format.\e[0m"
exit 0