# SELinux control file.  This should only need to run once, so it's not part
# of the init.sls file or highstate.  At least not yet.  Also, it may only
# be necessary if you're using unionfs to merge ISOs, I can't really remember
# why I had to build this stuff.  Consider it reference material only.

#
# FILES
#

apache-fuse-policy:
  file.managed:
    - source: salt://compounds/yum-server/files/usr/local/share/selinux/apachefuseallow.pp
    - name: /usr/local/share/selinux/apachefuseallow.pp
    - mode: '0600'
    - user: root
    - group: root
    - makedirs: True

# This file makes the above file via this commands:
# checkmodule -M -m -o apachefuseallow.mod apachefuseallow.te
# semodule_package -o apachefuseallow.pp -m apachefuseallow.mod
#
# It is included just in case the binary file ever needs to be
# recompiled.
apache-fuse-policy-origin:
  file.managed:
    - source: salt://compounds/yum-server/files/usr/local/share/selinux/apachefuseallow.te
    - name: /usr/local/share/selinux/apachefuseallow.te
    - mode: '0600'
    - user: root
    - group: root
    - makedirs: True

#
# COMMANDS
#

install-fuse-policy:
  cmd.run:
    - name: semodule -i /usr/local/share/selinux/apachefuseallow.pp
