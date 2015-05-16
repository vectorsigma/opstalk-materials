# all the machinations required to build an httpd based yum server

include:
  - elements.selinux
  - elements.httpd

# Main service config
yumserver-httpd-config:
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://compounds/yum-server/files/etc/httpd/conf/httpd.conf
    - user: root
    - group: root
    - mode: '0644'

# yum service config file
yumserver-config:
  file.managed:
    - name: /etc/httpd/conf.d/yumserver.conf
    - source: salt://compounds/yum-server/files/etc/httpd/conf.d/yumserver.conf
    - user: root
    - group: root
    - mode: '0644'

# Mirroring scripts for CentOS
yumserver-centos-mirror-script:
  file.managed:
    - name: /usr/local/bin/centos-mirror.sh
    - source: salt://compounds/yum-server/files/usr/local/bin/centos-mirror.sh
    - user: root
    - group: root
    - mode: '0700'

# Cron jobs for said mirror
yumserver-centos-mirror-cron:
  cron.absent:
    - name:  /usr/local/bin/centos-mirror.sh >> /var/log/rsync/centos-mirror-`/usr/bin/date --rfc-3339='date'`.log
    - user: root
    #- hour: 3
    #- minute: 0
    #- identifier: CENTOSMIRROR

# Bind mounts to put /srv/yum into /var/www/html/yum
yum-webroot:
  mount.mounted:
    - name: /var/www/html/yum
    - device: /srv/yum
    - persist: true
    - mkmnt: true
    - fstype: bind
    - opts: bind,rw,auto

# Tune SELinux booleans
yum-selinux-booleans:
  selinux.boolean:
    - name: httpd_read_user_content
    - value: True
    - persist: True
