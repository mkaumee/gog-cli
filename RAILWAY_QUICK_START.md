# Railway Quick Start - 5 Minutes

## Step 1: Update Install Scripts (1 min)

Edit these files in `railway-project/` folder:

**`railway-project/install.sh`** (line 4):
```bash
REPO="yourusername/gogcli"
```

**`railway-project/install.ps1`** (line 3):
```powershell
$repo = "yourusername/gogcli"
```

## Step 2: Test Locally (Optional)

```bash
cd railway-project
npm install
npm start
```

Visit http://localhost:3000 - you should see the endpoints.

## Step 3: Push to GitHub (2 min)

```bash
cd railway-project
git init
git add .
git commit -m "Initial commit"

# Create new repo on GitHub, then:
git remote add origin https://github.com/yourusername/gog-cli-installer.git
git push -u origin main
```

## Step 4: Deploy to Railway (2 min)

1. Go to [railway.app](https://railway.app)
2. Sign in with GitHub
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Choose your `gog-cli-installer` repo
6. Railway auto-detects Node.js and deploys
7. Click "Generate Domain" button
8. Copy your URL: `https://your-app.up.railway.app`

## Done! ✅

Your install scripts are live at:
- `https://your-app.up.railway.app/install.sh`
- `https://your-app.up.railway.app/install.ps1`

## Use in Your Desktop App

**macOS/Linux:**
```bash
curl -fsSL https://your-app.up.railway.app/install.sh | bash
```

**Windows:**
```powershell
iwr https://your-app.up.railway.app/install.ps1 | iex
```

## Test It

```bash
# Test the endpoint
curl https://your-app.up.railway.app/install.sh

# Test actual installation
curl -fsSL https://your-app.up.railway.app/install.sh | bash
```

## Custom Domain (Optional)

In Railway dashboard:
1. Click your project
2. Go to "Settings" tab
3. Click "Generate Domain" or add custom domain
4. For custom: Add CNAME record in your DNS

Example: `cli.yourdomain.com` → Railway CNAME

Then use:
```bash
curl -fsSL https://cli.yourdomain.com/install.sh | bash
```

## Don't Forget

Create GitHub release with your binaries:

```bash
cd /path/to/gogcli
git tag v1.0.0
git push origin v1.0.0
```

Upload all 6 binaries from `dist/` folder to the release.

## Cost

Railway free tier:
- $5 credit/month
- More than enough for install scripts
- Upgrades available if needed

---

**That's it!** Railway URL → Desktop app → Users install CLI
