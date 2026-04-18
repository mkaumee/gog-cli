# OAuth Setup Summary

## What Was Done

Your CLI has been configured to use embedded OAuth credentials and request only the scopes you've approved in your Google Cloud Console.

## Changes Made

1. **Embedded Credentials Support**
   - Created `internal/config/credentials_embed.go` - Handles embedding credentials at compile time
   - Created `internal/config/credentials.json` - Placeholder for your OAuth client credentials
   - Updated `internal/config/credentials.go` - Falls back to embedded credentials automatically
   - Added `credentials.json` to `.gitignore` - Prevents accidental commits

2. **Limited OAuth Scopes**
   - Updated `internal/googleauth/service.go` - `UserServices()` now returns only: Gmail, Calendar, Drive, Docs
   - These match the scopes you enabled in your OAuth consent screen

3. **Documentation**
   - `internal/config/EMBEDDED_CREDENTIALS.md` - Setup instructions
   - `internal/config/OAUTH_SCOPES.md` - Scope configuration details
   - `OAUTH_SETUP_SUMMARY.md` - This file

## Next Steps

### 1. Add Your OAuth Credentials

Replace the placeholder content in `internal/config/credentials.json` with your actual credentials from Google Cloud Console:

```json
{
  "installed": {
    "client_id": "YOUR_ACTUAL_CLIENT_ID.apps.googleusercontent.com",
    "client_secret": "YOUR_ACTUAL_CLIENT_SECRET",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "redirect_uris": ["http://localhost"]
  }
}
```

### 2. Build the Binary

```bash
make build
# or
go build -o bin/gog.exe ./cmd/gog
```

### 3. Test the OAuth Flow

```bash
./bin/gog.exe auth add your-email@example.com
```

Your users will see your company's OAuth consent screen requesting only these permissions:

- **Gmail**: Read, compose, and send emails from your Gmail account
- **Gmail**: See, edit, create, or change your email settings and filters
- **Gmail**: Manage your sensitive mail settings, including who can manage your mail
- **Calendar**: See, edit, share, and permanently delete all calendars
- **Drive**: See, edit, create, and delete all of your Google Drive files
- **Docs**: See, edit, create, and delete all your Google Docs documents

## What Users Will Experience

1. Download your CLI binary
2. Run `gog auth add their-email@gmail.com`
3. Browser opens to your company's OAuth consent screen
4. They click "Allow" to grant the permissions
5. CLI stores their refresh token securely
6. They can now use Gmail, Calendar, Drive, and Docs commands

## Verification

You can verify the scopes that will be requested:

```bash
./bin/gog.exe auth add test@example.com --dry-run
```

This will show the exact scopes without actually performing authentication.

## Important Notes

- Never commit your actual `credentials.json` to version control
- The embedded credentials are used as a fallback - users can still provide their own if needed
- Only the 4 services (Gmail, Calendar, Drive, Docs) are available by default
- Users cannot access other services (Sheets, Slides, Tasks, etc.) unless you add those scopes to your OAuth consent screen and update the code
