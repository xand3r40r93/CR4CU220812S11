#!/bin/sh

app=`which h264e-nl-server`
if [ "$app" = "" ]; then
        echo "h264e-nl-server not installed, exit"
        exit
fi

while [ true ]
do
        $app
done

