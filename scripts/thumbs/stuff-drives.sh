#!/bin/bash
#
# Rsync all the things!!

PHILES="$HOME/opstalk-materials"
MNT_BASE="/mnt/thumbs"

if [[ $(id -u) != 1000 ]]; then
	echo "Must NOT run as root, must run as uid 1000."
	exit 1
fi

EXCLUDE="--exclude .git"

# Test to see if the ISO image has already been copied over at least once...
if [[ -f "$MNT_BASE/sdb/iso/CentOS-7-x86_64-Everything-1503-01.iso" ]]; then
	EXCLUDE="$EXCLUDE --exclude **.iso"
fi

cd $PHILES
cat /proc/partitions | grep -v sda | egrep sd.$ | awk '{print $4}' | sort | xargs -Iblah -n1 -P 20 rsync -a $EXCLUDE ./ /mnt/thumbs/blah/
cd -
