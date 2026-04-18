package config

import (
	"testing"
)

func TestEmbeddedCredentials(t *testing.T) {
	// Test that embedded credentials can be parsed
	if !HasEmbeddedCredentials() {
		t.Skip("no embedded credentials in test build")
	}

	creds, err := GetEmbeddedCredentials()
	if err != nil {
		t.Fatalf("GetEmbeddedCredentials() error = %v", err)
	}

	if creds.ClientID == "" {
		t.Error("embedded credentials missing client_id")
	}

	if creds.ClientSecret == "" {
		t.Error("embedded credentials missing client_secret")
	}
}

func TestReadClientCredentialsWithEmbedded(t *testing.T) {
	if !HasEmbeddedCredentials() {
		t.Skip("no embedded credentials in test build")
	}

	// This should fall back to embedded credentials when file doesn't exist
	creds, err := ReadClientCredentials()
	if err != nil {
		t.Fatalf("ReadClientCredentials() error = %v", err)
	}

	if creds.ClientID == "" {
		t.Error("credentials missing client_id")
	}
}
