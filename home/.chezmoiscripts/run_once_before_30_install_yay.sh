#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)")
. "$DIR/assets/base.sh"
. "$DIR/assets/ansi"


if [[ "$OSTYPE" != "linux-gnu"* ]]; then
	ansi --yellow "Not a Linux platform. Skipping."
	exit 0
fi

if [ ! -f "/etc/arch-release" ]; then
	ansi --yellow "Not running arch. Skipping."
fi

if ! isAvailable yay; then
	ansi --yellow "Yay not available. Installing."
	YAY_PATH=/tmp/yay

	git clone https://aur.archlinux.org/yay.git $YAY_PATH
	(cd $YAY_PATH && makepkg -si --noconfirm --needed && rm -rf $YAY_PATH)
fi