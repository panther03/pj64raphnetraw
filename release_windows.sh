#!/bin/bash

PROJECT=pj64raphnetraw

if [ $# -ne 2 ]; then
	echo "Syntax: ./release.sh version releasedir"
	echo
	exit
fi

VERSION=$1
RELEASEDIR=$2
DIRNAME=$PROJECT-$VERSION
FILENAME=$PROJECT-$VERSION.zip

if [ -d $RELEASEDIR/$DIRNAME ]; then
	echo "$RELEASEDIR/$DIRNAME already exists";
	exit 1
fi

mkdir -p $RELEASEDIR/$DIRNAME
if [ $? -ne 0 ]; then
	echo "Could not mkdir"
	exit 1
fi

cd src
if [ $? -ne 0 ]; then
	echo "Could not chdir"
	exit 1
fi

make clean
make all
if [ $? -ne 0 ]; then
	echo "Build failed"
	exit 1
fi

cd .. # exit src

cp src/pj64raphnetraw.dll -v $RELEASEDIR/$DIRNAME
cp ../hidapi/windows/.libs/*.dll -v $RELEASEDIR/$DIRNAME
cp README.md -rv $RELEASEDIR/$DIRNAME

cd $RELEASEDIR

zip -r $FILENAME $DIRNAME
echo
echo
echo
echo -------------------------------------
ls -lh $FILENAME
echo Done
