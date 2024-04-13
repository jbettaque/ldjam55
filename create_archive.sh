#!/usr/bin/env sh
D=$(realpath $(dirname $0))
WD=$(pwd)

echo "Creating game.love in current directory"
cd $D
zip -r $WD/game.love main.lua conf.lua assets/ game/
