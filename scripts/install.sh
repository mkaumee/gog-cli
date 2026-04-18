#!/bin/bash
set -e

REPO="steipete/gogcli"
VERSION="${GOG_VERSION:-latest}"

OS="$(uname -s)"
ARCH="$(uname -m)"

# Determine the download URL based on OS and architecture
if [ "$OS" = "Darwin" ]; then
  if [ "$ARCH" = "arm64" ]; then
    BINARY="gogcli_${VERSION}_darwin_arm64.tar.gz"
  else
    BINARY="gogcli_${VERSION}_darwin_amd64.tar.gz"
  fi
elif [ "$OS" = "Linux" ]; then
  if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    BINARY="gogcli_${VERSION}_linux_arm64.tar.gz"
  else
    BINARY="gogcli_${VERSION}_linux_amd64.tar.gz"
  fi
else
  echo "❌ Unsupported OS: $OS"
  exit 1
fi

# Construct download URL
if [ "$VERSION" = "latest" ]; then
  URL="https://github.com/$REPO/releases/latest/download/$BINARY"
else
  URL="https://github.com/$REPO/releases/download/v$VERSION/$BINARY"
fi

echo "📦 Downloading gog CLI..."
echo "   OS: $OS"
echo "   Arch: $ARCH"
echo "   Version: $VERSION"

# Create temp directory
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

# Download and extract
cd "$TMP_DIR"
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o gog.tar.gz
elif command -v wget >/dev/null 2>&1; then
  wget -q "$URL" -O gog.tar.gz
else
  echo "❌ Neither curl nor wget found. Please install one of them."
  exit 1
fi

tar -xzf gog.tar.gz

# Install to /usr/local/bin (requires sudo) or ~/bin
INSTALL_DIR="/usr/local/bin"
if [ -w "$INSTALL_DIR" ]; then
  mv gog "$INSTALL_DIR/gog"
  echo "✅ gog installed to $INSTALL_DIR/gog"
else
  echo "🔐 Installing to $INSTALL_DIR requires sudo..."
  sudo mv gog "$INSTALL_DIR/gog"
  echo "✅ gog installed to $INSTALL_DIR/gog"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "Get started:"
echo "  gog auth add your-email@gmail.com"
echo ""
echo "For help:"
echo "  gog --help"
