#!/bin/bash
#
# Quick hackish script to mount up 20 USB thumb drives for great lulz.

FSTAB_BACKUP="/etc/fstab.backup"
MOUNT_BASE="/mnt/thumbs"

# Expects to be run as root.
if [[ $(id -u) != 0 ]]; then
	echo "Must run $0 as root."
	exit 1
fi

# Dont execute if the backup file is still there..  
# clean up script should've taken care of that.
if [[ -r $FSTAB_BACKUP ]]; then
	echo "Script has already been run."
	exit 2
fi

# Make sure we're not running a dirty fstab
if [[ $(grep -q thumbs /etc/fstab) ]]; then
	echo "Cleanup script hasn't run yet."
	exit 2
fi

# Assuming we got this far, our prerequisite checks are done.
# time to modify fstab, but first make the backup.
cp -a /etc/fstab ${FSTAB_BACKUP}
echo "# Thumb drive mount points" >> /etc/fstab
for letter in {b..u}; do
	# Create the mountpoint on disk
	MP="${MOUNT_BASE}/sd${letter}"
	if [[ ! -d $MP ]]; then
		mkdir -p ${MOUNT_BASE}/sd${letter}
	fi
	
	# Create the fstab entry
	echo -e "/dev/sd${letter}1\t\t${MP}\t\tntfs\t\tdefaults,uid=1000,gid=1000\t0 0" >> /etc/fstab
done

# Mount all the things!
mount -a
exit $?
