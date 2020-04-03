#!/bin/sh

DIRNAME="$HOME/Documents/notes"

if [ ! -d "$DIRNAME" ]; then
    mkdir -p $DIRNAME
fi


NOTE="$DIRNAME/$1"

if [ -z $2  ]; then
    $EDITOR $NOTE
else
    shift
    echo $* >> $NOTE
fi
