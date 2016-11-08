#!/bin/bash


function doc {
echo "
Usage : volumio <argument1> <argument2>

[[PLAYBACK STATUS]]

status                             Gives Playback status information
volume                             Gives Current Volume Information
volume <desired volume>            Sets Volume at desired level 0-100


[[PLAYBACK CONTROL]]

play
pause
next
previous
stop


[[VOLUMIO SERVICE CONTROL]]

start                               Starts Volumio Service
vstop                                Stops Volumio Service
restart                             Restarts Volumio Service
"

}

volumeval="0"
playbackcommand="play"


#PLAYBACK STATUS CONTROLS

function status {
var=$ /volumio/app/plugins/system_controller/volumio_command_line_client/commands/status.js
echo $var
}

function volumeget {
var=$ /volumio/app/plugins/system_controller/volumio_command_line_client/commands/getvolume.js
echo $var
}

function volumeset {
echo "Setting Volume "$volumeval""
var=$ /volumio/app/plugins/system_controller/volumio_command_line_client/commands/setvolume.js "$volumeval"
echo $var
}

#PLAYBACK CONTROLS

function playback {
echo "Sending "$playbackcommand" "
var=$ /volumio/app/plugins/system_controller/volumio_command_line_client/commands/playback.js "$playbackcommand"
echo $var
}


#VOLUMIO SERVICE CONTROLS

function start {
systemctl start volumio.service
}

function vstop {
systemctl stop volumio.service
}




case "$1" in
        play)
            playbackcommand=$1
            playback
            ;;
        pause)
            playbackcommand=$1
            playback
            ;;
        next)
            playbackcommand=$1
            playback
            ;;
        previous)
            playbackcommand=$1
            playback
            ;;
        stop)
            playbackcommand=$1
            playback
            ;;
        start)
            start
            ;;
        start)
            start
            ;;

        vstop)
            stop
            ;;

        restart)
            stop
            start
            ;;

        status)
            status
            ;;
        volume)
            if [ "$2" != "" ]; then
                volumeval=$2
                volumeset
            else
                volumeget
            fi
            ;;

        *)
            doc
            exit 1

esac




