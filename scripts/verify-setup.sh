#!/bin/bash
# Verification script to check if everything is ready for distribution

set -e

echo "🔍 Verifying distribution setup..."
echo ""

# Check if credentials.json exists
echo "1. Checking OAuth credentials..."
if [ -f "internal/config/credentials.json" ]; then
    # Check if it's still the placeholder
    if grep -q "YOUR_CLIENT_ID" internal/config/credentials.json; then
        echo "   ⚠️  WARNING: credentials.json still has placeholder values"
        echo "   → Replace with your actual OAuth credentials"
    else
        echo "   ✅ credentials.json exists with real values"
    fi
else
    echo "   ❌ ERROR: internal/config/credentials.json not found"
    echo "   → Create this file with your OAuth credentials"
    exit 1
fi

# Check if credentials.json is in .gitignore
echo ""
echo "2. Checking .gitignore..."
if grep -q "internal/config/credentials.json" .gitignore; then
    echo "   ✅ credentials.json is in .gitignore"
else
    echo "   ⚠️  WARNING: credentials.json not in .gitignore"
    echo "   → Add it to prevent accidental commits"
fi

# Check if credentials.json is tracked by git
echo ""
echo "3. Checking git status..."
if git ls-files --error-unmatch internal/config/credentials.json 2>/dev/null; then
    echo "   ❌ ERROR: credentials.json is tracked by git!"
    echo "   → Run: git rm --cached internal/config/credentials.json"
    echo "   → Then commit the removal"
else
    echo "   ✅ credentials.json is not tracked by git"
fi

# Check if UserServices is configured correctly
echo ""
echo "4. Checking OAuth scopes configuration..."
if grep -A 10 "func UserServices()" internal/googleauth/service.go | grep -q "ServiceGmail"; then
    echo "   ✅ UserServices() is configured"
    echo "   Services enabled:"
    grep -A 10 "func UserServices()" internal/googleauth/service.go | grep "Service" | sed 's/^/      /'
else
    echo "   ⚠️  WARNING: Could not verify UserServices() configuration"
fi

# Check if build works
echo ""
echo "5. Testing build..."
if go build -o /tmp/gog-test ./cmd/gog 2>/dev/null; then
    echo "   ✅ Build successful"
    rm -f /tmp/gog-test
else
    echo "   ❌ ERROR: Build failed"
    echo "   → Run: go build ./cmd/gog"
    exit 1
fi

# Check if install scripts exist
echo ""
echo "6. Checking install scripts..."
if [ -f "scripts/install.sh" ]; then
    echo "   ✅ install.sh exists"
else
    echo "   ❌ ERROR: scripts/install.sh not found"
fi

if [ -f "scripts/install.ps1" ]; then
    echo "   ✅ install.ps1 exists"
else
    echo "   ❌ ERROR: scripts/install.ps1 not found"
fi

# Check if CHANGELOG has a version
echo ""
echo "7. Checking CHANGELOG..."
if [ -f "CHANGELOG.md" ]; then
    if grep -q "^## [0-9]" CHANGELOG.md; then
        echo "   ✅ CHANGELOG.md has version entries"
        echo "   Latest version:"
        grep "^## [0-9]" CHANGELOG.md | head -1 | sed 's/^/      /'
    else
        echo "   ⚠️  WARNING: No version entries in CHANGELOG.md"
        echo "   → Add a version section before releasing"
    fi
else
    echo "   ⚠️  WARNING: CHANGELOG.md not found"
fi

# Check if goreleaser is installed
echo ""
echo "8. Checking goreleaser..."
if command -v goreleaser >/dev/null 2>&1; then
    echo "   ✅ goreleaser is installed"
    goreleaser --version | head -1 | sed 's/^/      /'
else
    echo "   ⚠️  WARNING: goreleaser not installed"
    echo "   → Install: https://goreleaser.com/install/"
    echo "   → Or build manually (see DISTRIBUTION.md)"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Count issues
ERRORS=0
WARNINGS=0

if [ ! -f "internal/config/credentials.json" ]; then
    ERRORS=$((ERRORS + 1))
fi

if grep -q "YOUR_CLIENT_ID" internal/config/credentials.json 2>/dev/null; then
    WARNINGS=$((WARNINGS + 1))
fi

if git ls-files --error-unmatch internal/config/credentials.json 2>/dev/null; then
    ERRORS=$((ERRORS + 1))
fi

if ! go build -o /tmp/gog-test ./cmd/gog 2>/dev/null; then
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    echo "❌ $ERRORS error(s) found - fix before releasing"
    exit 1
elif [ $WARNINGS -gt 0 ]; then
    echo "⚠️  $WARNINGS warning(s) found - review before releasing"
    exit 0
else
    echo "✅ All checks passed! Ready to release."
    echo ""
    echo "Next steps:"
    echo "  1. Update CHANGELOG.md with version notes"
    echo "  2. Run: ./scripts/release.sh X.Y.Z"
    echo "  3. Run: goreleaser release --clean"
    exit 0
fi
