#!/usr/bin/env bash
set -euo pipefail

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
. "$DIR/assets/base"
. "$DIR/assets/ansi"

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
	ansi --yellow "Platform is not linux-gnu"
fi

if [ ! -f "/etc/arch-release" ]; then
	ansi --yellow "Not running arch. Skipping."
fi

# ask sudo upfront
sudo -v

ansi --green "Updating pacman.conf.."
sudo sed -i '/Color$/s/^#//g' /etc/pacman.conf
sudo sed -i '/TotalDownload$/s/^#//g' /etc/pacman.conf
sudo sed -i '/CheckSpace$/s/^#//g' /etc/pacman.conf
sudo sed -i '/VerbosePkgLists$/s/^#//g' /etc/pacman.conf
sudo sed -i '/^#\[multilib\]/{N;s/#//g}' /etc/pacman.conf

ansi --green "Enable timedatectl and set up timezone"
sudo timedatectl set-timezone Europe/Amsterdam
sudo timedatectl set-ntp 1
sudo timedatectl set-local-rtc 0
sudo ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

ansi --green "Setup locale"
sudo sed -i '/en_US.UTF-8$/s/^#//g' /etc/pacman.conf
sudo locale-gen


ansi --green "Refreshing Arch Keyring..."
sudo pacman -S --noconfirm archlinux-keyring

# System beep off
ansi --green "Turning systembeep off"
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
