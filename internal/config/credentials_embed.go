package config

import (
	_ "embed"
)

//go:embed credentials.json
var embeddedCredentialsJSON []byte

// Note: If credentials.json doesn't exist (e.g., in CI), 
// embeddedCredentialsJSON will be empty and HasEmbeddedCredentials() will return false

// HasEmbeddedCredentials returns true if credentials were embedded at build time.
func HasEmbeddedCredentials() bool {
	return len(embeddedCredentialsJSON) > 0
}

// GetEmbeddedCredentials returns the embedded OAuth client credentials.
// Returns an error if no credentials were embedded or if they're invalid.
func GetEmbeddedCredentials() (ClientCredentials, error) {
	if !HasEmbeddedCredentials() {
		return ClientCredentials{}, &CredentialsMissingError{
			Path:  "embedded credentials.json",
			Cause: nil,
		}
	}

	return ParseGoogleOAuthClientJSON(embeddedCredentialsJSON)
}
