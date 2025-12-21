#!/bin/bash
# Script to initialize the repository

set -e

echo "[INFO!] Setting up TypeScript Sum Package repository..."

# Initialize npm project
echo "[INFO!] Installing dependencies..."
npm install

# Generate package-lock.json
echo "[INFO!] Generating lockfile..."
npm install --package-lock-only

# Run initial build
echo "Running initial build..."
npm run build

# Run tests
echo "[INFO!] Running tests..."
npm test

echo "[INFO!] Repository setup complete!"
echo ""
echo "Next steps:"
echo "1. Create repository on GitHub"
echo "2. Add NPM_TOKEN secret to repository settings"
echo "3. Run branch protection setup:  gh workflow run setup-branch-protection.yml"
echo "4. Create your first PR with the 'publish' label to release v1.0.0"
