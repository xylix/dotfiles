#!/bin/bash
get_percentage()
{
     # Note, | \ must have only new line after it, no space
     upower --show-info /org/freedesktop/UPower/devices/DisplayDevice |\
     awk '/percentage/{gsub(/\%/,""); print $2}'
}

main()
{
    while true
    do
        pcent=$(get_percentage)
        [ $pcent -le 10  ] && notify-send "Battery Low Please plug in charger"
        sleep 60 # check every minute
    done
}
main
