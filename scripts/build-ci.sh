#!/bin/bash
# CI build script that creates a placeholder credentials.json if it doesn't exist

set -e

CREDS_FILE="internal/config/credentials.json"

# If credentials.json doesn't exist, create placeholder from example
if [ ! -f "$CREDS_FILE" ]; then
    echo "Creating placeholder credentials.json for CI build..."
    cp internal/config/credentials.json.example "$CREDS_FILE"
fi

# Run the build/test
"$@"

# Clean up placeholder if we created it
if [ -f "$CREDS_FILE" ] && grep -q "YOUR_CLIENT_ID" "$CREDS_FILE"; then
    echo "Removing placeholder credentials.json..."
    rm "$CREDS_FILE"
fi
