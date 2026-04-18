# Pre-Deployment Checklist

Before you push anything, verify these items:

## ✅ Security Check

- [ ] `internal/config/credentials.json` has your real OAuth credentials
- [ ] `internal/config/credentials.json` is in `.gitignore`
- [ ] Run: `git status` - credentials.json should NOT appear
- [ ] If it appears, run: `git rm --cached internal/config/credentials.json`

## ✅ Binaries Check

- [ ] All 6 binaries exist in `dist/` folder
- [ ] Test one binary: `./dist/gog-windows-amd64.exe --version`
- [ ] Test OAuth scopes: `./dist/gog-windows-amd64.exe auth add test@example.com --dry-run`
- [ ] Verify only Gmail, Calendar, Drive, Docs scopes shown

## ✅ Git Check

- [ ] Run: `git status`
- [ ] Verify `dist/` folder is NOT being committed (should be in .gitignore)
- [ ] Verify `credentials.json` is NOT being committed
- [ ] Only source code should be committed

## ✅ Ready to Deploy

If all checks pass, you're ready to follow `COMPLETE_DEPLOYMENT_GUIDE.md`

## Quick Test

Run this to verify everything:

```bash
# Check credentials not tracked
git ls-files | grep credentials.json
# Should return nothing

# Check dist not tracked  
git ls-files | grep "^dist/"
# Should return nothing

# Check binary works
./dist/gog-windows-amd64.exe auth add test@example.com --dry-run
# Should show correct scopes
```

If all tests pass ✅, proceed to `COMPLETE_DEPLOYMENT_GUIDE.md`
