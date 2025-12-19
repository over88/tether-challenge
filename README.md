# TypeScript Sum Package - CI/CD DevOps Challenge

A simple TypeScript package demonstrating a fully automated CI/CD pipeline with GitHub Actions.

##  What This Package Does

This package provides basic math utilities:
- `sum(a, b)` - Adds two numbers
- `subtract(a, b)` - Subtracts two numbers

**But the real focus is the CI/CD pipeline** - a production-grade automated workflow for testing, building, and releasing npm packages.

---

##  Quick Start - How to Release a New Version

### Prerequisites
1. Clone the repository
2. Ensure you have the `NPM_TOKEN` secret configured in GitHub repository settings
3. Ensure branch protection is set up (run once): `gh workflow run setup-branch-protection.yml`

### Option 1: Using the Helper Script (Recommended)

```bash
# For a patch release (1.0.0 → 1.0.1) - bug fixes
./scripts/create-release.sh patch

# For a minor release (1.0.0 → 1.1.0) - new features
./scripts/create-release.sh minor

# For a major release (1.0.0 → 2.0.0) - breaking changes
./scripts/create-release.sh major
```

**That's it! ** The script will:
- Create a new branch
- Bump the version
- Commit the changes
- Push to GitHub
- Create a PR with the `publish` label

Then just **merge the PR** and automation takes over.

---

### Option 2: Manual Process (Step-by-Step)

#### Step 1: Create a Feature/Release Branch

```bash
git checkout main
git pull origin main
git checkout -b release/v1.2.3
```

#### Step 2: Make Your Changes

```bash
# Make code changes
vim src/index.ts

# Commit your changes
git add .
git commit -m "feat: add new multiply function"
```

#### Step 3: Bump the Version

**Important:** You must manually bump the version in `package.json` before creating the PR.

```bash
# Option A: Use npm version command (recommended)
npm version patch --no-git-tag-version  # 1.0.0 → 1.0.1
# or
npm version minor --no-git-tag-version  # 1.0.0 → 1.1.0
# or
npm version major --no-git-tag-version  # 1.0.0 → 2.0.0

# Option B: Edit package.json manually
# Change:  "version": "1.0.0" → "version": "1.0.1"
```

#### Step 4: Commit the Version Bump

```bash
git add package.json package-lock.json
git commit -m "chore:  bump version to 1.2.3"
```

#### Step 5: Push Your Branch

```bash
git push origin release/v1.2.3
```

#### Step 6: Create a Pull Request

```bash
# Using GitHub CLI
gh pr create \
  --title "Release v1.2.3" \
  --body "Release version 1.2.3 with new features"

# Or create PR through GitHub web interface
```

#### Step 7: Add the `publish` Label

**This is crucial! ** The `publish` label triggers the release workflow.

```bash
# Using GitHub CLI
gh pr edit <PR_NUMBER> --add-label publish

# Or add via GitHub web interface: 
# Go to PR → Labels → Select "publish"
```

#### Step 8: Wait for Automated Checks

The CI/CD pipeline will automatically:

 **PR Validation** (runs on all PRs):
- Check linear history (no merge commits)
- Verify branch is up-to-date with main
- Run linting (ESLint)
- Build the package
- Run unit tests
- Verify `package-lock.json` exists

 **Version Validation** (only for PRs with `publish` label):
- Verify version was bumped
- Check version doesn't already exist on npm
- Ensure version is higher than current version

 **Build Release Candidate** (only for PRs with `publish` label):
- Create a dev version (e.g., `1.2.3-dev-abc1234`)
- Build and package the release candidate
- Upload artifact for review
- Comment on PR with build details

**Example PR comment you'll see:**
```
 Release candidate built successfully! 

Version: `1.2.3-dev-abc1234`
Artifact: Available in workflow artifacts
```

#### Step 9: Get PR Approved

- Request review from a team member
- Address any feedback
- Ensure all checks are green 

#### Step 10: Merge the PR

Once approved and all checks pass:

```bash
# Merge via GitHub CLI
gh pr merge <PR_NUMBER> --squash

# Or merge via GitHub web interface
```

#### Step 11: Automatic Release Happens!  

**No further action needed!** The `publish. yml` workflow automatically:

1.  **Builds** the package
2.  **Publishes** to npm registry
3. ️ **Creates** Git tag (e.g., `v1.2.3`)
4.  **Generates** changelog from commits
5.  **Creates** GitHub Release
6.  **Comments** on PR with success message

**Example success comment:**
```
 Successfully published version `1.2.3` to npm! 

 Package:  https://www.npmjs.com/package/@over88/typescript-sum-package/v/1.2.3
 Tag: `v1.2.3`
```

---

## 🏷️ Understanding Labels

### `publish` Label

**Purpose:** Indicates this PR should trigger a release when merged

**What it does:**
- Validates version bump
- Checks if version already exists on npm
- Builds release candidate with dev version
- Publishes to npm on merge
- Creates Git tag and GitHub Release

**When to use:** Any PR that should result in a new npm package version

```bash
gh pr edit <PR_NUMBER> --add-label publish
```

### `verify` Label

**Purpose:** Runs additional integration/E2E tests

**What it does:**
- Runs E2E test suite
- Provides extra validation before merge

**When to use:** For complex changes that need extra testing

```bash
gh pr edit <PR_NUMBER> --add-label