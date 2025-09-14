
status=$(playerctl status xesam 2>/dev/null)

if [[ "$status" == "Playing" ]]; then
    artist=$(playerctl metadata xesam:artist)
    if [ -z "$artist" ]; then
    	echo ""
    fi
    title=$(playerctl metadata xesam:title)
    echo "$artist - $title"
else
    echo ""
fi

