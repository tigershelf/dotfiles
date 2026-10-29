### UPTIME
uptime_d=$(uptime | awk -F'( |,|:)+' '{if ($7~/^day/) print $6+0; else print 0}')
uptime_h=$(uptime | awk -F'( |,|:)+' '{if ($7~/^day/) print $8+0; else if ($7=="min") print 0; else print $6+0}')
uptime_m=$(uptime | awk -F'( |,|:)+' '{if ($7~/^day/) print $9+0; else if ($7=="min") print $6+0; else print $7+0}')

### BATTERY
battery_charge=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

### AUDIO
audio_volume=$(amixer sget Master | awk -F"[][]" '/Left:/ { print $2 }')
audio_status=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-mute)

### ICONS
# Note: Use a Nerd Font, I use JetBrainsMono Nerd Font.
if [[ $battery_status = "Discharging" ]]
then
    battery_icon='󰁹'
elif [[ $battery_status = "Charging" ]]
then
    battery_icon='󰂄'
elif [[ $battery_status = "Not charging" ]]
then
    battery_icon='󰂃'
fi

if [ $audio_status = "true" ]
then
    audio_icon=''
else
    audio_icon=''
fi

echo "[󰭖  ${uptime_d}d ${uptime_h}h ${uptime_m}m] [$audio_icon  $audio_volume] [$battery_icon $battery_charge%, $battery_status] [  $(date "+%a, %b/%e/%Y, %T")]"