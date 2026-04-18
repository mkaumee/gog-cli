package googleauth

import (
	"os/exec"
	"runtime"
)

var startCommand = func(name string, args ...string) error {
	return exec.Command(name, args...).Start() //nolint:gosec // command/args come from fixed OS mapping and caller URL
}

func openBrowser(u string) error {
	name, args := openBrowserCommand(u, runtime.GOOS)
	return startCommand(name, args...)
}

func openBrowserCommand(u string, goos string) (name string, args []string) {
	switch goos {
	case "darwin":
		return "open", []string{u}
	case "windows":
		// Use cmd.exe with start command - more reliable than rundll32
		return "cmd", []string{"/c", "start", "", u}
	default:
		return "xdg-open", []string{u}
	}
}
