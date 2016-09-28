#!/bin/bash
#
# Simple script to download CentOS updates to be distrubted
# to local systems via yum.
#

RSYNC="rsync -avSHP --delete --exclude \"local*\" --exclude \"SRPMS\" --exclude \"x86_64/drpms\" --exclude \"x86_64/debug\""
BASE="/srv/yum/centos"
LOCK="/var/lock/subsys/rsync_updates"
LOGBASE="/var/log/rsync"
LOGPHILE="$LOGBASE/centos-mirror-`date +%F`.log"
# FIXME: Find a better way to populate the mirror list here and use bash arrays.
BASEURL="mirrors.kernel.org::centos"
LOG="tee -a $LOGPHILE"

if [ ! -d $LOGBASE ]; then
	echo "Making: ${LOGBASE}" | $LOG
        mkdir -pv $LOGBASE | $LOG
fi

if [ -f $LOCK ]; then
    # Read in PID, check to see if it's actually working.
    OLDPID=`cat $LOCK`
    if [ -d "/proc/$OLDPID" ]; then
        echo "Updates via rsync already running." | $LOG
        exit 0
    else
        echo "Removing stale lock file." | $LOG
        rm $LOCK
    fi
fi

# set current PID inside the lock file.
echo $$ > $LOCK

for ver in "6.5" "7.0"; do
        for repo in addons centosplus contrib extras updates os; do
                for arch in x86_64; do
			NEWDIR="$BASE/${ver}/${repo}/${arch}"
                        if [ ! -d "${NEWDIR}" ]; then
				echo "Making: $NEWDIR" | $LOG
                                mkdir -vp "${NEWDIR}" | $LOG
                        fi
                        URL="$BASEURL/${ver}/${repo}/$arch"
                        echo -e "\n\n*****Updating CentOS ${ver} repository: ${repo} on $(date +%Y%m%d) *****\n" | $LOG
                        ${RSYNC} --exclude "${arch}/debug" --exclude "${arch}/drpms" "${URL}" "${NEWDIR}" | $LOG
                done
        done
done
echo "Removing lock." | $LOG
rm -f $LOCK
