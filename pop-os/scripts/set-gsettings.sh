#!/usr/bin/env bash


function check_not_root {
	if [[ $EUID -eq 0 ]]
	then
		echo "This script should not be run as root."
		exit 1
	fi
}

echo "Starting $0"

# safety checks
check_not_root

echo "Configuring gsettings"

# locate mouse with ctrl key (set false to turn off)
gsettings set org.gnome.desktop.interface locate-pointer true

# configure app center
gsettings set io.elementary.appcenter.settings automatic-updates false

# configure dash-to-dock extension
gsettings set org.gnome.shell.extensions.dash-to-dock activate-single-window true
gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen false
gsettings set org.gnome.shell.extensions.dash-to-dock bolt-support true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock default-windows-preview-to-open false
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-alignment 'CENTER'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner false
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-overlay true
gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-show-dock true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-locations true
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-monitors false
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces false
gsettings set org.gnome.shell.extensions.dash-to-dock manualhide false
gsettings set org.gnome.shell.extensions.dash-to-dock middle-click-action 'launch'
gsettings set org.gnome.shell.extensions.dash-to-dock minimize-shift true
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true
gsettings set org.gnome.shell.extensions.dash-to-dock preferred-monitor-by-connector 'primary'
gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color false
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'do-nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-switch-workspace true
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-to-focused-application true
gsettings set org.gnome.shell.extensions.dash-to-dock shift-click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock shift-middle-click-action 'launch'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites true
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true
gsettings set org.gnome.shell.extensions.dash-to-dock show-running true
gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
gsettings set org.gnome.shell.extensions.dash-to-dock workspace-agnostic-urgent-windows true

# configure pop-cosmic extension
gsettings set org.gnome.shell.extensions.pop-cosmic clock-alignment 'CENTER'
gsettings set org.gnome.shell.extensions.pop-cosmic overlay-key-action 'LAUNCHER'
gsettings set org.gnome.shell.extensions.pop-cosmic show-application-menu true
gsettings set org.gnome.shell.extensions.pop-cosmic show-applications-button true
gsettings set org.gnome.shell.extensions.pop-cosmic show-workspaces-button true
gsettings set org.gnome.shell.extensions.pop-cosmic workspace-picker-left true

# configure windows
gsettings set org.gnome.mutter auto-maximize true
gsettings set org.gnome.mutter center-new-windows false
gsettings set org.gnome.mutter draggable-border-width 20
gsettings set org.gnome.mutter workspaces-only-on-primary false

# configure keyboard shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super>Escape', '<Super>l']"  # lock pc
gsettings set org.gnome.settings-daemon.plugins.media-keys logout "['<Control><Alt>Delete']"  # logout
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>t']"  # launch terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"  # launch web browser
gsettings set org.gnome.shell.keybindings screenshot "['<Shift>Print']"
gsettings set org.gnome.shell.keybindings screenshot-window "['<Alt>Print']"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['Print']"

# configure mouse & touchpad
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true

# configure overrides
gsettings set org.gnome.shell.overrides attach-modal-dialogs false
gsettings set org.gnome.shell.overrides dynamic-workspaces true
gsettings set org.gnome.shell.overrides edge-tiling true
gsettings set org.gnome.shell.overrides focus-change-on-pointer-rest true
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

# configure fonts
if [ -f "/home/${USER}/.fonts/Atkinson-Hyperlegible-Regular-102.otf" ]
then
	# regular font type and sizes
	gsettings set org.gnome.desktop.interface font-name 'Atkinson Hyperlegible 12'
	gsettings set org.gnome.desktop.interface document-font-name 'Atkinson Hyperlegible 11'

	# legacy font type and font size
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Atkinson Hyperlegible 12'

	# additional font settings
	gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
	gsettings set org.gnome.desktop.interface font-hinting 'full'
	gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
fi

if [ ! -f "/home/${USER}/.fonts/Atkinson-Hyperlegible-Regular-102.otf" ]
then
	echo "WARNING: /home/${USER}/.fonts/Atkinson-Hyperlegible-Regular-102.otf not found"
fi

if [ -f "/home/${USER}/.fonts/intelone-mono-font-family-regular.otf" ]
then
	# monospace font type and sizes
	gsettings set org.gnome.desktop.interface monospace-font-name 'IntelOne Mono 11'
fi

if [ ! -f "/home/${USER}/.fonts/intelone-mono-font-family-regular.otf" ]
then
	echo "WARNING: /home/${USER}/.fonts/intelone-mono-font-family-regular.otf not found"
fi

echo "$0 has finished"
