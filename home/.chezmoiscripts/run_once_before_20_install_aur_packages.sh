#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)")
. "$DIR/.chezmoiscripts/base.sh"
. "$DIR/.chezmoiscripts/ansi"


if [[ "$OSTYPE" != "linux-gnu"* ]]; then
	ansi --yellow "Not a Linux platform. Skipping."
	exit 0
fi

if [ ! -f "/etc/arch-release" ]; then
	ansi --yellow "Not running arch. Skipping."
fi

{{- $packages := splitList " " (includeTemplate "archlinux/packages" .) }}

sudo pacman -Sy --noconfirm --needed {{ $packages | sortAlpha | uniq | join " " -}}

# AUR_BUNDLE_FILE="$DIR/Aurfile"
# ansi --green "Using $AUR_BUNDLE_FILE bundle file"
# yay -S --noconfirm --nouseask --needed - <"$AUR_BUNDLE_FILE"