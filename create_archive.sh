#!/usr/bin/env sh
D=$(realpath $(dirname $0))
WD=$(pwd)

echo "Creating MassMoveMinionMagic.love in current directory"
cd $D
zip -r $WD/MassMoveMinionMagic.love main.lua conf.lua assets/ game/
