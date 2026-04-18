# OAuth Scopes Configuration

This CLI has been configured with a limited set of OAuth scopes approved in the Google Cloud Console OAuth consent screen.

## Enabled Services

The following services are available by default when users authenticate:

1. **Gmail** - Email management
   - `https://www.googleapis.com/auth/gmail.modify` - Read, compose, and send emails
   - `https://www.googleapis.com/auth/gmail.settings.basic` - Manage basic mail settings
   - `https://www.googleapis.com/auth/gmail.settings.sharing` - Manage sensitive mail settings

2. **Calendar** - Calendar management
   - `https://www.googleapis.com/auth/calendar` - Full calendar access

3. **Drive** - File storage and management
   - `https://www.googleapis.com/auth/drive` - Full Drive access

4. **Docs** - Document management
   - `https://www.googleapis.com/auth/drive` - Drive access for docs
   - `https://www.googleapis.com/auth/documents` - Docs-specific access

## Disabled Services

The following services are NOT available because their scopes were not approved in the OAuth consent screen:

- Chat
- Classroom
- Slides
- Contacts
- Tasks
- People
- Sheets
- Forms
- AppScript
- Groups
- Keep
- Admin

## Modifying Available Services

If you need to enable additional services:

1. Go to Google Cloud Console > APIs & Services > OAuth consent screen
2. Add the required scopes for the service you want to enable
3. Update `UserServices()` function in `internal/googleauth/service.go` to include the new service
4. Rebuild the binary

## User Experience

When users run `gog auth add`, they will only be prompted to authorize the enabled services listed above. This keeps the OAuth consent screen focused and reduces the number of permissions requested.
