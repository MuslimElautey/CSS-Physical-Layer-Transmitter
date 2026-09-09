#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

# Make sure the exclusions are in place
GITIGNORE_LINES=(
  "*.m"
  "*.docx"
  "*.pdf"
  "CSS_PHY_Trasmitter-Floating-Fixed Point-20260904T135935Z-1-001/"
  ".dvt/"
)

touch .gitignore
for line in "${GITIGNORE_LINES[@]}"; do
  grep -qxF "$line" .gitignore || echo "$line" >> .gitignore
done

# Stage everything (gitignore filters out the excluded types)
git add .

# Show what's about to be committed
echo "----- Staged changes -----"
git status --short
echo "---------------------------"

# Bail out if nothing changed
if git diff --cached --quiet; then
  echo "Nothing to commit."
  exit 0
fi

# Commit message: use arg if given, else prompt
if [ -n "$1" ]; then
  MSG="$1"
else
  read -rp "Commit message: " MSG
  [ -z "$MSG" ] && MSG="Update RTL, testbench, and script files"
fi

git commit -m "$MSG"
git push origin main

echo "Done — pushed to origin/main."
