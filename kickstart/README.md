# Building a thumb drive to bootstrap your datacenter from

Cribbed from [the official documentation](http://wiki.centos.org/HowTos/InstallFromUSBkey).

## Prerequisites

1. A thumb drive at least 8GB in size.
2. A copy of the CentOS 7 Everything ISO

## Procedure

1. Plug in your thumb drive
2. Become root
3. dd the iso onto the thumb drive device directly.
4. `sync && sync` for good luck.
5. re-run partprobe to get the new partition information, or just unplug and replug the drive.
6. Create a third partition on the drive with ~100MB of space for your kickstart and other custom things.
7. Format that with EXT4: `mke2fs -m0 -t ext4 -L turdrockfromthesun /dev/sdb3`
8. Copy your kickstart configuration files onto this newly formatted partition!
9. Also copy the [EPEL RPM repository](https://fedoraproject.org/wiki/EPEL) files, you'll need them after installation.

## Booting up the bootstrap node for the first time
