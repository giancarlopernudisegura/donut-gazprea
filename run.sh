#!/bin/sh

LL_FILE=$(mktemp).ll

$GAZC main.gaz $LL_FILE
lli --dlopen=$GAZLIB $LL_FILE
rm $LL_FILE
