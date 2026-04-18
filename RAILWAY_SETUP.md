# Railway Setup - Host Install Scripts

Simple static file hosting on Railway for your install scripts.

## Quick Setup (5 minutes)

### Step 1: Create Railway Project Structure

Create a new folder for your Railway project:

```bash
mkdir gog-cli-installer
cd gog-cli-installer
```

### Step 2: Copy Install Scripts

```bash
# Copy the install scripts
cp /path/to/gogcli/scripts/install-vercel.sh install.sh
cp /path/to/gogcli/scripts/install-vercel.ps1 install.ps1
```

### Step 3: Update Scripts

Edit `install.sh` line 4:
```bash
REPO="yourusername/gogcli"
```

Edit `install.ps1` line 3:
```powershell
$repo = "yourusername/gogcli"
```

### Step 4: Create Simple Web Server

Create `server.js`:

```javascript
const express = require('express');
const path = require('path');
const app = express();

const PORT = process.env.PORT || 3000;

// Serve install scripts with correct content-type
app.get('/install.sh', (req, res) => {
  res.type('text/plain');
  res.sendFile(path.join(__dirname, 'install.sh'));
});

app.get('/install.ps1', (req, res) => {
  res.type('text/plain');
  res.sendFile(path.join(__dirname, 'install.ps1'));
});

// Health check
app.get('/', (req, res) => {
  res.json({
    status: 'ok',
    endpoints: {
      'macOS/Linux': '/install.sh',
      'Windows': '/install.ps1'
    }
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

### Step 5: Create package.json

```json
{
  "name": "gog-cli-installer",
  "version": "1.0.0",
  "description": "Install scripts for gog CLI",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  },
  "engines": {
    "node": ">=18.0.0"
  }
}
```

### Step 6: Initialize Git

```bash
git init
git add .
git commit -m "Initial commit"
```

### Step 7: Deploy to Railway

1. Go to [railway.app](https://railway.app)
2. Click "New Project"
3. Choose "Deploy from GitHub repo" (or "Empty Project")
4. If empty project:
   - Connect your GitHub account
   - Push your code to a new GitHub repo
   - Select that repo in Railway
5. Railway will auto-detect Node.js and deploy
6. Click "Generate Domain" to get your public URL

### Step 8: Done!

Your install scripts are now at:
- `https://your-app.up.railway.app/install.sh`
- `https://your-app.up.railway.app/install.ps1`

## Alternative: Static File Hosting (Even Simpler)

If you don't want Node.js, use Railway's static hosting:

### Create `railway.json`:

```json
{
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "python3 -m http.server $PORT",
    "restartPolicyType": "ON_FAILURE"
  }
}
```

Put your scripts in the root and Railway will serve them.

## Use in Your Desktop App

**macOS/Linux:**
```bash
curl -fsSL https://your-app.up.railway.app/install.sh | bash
```

**Windows:**
```powershell
iwr https://your-app.up.railway.app/install.ps1 | iex
```

## Custom Domain (Optional)

In Railway dashboard:
1. Go to your project
2. Click "Settings"
3. Add custom domain: `cli.yourdomain.com`
4. Update DNS with provided CNAME

Then use:
```bash
curl -fsSL https://cli.yourdomain.com/install.sh | bash
```

## Testing

```bash
# Test endpoints
curl https://your-app.up.railway.app/install.sh
curl https://your-app.up.railway.app/install.ps1

# Test installation
curl -fsSL https://your-app.up.railway.app/install.sh | bash
```

## Project Structure

```
gog-cli-installer/
├── server.js
├── package.json
├── install.sh
├── install.ps1
└── .gitignore
```

## .gitignore

```
node_modules/
.env
```

## Cost

Railway free tier includes:
- $5 free credit per month
- Should be more than enough for serving install scripts
- Very low traffic usage

## That's It!

Railway will give you a URL like `https://your-app.up.railway.app` that your desktop app can curl.
