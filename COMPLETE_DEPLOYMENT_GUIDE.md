# Complete Deployment Guide - Start to Finish

Everything you need to deploy your Gmail CLI from scratch.

## Part 1: Push gogcli to GitHub (5 minutes)

### Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `gogcli` (or whatever you want)
3. Description: "Gmail CLI with embedded OAuth"
4. Choose Public or Private
5. Don't initialize with README (you already have one)
6. Click "Create repository"

### Step 2: Verify Credentials Not in Git

```bash
# Make sure credentials.json is not tracked
git status

# Should NOT show internal/config/credentials.json
# If it does, remove it:
git rm --cached internal/config/credentials.json
```

### Step 3: Push Your Code

```bash
# In your gogcli directory
git init  # (if not already initialized)
git add .
git commit -m "Initial commit with embedded OAuth"

# Add your GitHub repo as remote
git remote add origin https://github.com/YOUR_USERNAME/gogcli.git

# Push
git push -u origin main
```

If you get an error about branch name, try:
```bash
git branch -M main
git push -u origin main
```

### Step 4: Create First Release

```bash
# Create and push tag
git tag v1.0.0
git push origin v1.0.0
```

### Step 5: Upload Binaries to GitHub Release

1. Go to your repo: `https://github.com/YOUR_USERNAME/gogcli`
2. Click "Releases" (right sidebar)
3. Click "Create a new release"
4. Choose tag: `v1.0.0`
5. Release title: `v1.0.0 - Initial Release`
6. Description:
   ```markdown
   ## Gmail CLI v1.0.0
   
   Command-line tool for Gmail, Calendar, Drive, and Docs.
   
   ### Installation
   
   See installation instructions at: [your Railway URL when ready]
   
   ### Features
   - Gmail: Send, search, manage emails
   - Calendar: Manage events
   - Drive: Upload, download files
   - Docs: Create, edit documents
   ```
7. **Upload binaries**: Drag all 6 files from `dist/` folder:
   - gog-windows-amd64.exe
   - gog-windows-arm64.exe
   - gog-linux-amd64
   - gog-linux-arm64
   - gog-darwin-amd64
   - gog-darwin-arm64
8. Click "Publish release"

### Step 6: Verify Release

Visit: `https://github.com/YOUR_USERNAME/gogcli/releases/latest`

You should see all 6 binaries available for download.

## Part 2: Update Install Scripts (2 minutes)

Now that you have your GitHub repo, update the install scripts:

### Update railway-project/install.sh

Edit line 4:
```bash
REPO="YOUR_USERNAME/gogcli"
```

Change to:
```bash
REPO="youractualusername/gogcli"
```

### Update railway-project/install.ps1

Edit line 3:
```powershell
$repo = "YOUR_USERNAME/gogcli"
```

Change to:
```powershell
$repo = "youractualusername/gogcli"
```

## Part 3: Deploy Railway Project (5 minutes)

### Step 1: Create Railway Installer Repo

1. Go to https://github.com/new
2. Repository name: `gog-cli-installer`
3. Description: "Install scripts for Gmail CLI"
4. Public
5. Click "Create repository"

### Step 2: Push Railway Project

```bash
cd railway-project
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/gog-cli-installer.git
git push -u origin main
```

### Step 3: Deploy on Railway

1. Go to https://railway.app
2. Sign in with GitHub
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Choose `gog-cli-installer`
6. Railway auto-detects Node.js and deploys
7. Wait for deployment (1-2 minutes)
8. Click "Settings" tab
9. Click "Generate Domain"
10. Copy your URL: `https://your-app.up.railway.app`

### Step 4: Test Your Endpoints

```bash
# Test info endpoint
curl https://your-app.up.railway.app/

# Test install script
curl https://your-app.up.railway.app/install.sh

# Should show your install script with correct GitHub repo
```

## Part 4: Test Complete Installation (3 minutes)

### Test on Your Machine

**macOS/Linux:**
```bash
curl -fsSL https://your-app.up.railway.app/install.sh | bash
```

**Windows:**
```powershell
iwr https://your-app.up.railway.app/install.ps1 | iex
```

### Verify Installation

```bash
# Check version
gog --version

# Test OAuth (dry run)
gog auth add test@example.com --dry-run

# Should show only Gmail, Calendar, Drive, Docs scopes
```

### Test Real Authentication

```bash
gog auth add your-email@gmail.com
```

Should:
1. Open browser
2. Show YOUR company's OAuth consent screen
3. Request only Gmail, Calendar, Drive, Docs permissions
4. Complete successfully

## Part 5: Integrate into Desktop App

Now you have your Railway URL, use it in your desktop app:

**macOS/Linux users:**
```bash
curl -fsSL https://your-app.up.railway.app/install.sh | bash
```

**Windows users:**
```powershell
iwr https://your-app.up.railway.app/install.ps1 | iex
```

## Summary of What You Created

### GitHub Repositories

1. **gogcli** - Your main CLI repository
   - URL: `https://github.com/YOUR_USERNAME/gogcli`
   - Contains: Source code, binaries in releases

2. **gog-cli-installer** - Railway installer project
   - URL: `https://github.com/YOUR_USERNAME/gog-cli-installer`
   - Contains: Express server, install scripts

### Railway Deployment

- URL: `https://your-app.up.railway.app`
- Endpoints:
  - `/` - Info
  - `/install.sh` - macOS/Linux installer
  - `/install.ps1` - Windows installer

## Troubleshooting

### "Repository not found" during install

- Check REPO variable in install scripts matches your GitHub username
- Verify GitHub release exists and is published
- Make sure binaries are uploaded to the release

### Railway deployment fails

- Check `package.json` is valid
- Verify `server.js` has no syntax errors
- Check Railway logs in dashboard

### Install script downloads but fails

- Verify GitHub release is public (or repo is public)
- Check binary names match exactly in install script
- Test binary download manually:
  ```bash
  curl -L https://github.com/YOUR_USERNAME/gogcli/releases/latest/download/gog-linux-amd64 -o gog
  ```

## Checklist

- [ ] gogcli repo created on GitHub
- [ ] Code pushed to GitHub
- [ ] Tag v1.0.0 created and pushed
- [ ] GitHub release created
- [ ] All 6 binaries uploaded to release
- [ ] Install scripts updated with correct GitHub username
- [ ] gog-cli-installer repo created
- [ ] Railway project pushed to GitHub
- [ ] Railway deployment successful
- [ ] Railway domain generated
- [ ] Install scripts tested
- [ ] OAuth flow tested
- [ ] Railway URL integrated into desktop app

## You're Done! 🎉

Your complete setup:
1. ✅ Source code on GitHub
2. ✅ Binaries in GitHub releases
3. ✅ Install scripts on Railway
4. ✅ Ready for desktop app integration

**Total time: ~15 minutes**

Users can now install with one command from your desktop app!
