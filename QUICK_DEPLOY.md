# Quick Deploy - 3 Steps

## Step 1: Update Scripts (1 minute)

Edit these files and replace `YOUR_USERNAME` with your GitHub username:

**`scripts/install-vercel.sh`** (line 4):
```bash
REPO="yourusername/gogcli"
```

**`scripts/install-vercel.ps1`** (line 3):
```powershell
$repo = "yourusername/gogcli"
```

## Step 2: Copy to Vercel (1 minute)

```bash
# In your Vercel project directory
mkdir -p public
cp scripts/install-vercel.sh public/install.sh
cp scripts/install-vercel.ps1 public/install.ps1
```

## Step 3: Deploy (1 minute)

```bash
vercel deploy --prod
```

## Done! ✅

Your install scripts are now at:
- `https://yourdomain.com/install.sh`
- `https://yourdomain.com/install.ps1`

## Use in Your Desktop App

**macOS/Linux:**
```bash
curl -fsSL https://yourdomain.com/install.sh | bash
```

**Windows:**
```powershell
iwr https://yourdomain.com/install.ps1 | iex
```

## Don't Forget

Create GitHub release and upload binaries from `dist/` folder:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Then go to GitHub → Releases → Create new release → Upload all 6 binaries.

---

**That's it!** Your desktop app can now curl these URLs to install the CLI.
