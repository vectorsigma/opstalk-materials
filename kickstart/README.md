# Building a thumb drive to bootstrap your datacenter from

Cribbed from [the official documentation](http://wiki.centos.org/HowTos/InstallFromUSBkey).

## Prerequisites

1. A thumb drive at least 8GB in size.
2. A copy of the CentOS 7 Everything ISO
3. Internet access (duh)

## Preparing the thumb drive

1. Plug in your thumb drive
2. Become root
3. dd the iso onto the thumb drive device directly.
4. `sync && sync` for good luck.
5. re-run partprobe to get the new partition information, or just unplug and replug the drive.
6. Create a third partition on the drive with ~100MB of space for your kickstart and other custom things.
7. Format that with EXT4: `mke2fs -m0 -t ext4 -L turdrockfromthesun /dev/sdb3`
8. Mount it: `mount /dev/sdb3 /mnt/derp`
8. Copy your kickstart configuration files onto this newly formatted partition (like our example one in this directory!)
  1. `cp ~/opstalk-resources/kickstar/*.cfg /mnt/derp`
9. Make a folder to contain your Salt RPMs and dependencies, if you will be without internet access in your new rack/data center.
  1. `mkdir -p /mnt/derp/saltrpms`
10. Copy your salt tree onto this drive
  1. `cp ~/opstalk-resources/salt-tree /mnt/derp`

## Booting up the bootstrap node for the first time

1. Plug in your thumb drive
2. Boot your system off of it (varies by manufacturer which magic key, either F1, F2, Del or F12)
3. At the GRUB screen, you'll need to edit your boot options:
  1. Add a ks=hd:0:/c7-x86_64-ks.cfg
4. Let the system install everything.
5. Reboot
6. Accept the local minion's salt key: `salt-key -A`
7. Run your first highstate.
8. Profit!
