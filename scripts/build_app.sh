#!/usr/bin/env bash
set -euo pipefail

platform=${1:-}

if [[ -z "$platform" ]]; then
  echo "Usage: $0 {macos|windows|ios|android|linux}"
  exit 1
fi

case "$platform" in
  macos)
    flutter build macos
    ;;
  windows)
    flutter build windows
    ;;
  ios)
    flutter build ios --release
    ;;
  android)
    flutter build apk --release
    ;;
  linux)
    flutter build linux
    ;;
  *)
    echo "Unknown platform: $platform"
    exit 1
    ;;
 esac
