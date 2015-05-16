# Handle the syslinux tftp stuff

# Install the package
pxelinux-pkg:
  pkg.latest:
    - name: syslinux-tftpboot

