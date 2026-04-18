# Simple Vercel Setup - Just Install Scripts

No landing page needed. Just host the install scripts for your desktop app to curl.

## Quick Setup (5 minutes)

### 1. Update Install Scripts

Edit `scripts/install-vercel.sh` line 4:
```bash
REPO="YOUR_USERNAME/gogcli"
# Change to your actual GitHub username:
REPO="yourusername/gogcli"
```

Edit `scripts/install-vercel.ps1` line 3:
```powershell
$repo = "YOUR_USERNAME/gogcli"
# Change to:
$repo = "yourusername/gogcli"
```

### 2. Copy to Vercel Project

```bash
# In your Vercel project directory
mkdir -p public

# Copy the install scripts
cp scripts/install-vercel.sh public/install.sh
cp scripts/install-vercel.ps1 public/install.ps1
```

### 3. Deploy

```bash
vercel deploy --prod
```

### 4. Done!

Your install scripts are now available at:
- `https://yourdomain.com/install.sh`
- `https://yourdomain.com/install.ps1`

## Usage in Your Desktop App

### macOS/Linux Users

Your desktop app can trigger:
```bash
curl -fsSL https://yourdomain.com/install.sh | bash
```

Or download and execute:
```bash
curl -fsSL https://yourdomain.com/install.sh -o /tmp/install-gog.sh
chmod +x /tmp/install-gog.sh
/tmp/install-gog.sh
```

### Windows Users

Your desktop app can trigger:
```powershell
iwr https://yourdomain.com/install.ps1 | iex
```

Or download and execute:
```powershell
Invoke-WebRequest -Uri https://yourdomain.com/install.ps1 -OutFile $env:TEMP\install-gog.ps1
& $env:TEMP\install-gog.ps1
```

## Desktop App Integration Examples

### Electron (Node.js)

```javascript
const { exec } = require('child_process');
const os = require('os');

function installCLI() {
  const platform = os.platform();
  
  let command;
  if (platform === 'win32') {
    command = 'powershell -Command "iwr https://yourdomain.com/install.ps1 | iex"';
  } else {
    command = 'curl -fsSL https://yourdomain.com/install.sh | bash';
  }
  
  exec(command, (error, stdout, stderr) => {
    if (error) {
      console.error('Installation failed:', error);
      return;
    }
    console.log('CLI installed successfully');
  });
}
```

### Python

```python
import subprocess
import platform

def install_cli():
    system = platform.system()
    
    if system == 'Windows':
        cmd = ['powershell', '-Command', 
               'iwr https://yourdomain.com/install.ps1 | iex']
    else:
        cmd = ['bash', '-c', 
               'curl -fsSL https://yourdomain.com/install.sh | bash']
    
    subprocess.run(cmd, check=True)
```

### Swift (macOS)

```swift
import Foundation

func installCLI() {
    let script = "curl -fsSL https://yourdomain.com/install.sh | bash"
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", script]
    task.launch()
    task.waitUntilExit()
}
```

### C# (.NET)

```csharp
using System.Diagnostics;

public void InstallCLI()
{
    var isWindows = Environment.OSVersion.Platform == PlatformID.Win32NT;
    
    var startInfo = new ProcessStartInfo
    {
        FileName = isWindows ? "powershell.exe" : "/bin/bash",
        Arguments = isWindows 
            ? "-Command \"iwr https://yourdomain.com/install.ps1 | iex\""
            : "-c \"curl -fsSL https://yourdomain.com/install.sh | bash\"",
        UseShellExecute = false,
        RedirectStandardOutput = true
    };
    
    var process = Process.Start(startInfo);
    process.WaitForExit();
}
```

## Testing

Test the URLs work:

```bash
# Test macOS/Linux script
curl https://yourdomain.com/install.sh

# Test Windows script
curl https://yourdomain.com/install.ps1
```

Then test actual installation:

```bash
# macOS/Linux
curl -fsSL https://yourdomain.com/install.sh | bash

# Windows
iwr https://yourdomain.com/install.ps1 | iex
```

## GitHub Release

Don't forget to create the GitHub release with binaries:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Then upload all 6 binaries from `dist/` folder to the release.

## That's It!

Your desktop app can now install the CLI with a simple curl command.

**URLs to use:**
- macOS/Linux: `https://yourdomain.com/install.sh`
- Windows: `https://yourdomain.com/install.ps1`
