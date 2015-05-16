# Set up a kickstart environment.
# In our case, we need the kickstart files and then the ISO images.
#
# The yum repositories themselves will be handled in a different compound.
include:
  - elements.httpd

# configure the web server
kickstart-httpd-conf:
  file.managed:
    - name: /etc/httpd/conf.d/kickstartserver.conf
    - source: salt://compounds/kickstart-server/files/etc/httpd/conf.d/kickstartserver.conf
    - user: root
    - group: root
    - mode: '0644'

# Drop the actual kickstart config files
{%- for distro in ['co7'] %}
  {%- for arch in ['x86_64'] %}
    {%- block kickstart_scripts scoped %}
kickstart-file-{{ distro }}-{{ arch }}:
  file.managed:
    - name: /var/www/html/ks/{{ distro }}-{{ arch }}-ks.cfg
    - source: salt://compounds/kickstart-server/files/var/www/html/ks/{{ distro }}-{{ arch }}-ks.cfg.template
    - template: jinja
    - file_mode: '0644'
    - dir_mode: '0755'
    - makedirs: True
    - user: root
    - group: root
    {%- endblock %}
  {%- endfor %}
{%- endfor %}


# Make sure the directory for the ISO's exists.
centos-7-iso-location:
  file.directory:
    - name: /srv/share/iso/centos7
    - makedirs: True
    - user: root
    - group: root
    - file_mode: '0644'
    - dir_mode: '0755'
{%- endfor %}

# Manage the ISO images!
centos-7-x86_64-iso:
  cmd.run:
    - name: wget -O /srv/share/iso/centos7/CentOS-7-x86_64-Everything-1503-01.iso http://mirrors.kernel.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1503-01.iso
    - unless: /bin/bash -c "chown root:root /srv/share/iso/centos7/CentOS-7-x86_64-Everything-1503-01.iso && chmod 644 /srv/share/iso/centos7/CentOS-7-x86_64-Everything-1503-01.iso"

share-perms:
  cmd.run:
    - names:
      - find /srv/share -type d -exec chmod 755 '{}' \;
      - find /srv/share -type f -exec chmod 644 '{}' \;
      - chown root:root /srv/share

# Mount CentOS ISO's
centos-mount-7:
  mount.mounted:
    - name: /var/www/html/os/centos/7/x86_64
    - device: /srv/share/iso/centos7/CentOS-7-x86_64-Everything-1503-01.iso
    - fstype: iso9660
    - mkmnt: True
    - persist: True
    - opts:
      - loop
      - uid=48
      - gid=48
      - mode=0775
      - ro

# Fix the SELinux contexts
kickstart-fix-context:
  cmd.run:
    - names:
      - restorecon -R /var/www/html/ks
      - restorecon -R /var/www/html/repos.d
