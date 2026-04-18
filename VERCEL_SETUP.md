# Vercel Website Setup for CLI Distribution

Host your install scripts on Vercel for a professional distribution experience.

## 1. Prepare Install Scripts for Vercel

I've created optimized scripts in `scripts/`:
- `install-vercel.sh` - For macOS/Linux
- `install-vercel.ps1` - For Windows

**Update the REPO variable** in both files:
```bash
# Change this line in both files:
REPO="YOUR_USERNAME/gogcli"
# To:
REPO="yourusername/gogcli"
```

## 2. Vercel Project Structure

Create this structure in your Vercel project:

```
your-vercel-project/
├── public/
│   ├── install.sh          (copy from scripts/install-vercel.sh)
│   └── install.ps1         (copy from scripts/install-vercel.ps1)
└── pages/
    └── cli.html            (or cli.tsx if using React)
```

## 3. Copy Install Scripts to Vercel

```bash
# Copy to your Vercel project
cp scripts/install-vercel.sh /path/to/your-vercel-project/public/install.sh
cp scripts/install-vercel.ps1 /path/to/your-vercel-project/public/install.ps1
```

## 4. Create CLI Landing Page

### Option A: Simple HTML Page

Create `public/cli.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gmail CLI - Command Line Tool</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            max-width: 800px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        h1 {
            font-size: 3em;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .subtitle {
            font-size: 1.3em;
            color: #666;
            margin-bottom: 40px;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        .feature {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        .feature h3 {
            color: #667eea;
            margin-bottom: 10px;
        }
        .install-section {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
        }
        .install-section h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .command-box {
            background: #1e1e1e;
            color: #d4d4d4;
            padding: 20px;
            border-radius: 10px;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            margin: 10px 0;
            position: relative;
            overflow-x: auto;
        }
        .command-box code {
            color: #4ec9b0;
        }
        .copy-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #667eea;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.8em;
        }
        .copy-btn:hover {
            background: #764ba2;
        }
        .platform-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .tab {
            padding: 10px 20px;
            background: #e0e0e0;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
        }
        .tab.active {
            background: #667eea;
            color: white;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .quick-start {
            margin-top: 30px;
        }
        .quick-start h3 {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🧭 Gmail CLI</h1>
        <p class="subtitle">Command-line tool for Gmail, Calendar, Drive, and Docs</p>
        
        <div class="features">
            <div class="feature">
                <h3>📧 Gmail</h3>
                <p>Send, search, and manage emails</p>
            </div>
            <div class="feature">
                <h3>📅 Calendar</h3>
                <p>Manage events and invitations</p>
            </div>
            <div class="feature">
                <h3>📁 Drive</h3>
                <p>Upload, download, organize files</p>
            </div>
            <div class="feature">
                <h3>📝 Docs</h3>
                <p>Create and edit documents</p>
            </div>
        </div>

        <div class="install-section">
            <h2>Installation</h2>
            
            <div class="platform-tabs">
                <button class="tab active" onclick="showTab('mac')">macOS/Linux</button>
                <button class="tab" onclick="showTab('windows')">Windows</button>
            </div>

            <div id="mac-content" class="tab-content active">
                <div class="command-box">
                    <code>curl -fsSL https://yourdomain.com/install.sh | bash</code>
                    <button class="copy-btn" onclick="copyCommand('mac')">Copy</button>
                </div>
            </div>

            <div id="windows-content" class="tab-content">
                <p style="margin-bottom: 10px;">Run in PowerShell:</p>
                <div class="command-box">
                    <code>iwr https://yourdomain.com/install.ps1 | iex</code>
                    <button class="copy-btn" onclick="copyCommand('windows')">Copy</button>
                </div>
            </div>
        </div>

        <div class="quick-start">
            <h3>Quick Start</h3>
            <div class="command-box">
                <code># Authenticate<br>gog auth add your-email@gmail.com<br><br># List emails<br>gog gmail list<br><br># List calendar events<br>gog calendar list</code>
            </div>
        </div>
    </div>

    <script>
        function showTab(platform) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(el => {
                el.classList.remove('active');
            });
            document.querySelectorAll('.tab').forEach(el => {
                el.classList.remove('active');
            });
            
            // Show selected tab
            document.getElementById(platform + '-content').classList.add('active');
            event.target.classList.add('active');
        }

        function copyCommand(platform) {
            const commands = {
                'mac': 'curl -fsSL https://yourdomain.com/install.sh | bash',
                'windows': 'iwr https://yourdomain.com/install.ps1 | iex'
            };
            
            navigator.clipboard.writeText(commands[platform]).then(() => {
                event.target.textContent = 'Copied!';
                setTimeout(() => {
                    event.target.textContent = 'Copy';
                }, 2000);
            });
        }
    </script>
</body>
</html>
```

### Option B: React/Next.js Component

If using Next.js, create `pages/cli.tsx`:

```tsx
import { useState } from 'react';

export default function CLI() {
  const [platform, setPlatform] = useState<'mac' | 'windows'>('mac');
  
  const commands = {
    mac: 'curl -fsSL https://yourdomain.com/install.sh | bash',
    windows: 'iwr https://yourdomain.com/install.ps1 | iex'
  };

  const copyCommand = () => {
    navigator.clipboard.writeText(commands[platform]);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 to-indigo-700 flex items-center justify-center p-8">
      <div className="bg-white rounded-3xl p-16 max-w-4xl shadow-2xl">
        <h1 className="text-6xl font-bold mb-6 bg-gradient-to-r from-purple-600 to-indigo-700 bg-clip-text text-transparent">
          🧭 Gmail CLI
        </h1>
        <p className="text-2xl text-gray-600 mb-12">
          Command-line tool for Gmail, Calendar, Drive, and Docs
        </p>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-6 mb-12">
          {[
            { icon: '📧', title: 'Gmail', desc: 'Send, search, manage' },
            { icon: '📅', title: 'Calendar', desc: 'Events & invitations' },
            { icon: '📁', title: 'Drive', desc: 'Files & folders' },
            { icon: '📝', title: 'Docs', desc: 'Create & edit' }
          ].map(feature => (
            <div key={feature.title} className="bg-gray-50 p-6 rounded-xl">
              <div className="text-3xl mb-2">{feature.icon}</div>
              <h3 className="font-bold text-purple-600 mb-1">{feature.title}</h3>
              <p className="text-sm text-gray-600">{feature.desc}</p>
            </div>
          ))}
        </div>

        <div className="bg-gray-50 p-8 rounded-2xl mb-8">
          <h2 className="text-2xl font-bold mb-6">Installation</h2>
          
          <div className="flex gap-4 mb-6">
            <button
              onClick={() => setPlatform('mac')}
              className={`px-6 py-3 rounded-lg font-medium ${
                platform === 'mac'
                  ? 'bg-purple-600 text-white'
                  : 'bg-gray-200 text-gray-700'
              }`}
            >
              macOS/Linux
            </button>
            <button
              onClick={() => setPlatform('windows')}
              className={`px-6 py-3 rounded-lg font-medium ${
                platform === 'windows'
                  ? 'bg-purple-600 text-white'
                  : 'bg-gray-200 text-gray-700'
              }`}
            >
              Windows
            </button>
          </div>

          <div className="relative">
            <pre className="bg-gray-900 text-green-400 p-6 rounded-xl overflow-x-auto">
              <code>{commands[platform]}</code>
            </pre>
            <button
              onClick={copyCommand}
              className="absolute top-4 right-4 bg-purple-600 text-white px-4 py-2 rounded-lg hover:bg-purple-700"
            >
              Copy
            </button>
          </div>
        </div>

        <div>
          <h3 className="text-xl font-bold mb-4">Quick Start</h3>
          <pre className="bg-gray-900 text-green-400 p-6 rounded-xl overflow-x-auto">
            <code>{`# Authenticate
gog auth add your-email@gmail.com

# List emails
gog gmail list

# List calendar events
gog calendar list`}</code>
          </pre>
        </div>
      </div>
    </div>
  );
}
```

## 5. Deploy to Vercel

```bash
# In your Vercel project directory
vercel deploy --prod
```

Your install scripts will be available at:
- `https://yourdomain.com/install.sh`
- `https://yourdomain.com/install.ps1`

## 6. Update Your Main Website

Add a "CLI" or "Download" button that links to:
```
https://yourdomain.com/cli
```

Or embed the install commands directly on your homepage.

## 7. Test Installation

After deploying:

**macOS/Linux:**
```bash
curl -fsSL https://yourdomain.com/install.sh | bash
```

**Windows:**
```powershell
iwr https://yourdomain.com/install.ps1 | iex
```

## 8. Marketing Copy for Your Site

### Hero Section
```
Command Your Gmail
Powerful CLI for Gmail, Calendar, Drive & Docs

[Install Now] [View Docs]
```

### Features Section
```
⚡ Lightning Fast
Search, send, and manage emails from your terminal

🔒 Secure
OAuth authentication with your Google account

🤖 Automation Ready
Perfect for scripts, cron jobs, and workflows

📦 Easy Install
One command to get started
```

### Installation Section
```
Get Started in Seconds

macOS/Linux:
curl -fsSL https://yourdomain.com/install.sh | bash

Windows:
iwr https://yourdomain.com/install.ps1 | iex
```

## 9. SEO & Social Meta Tags

Add to your CLI page:

```html
<meta name="description" content="Command-line tool for Gmail, Calendar, Drive, and Docs. Fast, secure, automation-ready.">
<meta property="og:title" content="Gmail CLI - Command Your Gmail">
<meta property="og:description" content="Powerful command-line tool for Gmail, Calendar, Drive & Docs">
<meta property="og:image" content="https://yourdomain.com/og-image.png">
<meta name="twitter:card" content="summary_large_image">
```

## 10. Analytics (Optional)

Track installations by adding to your install scripts:

```bash
# At the end of install.sh
curl -s "https://yourdomain.com/api/track-install?os=$OS&arch=$ARCH" > /dev/null || true
```

Create API endpoint in Vercel to log installations.

## File Checklist

- [ ] Copy `scripts/install-vercel.sh` to Vercel project as `public/install.sh`
- [ ] Copy `scripts/install-vercel.ps1` to Vercel project as `public/install.ps1`
- [ ] Update REPO variable in both scripts
- [ ] Create CLI landing page (`cli.html` or `cli.tsx`)
- [ ] Update domain in HTML/React code
- [ ] Deploy to Vercel
- [ ] Test both install commands
- [ ] Add link from main website

## Next Steps

1. Deploy to Vercel
2. Test installation from your domain
3. Add CLI page to your main navigation
4. Share the install command with users
5. Monitor usage and gather feedback

Your users will love the one-line install experience! 🚀
