# Fix SElinux perms
yumserver-selinux-contexts:
  cmd.run:
    - name: restorecon -R /var/www/html
