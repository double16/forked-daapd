#!/bin/sh

/wait-for-it.sh daapd:3689

source /sh2ju.sh
juLogClean

juLog -name="opentcp" nc -zv -w 10 daapd 3689

