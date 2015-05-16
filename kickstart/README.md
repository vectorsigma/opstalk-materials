# Building a thumb drive to bootstrap your datacenter from

Cribbed from [the official documentation](http://wiki.centos.org/HowTos/InstallFromUSBkey).

## Prerequisites

1. A thumb drive at least 8GB in size.
2. A copy of the CentOS 7 Everything ISO
3. Internet access (duh)

## Preparing the installation thumb drive

1. Plug in your thumb drive
2. Become root
3. dd the iso onto the thumb drive device directly.
4. `sync && sync` for good luck.

## Preparing the second thumb drive

*note:* when CentOS is installing, it mounts the entire thumb drive's device entry, not just the first partition.  Trying to create any additional partitions on that drive will result in failure. 

6. Create a new on the new drive with ~100MB of space for your kickstart and salt tree.
7. Format that with EXT4: `mke2fs -m0 -t ext4 -L turdrockfromthesun /dev/sdb3`
8. Mount it: `mount /dev/sdb3 /mnt/derp`
8. Copy your kickstart configuration files onto this newly formatted partition (like our example one in this directory!)
  1. `cp ~/opstalk-resources/kickstar/*.cfg /mnt/derp`
9. Make a folder to contain your Salt RPMs and dependencies, if you will be without internet access in your new rack/data center.
  1. `mkdir -p /mnt/derp/saltrpms`
10. Copy your salt tree onto this drive
  1. `cp ~/opstalk-resources/salt-tree /mnt/derp`

## Booting up the bootstrap node for the first time

1. Plug in your thumb drives
2. Boot your system off of the first one (varies by manufacturer which magic key, either F1, F2, Del or F12)
3. At the GRUB screen, you'll need to edit your boot options:
  1. Add a `ks=hd:sdb3:/c7-x86_64-ks.cfg`
  2. Which device you use here depends entirely on the way your system detects them during boot.
  3. You may want to boot up without any options just once, and then: `ls -l /dev/disk/by-label` to see what's where.
4. Let the system install everything.
5. Reboot
6. Accept the local minion's salt key: `salt-key -A`
7. Run your first highstate.
8. Profit!
