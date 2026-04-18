# Vercel Deployment Checklist

Quick checklist for deploying your CLI with Vercel hosting.

## ✅ Pre-Deployment

- [x] Binaries compiled in `dist/` folder
- [x] Install scripts created
- [x] Landing page template ready
- [ ] Update REPO variable in install scripts
- [ ] Update domain in HTML template

## 📋 Step-by-Step Deployment

### 1. Update Install Scripts (2 minutes)

Edit these files and replace `YOUR_USERNAME`:

**`scripts/install-vercel.sh`** (line 4):
```bash
REPO="YOUR_USERNAME/gogcli"
# Change to:
REPO="yourusername/gogcli"
```

**`scripts/install-vercel.ps1`** (line 3):
```powershell
$repo = "YOUR_USERNAME/gogcli"
# Change to:
$repo = "yourusername/gogcli"
```

### 2. Update Landing Page (1 minute)

Edit `vercel-page-template.html` and replace `yourdomain.com`:

```html
<!-- Line 95 and 103 -->
curl -fsSL https://yourdomain.com/install.sh | bash
iwr https://yourdomain.com/install.ps1 | iex

<!-- Change to: -->
curl -fsSL https://yourrealdomain.com/install.sh | bash
iwr https://yourrealdomain.com/install.ps1 | iex
```

### 3. Setup Vercel Project (3 minutes)

In your Vercel project directory:

```bash
# Create public folder if it doesn't exist
mkdir -p public

# Copy install scripts
cp scripts/install-vercel.sh public/install.sh
cp scripts/install-vercel.ps1 public/install.ps1

# Copy landing page
cp vercel-page-template.html public/cli.html
# OR if using pages directory:
cp vercel-page-template.html pages/cli.html
```

Your structure should look like:
```
your-vercel-project/
├── public/
│   ├── install.sh
│   ├── install.ps1
│   └── cli.html (or in pages/)
└── vercel.json (optional)
```

### 4. Deploy to Vercel (1 minute)

```bash
# From your Vercel project directory
vercel deploy --prod
```

Or push to GitHub and let Vercel auto-deploy.

### 5. Verify Deployment (2 minutes)

Test that files are accessible:

```bash
# Test install scripts are accessible
curl https://yourdomain.com/install.sh
curl https://yourdomain.com/install.ps1

# Test landing page
# Visit: https://yourdomain.com/cli.html
```

### 6. Test Installation (3 minutes)

**macOS/Linux:**
```bash
curl -fsSL https://yourdomain.com/install.sh | bash
gog --version
```

**Windows:**
```powershell
iwr https://yourdomain.com/install.ps1 | iex
gog --version
```

### 7. Create GitHub Release (5 minutes)

```bash
# Tag and push
git add .
git commit -m "Add Vercel deployment setup"
git push origin main

git tag v1.0.0
git push origin v1.0.0
```

On GitHub:
1. Go to Releases → Create new release
2. Tag: v1.0.0
3. Upload all 6 binaries from `dist/` folder
4. Publish

### 8. Update Main Website (5 minutes)

Add a button/link to your main site:

```html
<a href="/cli" class="btn">
  Download CLI Tool
</a>
```

Or embed the install command directly:

```html
<section class="cli-section">
  <h2>Command Line Tool</h2>
  <p>Install with one command:</p>
  <pre><code>curl -fsSL https://yourdomain.com/install.sh | bash</code></pre>
  <a href="/cli">Learn more →</a>
</section>
```

## 🎯 Final Verification

- [ ] Install scripts accessible at your domain
- [ ] Landing page loads at `/cli` or `/cli.html`
- [ ] GitHub release created with binaries
- [ ] Installation works on macOS/Linux
- [ ] Installation works on Windows
- [ ] Main website links to CLI page
- [ ] Commands in landing page have correct domain

## 📱 Share With Users

Once deployed, share this with your users:

### Email Template

```
Subject: New Gmail CLI Tool Available

Hi team,

We've launched a new command-line tool for Gmail, Calendar, Drive, and Docs.

Install with one command:

macOS/Linux:
curl -fsSL https://yourdomain.com/install.sh | bash

Windows:
iwr https://yourdomain.com/install.ps1 | iex

Get started:
gog auth add your-email@company.com
gog gmail list

Learn more: https://yourdomain.com/cli

Questions? Reply to this email.
```

### Slack/Teams Message

```
🚀 New Tool: Gmail CLI

Command-line access to Gmail, Calendar, Drive & Docs

Install: https://yourdomain.com/cli

Quick start:
```bash
gog auth add your-email@company.com
gog gmail list
```

Perfect for automation and power users!
```

### Social Media Post

```
🧭 Just launched: Gmail CLI

Fast, secure command-line tool for Gmail, Calendar, Drive & Docs

One-line install:
curl -fsSL https://yourdomain.com/install.sh | bash

Perfect for automation & scripts

Learn more: https://yourdomain.com/cli

#CLI #Gmail #Productivity
```

## 🔧 Troubleshooting

### Install script returns 404
- Check files are in `public/` folder
- Verify Vercel deployment succeeded
- Check file names are exactly `install.sh` and `install.ps1`

### Landing page not found
- If using `cli.html`, access via `/cli.html`
- Or rename to `cli/index.html` for `/cli` URL
- Check Vercel build logs

### Installation fails
- Verify GitHub release is published (not draft)
- Check binaries are attached to release
- Verify REPO variable in install scripts is correct

### Wrong domain in commands
- Update all instances of `yourdomain.com` in:
  - `vercel-page-template.html`
  - `scripts/install-vercel.sh`
  - `scripts/install-vercel.ps1`

## 📊 Optional: Track Installations

Add to end of `install.sh`:

```bash
# Track installation (optional)
curl -s "https://yourdomain.com/api/track?os=$OS&arch=$ARCH" > /dev/null 2>&1 || true
```

Create Vercel serverless function at `api/track.js`:

```javascript
export default function handler(req, res) {
  const { os, arch } = req.query;
  console.log(`Installation: ${os} ${arch}`);
  // Log to your analytics service
  res.status(200).json({ success: true });
}
```

## ✅ Deployment Complete!

Your CLI is now:
- ✅ Compiled for all platforms
- ✅ Hosted on Vercel
- ✅ One-line installation
- ✅ Professional landing page
- ✅ Ready for users

**Total time: ~20 minutes**

Next: Share with your users and gather feedback! 🎉
