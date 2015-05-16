# Install the Apache httpd package.
httpd-pkg:
  pkg.latest:
    # Note: this is names not pkgs because pkgs will break the Salt requisite
    # system.  You can't require an individual package that's installed via
    # pkgs.
    - names:
      - httpd
      - httpd-tools
      - mod_ssl

httpd-conf:
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://elements/httpd/files/etc/httpd/conf/httpd.conf
    - mode: '0644'
    - user: root
    - group: root

robots.txt:
  file.managed:
    - name: /var/www/html/robots.txt
    - source: salt://elements/httpd/files/var/www/html/robots.txt
    - mode: '0644'
    - user: root
    - group: root
