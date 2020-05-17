#!/bin/zsh -euo pipefail

cd "`dirname $0`/.."


setopt BASH_REMATCH
MAJOR=`cat FiraCode.glyphs | grep versionMajor`
VERSION=""

if [[ $MAJOR =~ 'versionMajor = ([0-9]+);' ]] ; then
    VERSION="${BASH_REMATCH[2]}"
fi

MINOR=`cat FiraCode.glyphs | grep versionMinor`
if [[ $MINOR =~ 'versionMinor = ([0-9]+);' ]] ; then
    MATCH="${BASH_REMATCH[2]}"
    if [ "$MATCH" != "0" ] ; then
        VERSION="$VERSION.$MATCH"
    fi
fi

FILE="Fira_Code_v$VERSION.zip"
rm -f $FILE

pushd distr
find . -not -name ".*" | xargs zip ../$FILE
popd

ls -lah $FILE