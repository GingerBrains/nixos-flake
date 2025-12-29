#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/powermenu/"
theme='style'

# CMDs
uptime="`uptime | awk '{print $3,$4}' | sed 's/,//g'`"

# Options with Nerd Font icons
shutdown='⏻ Shutdown'
reboot='󰜉 Reboot'
sleep='󰤄 Sleep'
logout='󰍃 Logout'
yes='󰄬 Yes'
no='󰅖 No'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p " $USER" \
		-mesg " Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -markup-rows -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/confirmation.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "<span foreground='#a6e3a1'>$yes</span>\n<span foreground='#f38ba8'>$no</span>" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$shutdown\n$reboot\n$sleep\n$logout" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	echo "$selected"
	if [[ "$selected" =~ "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--sleep' ]]; then
			# Pause any playing media and mute audio
			playerctl pause 2>/dev/null
			wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 2>/dev/null
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			hyprctl dispatch exit
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $sleep)
		run_cmd --sleep
        ;;
    $logout)
		run_cmd --logout
        ;;
esac