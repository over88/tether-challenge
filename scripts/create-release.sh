#!/bin/bash
# Helper script to create a release PR

set -e

if [ -z "$1" ]; then
  echo "Usage: ./scripts/create-release.sh <version-type>"
  echo "  version-type: patch|minor|major"
  exit 1
fi

VERSION_TYPE=$1
BRANCH_NAME="release/$(date +%Y%m%d-%H%M%S)"

echo "[INFO!] Creating release PR..."

# Create new branch
git checkout -b "$BRANCH_NAME"

# Bump version
echo "[INFO!] Bumping $VERSION_TYPE version..."
npm version "$VERSION_TYPE" --no-git-tag-version

NEW_VERSION=$(node -p "require('./package.json').version")

# Commit changes
git add package.json package-lock.json
git commit -m "chore:  bump version to $NEW_VERSION"

# Push branch
git push origin "$BRANCH_NAME"

# Create PR with publish label
echo "📬 Creating pull request..."
gh pr create \
  --title "chore: release v$NEW_VERSION" \
  --body "Release version $NEW_VERSION" \
  --label "publish"

echo "[INFO!] Release PR created for v$NEW_VERSION"
