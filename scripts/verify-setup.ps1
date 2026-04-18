# Verification script to check if everything is ready for distribution
$ErrorActionPreference = "Continue"

Write-Host "Verifying distribution setup..." -ForegroundColor Cyan
Write-Host ""

$errors = 0
$warnings = 0

# Check if credentials.json exists
Write-Host "1. Checking OAuth credentials..."
if (Test-Path "internal/config/credentials.json") {
    $content = Get-Content "internal/config/credentials.json" -Raw
    if ($content -match "YOUR_CLIENT_ID") {
        Write-Host "   WARNING: credentials.json still has placeholder values" -ForegroundColor Yellow
        Write-Host "   Replace with your actual OAuth credentials"
        $warnings++
    } else {
        Write-Host "   OK: credentials.json exists with real values" -ForegroundColor Green
    }
} else {
    Write-Host "   ERROR: internal/config/credentials.json not found" -ForegroundColor Red
    Write-Host "   Create this file with your OAuth credentials"
    $errors++
}

# Check if credentials.json is in .gitignore
Write-Host ""
Write-Host "2. Checking .gitignore..."
if (Test-Path ".gitignore") {
    $gitignore = Get-Content ".gitignore" -Raw
    if ($gitignore -match "internal/config/credentials.json") {
        Write-Host "   OK: credentials.json is in .gitignore" -ForegroundColor Green
    } else {
        Write-Host "   WARNING: credentials.json not in .gitignore" -ForegroundColor Yellow
        Write-Host "   Add it to prevent accidental commits"
        $warnings++
    }
}

# Check if credentials.json is tracked by git
Write-Host ""
Write-Host "3. Checking git status..."
$gitLsFiles = git ls-files internal/config/credentials.json 2>$null
if ($gitLsFiles) {
    Write-Host "   ERROR: credentials.json is tracked by git!" -ForegroundColor Red
    Write-Host "   Run: git rm --cached internal/config/credentials.json"
    Write-Host "   Then commit the removal"
    $errors++
} else {
    Write-Host "   OK: credentials.json is not tracked by git" -ForegroundColor Green
}

# Check if UserServices is configured correctly
Write-Host ""
Write-Host "4. Checking OAuth scopes configuration..."
if (Test-Path "internal/googleauth/service.go") {
    $serviceGo = Get-Content "internal/googleauth/service.go" -Raw
    if ($serviceGo -match "func UserServices\(\).*ServiceGmail") {
        Write-Host "   OK: UserServices() is configured" -ForegroundColor Green
    } else {
        Write-Host "   WARNING: Could not verify UserServices() configuration" -ForegroundColor Yellow
        $warnings++
    }
}

# Check if build works
Write-Host ""
Write-Host "5. Testing build..."
$buildOutput = go build -o "$env:TEMP\gog-test.exe" ./cmd/gog 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "   OK: Build successful" -ForegroundColor Green
    Remove-Item "$env:TEMP\gog-test.exe" -ErrorAction SilentlyContinue
} else {
    Write-Host "   ERROR: Build failed" -ForegroundColor Red
    Write-Host "   Run: go build ./cmd/gog"
    $errors++
}

# Check if install scripts exist
Write-Host ""
Write-Host "6. Checking install scripts..."
if (Test-Path "scripts/install.sh") {
    Write-Host "   OK: install.sh exists" -ForegroundColor Green
} else {
    Write-Host "   ERROR: scripts/install.sh not found" -ForegroundColor Red
    $errors++
}

if (Test-Path "scripts/install.ps1") {
    Write-Host "   OK: install.ps1 exists" -ForegroundColor Green
} else {
    Write-Host "   ERROR: scripts/install.ps1 not found" -ForegroundColor Red
    $errors++
}

# Check if CHANGELOG has a version
Write-Host ""
Write-Host "7. Checking CHANGELOG..."
if (Test-Path "CHANGELOG.md") {
    $changelog = Get-Content "CHANGELOG.md" -Raw
    if ($changelog -match "^## \d+\.\d+\.\d+") {
        Write-Host "   OK: CHANGELOG.md has version entries" -ForegroundColor Green
        $firstVersion = ($changelog -split "`n" | Where-Object { $_ -match "^## \d" } | Select-Object -First 1)
        Write-Host "   Latest version: $firstVersion"
    } else {
        Write-Host "   WARNING: No version entries in CHANGELOG.md" -ForegroundColor Yellow
        Write-Host "   Add a version section before releasing"
        $warnings++
    }
} else {
    Write-Host "   WARNING: CHANGELOG.md not found" -ForegroundColor Yellow
    $warnings++
}

# Check if goreleaser is installed
Write-Host ""
Write-Host "8. Checking goreleaser..."
$goreleaserVersion = goreleaser --version 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "   OK: goreleaser is installed" -ForegroundColor Green
    Write-Host "      $($goreleaserVersion | Select-Object -First 1)"
} else {
    Write-Host "   WARNING: goreleaser not installed" -ForegroundColor Yellow
    Write-Host "   Install: https://goreleaser.com/install/"
    Write-Host "   Or build manually (see DISTRIBUTION.md)"
    $warnings++
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($errors -gt 0) {
    Write-Host "$errors error(s) found - fix before releasing" -ForegroundColor Red
    exit 1
} elseif ($warnings -gt 0) {
    Write-Host "$warnings warning(s) found - review before releasing" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "All checks passed! Ready to release." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "  1. Update CHANGELOG.md with version notes"
    Write-Host "  2. Run: ./scripts/release.sh X.Y.Z"
    Write-Host "  3. Run: goreleaser release --clean"
    exit 0
}
