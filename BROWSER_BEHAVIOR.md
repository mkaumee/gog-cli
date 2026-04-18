# Browser Opening Behavior

## How It Works

When you run `gog auth add your-email@gmail.com`, the CLI:

1. Starts a local OAuth callback server
2. Generates the authorization URL
3. **Attempts** to open your default browser automatically
4. Prints the URL to the terminal as a fallback
5. Waits for you to authorize

## Expected Output

```
Opening browser for authorization…
If the browser doesn't open, visit this URL:
https://accounts.google.com/o/oauth2/auth?client_id=...

Server listening on 127.0.0.1:8080
```

## Why Browser Might Not Auto-Open

The browser auto-open may not work in these scenarios:

### Windows
- Running from PowerShell with restricted execution policy
- Windows security settings blocking `rundll32`
- Running in a sandboxed environment
- No default browser configured
- Running as a different user

### macOS
- Running in a restricted terminal
- No default browser set
- Security settings blocking `open` command

### Linux
- No `xdg-open` available
- Running in headless environment
- No X11/Wayland session

## This is Normal!

The CLI is designed to work in both scenarios:
- ✅ **Auto-open works**: Browser opens automatically
- ✅ **Auto-open fails**: Copy/paste URL manually

Both methods work perfectly fine. The manual copy/paste is actually more reliable in many environments.

## User Instructions

### If Browser Opens Automatically
1. Browser opens to OAuth consent screen
2. Click "Allow"
3. Browser shows success page
4. Return to terminal - authentication complete!

### If Browser Doesn't Open
1. Copy the URL from terminal
2. Paste into your browser
3. Click "Allow" on OAuth consent screen
4. Browser shows success page
5. Return to terminal - authentication complete!

## For Desktop App Users

When your desktop app runs the install command, users might see the URL instead of auto-open. This is fine! You can:

### Option 1: Show Instructions
```
After installation, run:
  gog auth add your-email@gmail.com

Then:
  - If browser opens: Click "Allow"
  - If not: Copy the URL and paste in your browser
```

### Option 2: Detect and Help
```javascript
// In your desktop app
exec('gog auth add user@example.com', (error, stdout, stderr) => {
  // Check if URL is in output
  if (stderr.includes('https://accounts.google.com')) {
    // Extract URL and show in app
    const urlMatch = stderr.match(/(https:\/\/accounts\.google\.com[^\s]+)/);
    if (urlMatch) {
      // Show clickable link in your app
      showAuthURL(urlMatch[1]);
    }
  }
});
```

### Option 3: Use Manual Mode
Force manual mode for consistency:
```bash
gog auth add user@example.com --manual
```

This always shows the URL without attempting browser open.

## Testing

### Test Auto-Open
```bash
gog auth add test@example.com
# Should attempt to open browser
```

### Test Manual Mode
```bash
gog auth add test@example.com --manual
# Always shows URL, never attempts browser open
```

## Recommendation

For desktop app integration, consider:
1. Let the CLI try auto-open (default behavior)
2. Parse the output to detect if URL is shown
3. Display the URL as a clickable link in your app
4. Show instructions: "Click the link to authorize"

This gives the best experience - auto-open when it works, fallback when it doesn't.

## Summary

✅ Browser auto-open is a convenience feature, not a requirement
✅ Manual copy/paste always works
✅ Both methods complete OAuth successfully
✅ This is standard CLI behavior

The CLI is working correctly whether the browser opens automatically or not!
