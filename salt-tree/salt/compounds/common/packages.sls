# Packages all systems should have.  Mostly just small utilites
# and the like.
common-pkgs-latest:
  pkg.latest:
    - pkgs:
      - dstat
      - gpm
      - hdparm
      - htop
      - iftop
      - iotop
      - lrzsz
      - ltrace
      - lynx
      - minicom
      - nfs-utils
      - nmap
      - rpcbind
      - screen
      - setserial
      - smartmontools
      - strace
      - sysstat
      - testdisk
      - tftp
      - tree
      - vim-enhanced
      - w3m

common-pkgs-installed:
  pkg.installed:
    - pkgs:
      - salt-minion
