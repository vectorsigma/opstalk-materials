#!/bin/bash
#
# Quick hackish script to unmount up 20 USB thumb drives after they've been stuffed.

FSTAB_BACKUP="/etc/fstab.backup"
MOUNT_BASE="/mnt/thumbs"

# Expects to be run as root.
if [[ $(id -u) != 0 ]]; then
	echo "Must run $0 as root."
	exit 1
fi

# Dont execute if the backup file isn't present!
if [[ ! -r $FSTAB_BACKUP ]]; then
	echo "$0 has already been run."
	exit 2
fi

# Make sure we're not running a clean fstab
if [[ $(grep -q thumbs /etc/fstab) ]]; then
	echo "Mount script hasn't run yet."
	exit 2
fi

# Assuming we got this far, our prerequisite checks are done.
# Unmount all the things!
for letter in {b..u}; do
	umount /mnt/thumbs/sd${letter}
done

# restore fstab from the backup.
cp -a ${FSTAB_BACKUP} /etc/fstab
if [[ $? != 0 ]]; then
	echo "restoring fstab from backup failed! onoz!"
	exit 2
fi

# Remove old file
rm -f $FSTAB_BACKUP
exit $?
