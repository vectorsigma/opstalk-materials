# Compose all of the necessary elements to build the complete tftp server.
include:
{%- if salt['grains.get']('osfinger') in ['Fedora-20','Centos-7'] %}
  - elements.xinetd
{%- endif %}
  - elements.tftpd
  - elements.memtest
  - elements.syslinux

# Create a few directories to hold some things: initrd, vmlinuz, etc.
tftp-service-kernels:
  file.directory:
    - names:
      - /tftpboot/co7/x86_64
      - /tftpboot/pxelinux.cfg
    - dir_mode: 755
    - user: root
    - group: root
    - makedirs: True

## NOTE: These images are pulled from the following location:
## http://mirrors.kernel.org/fedora/releases/21/Server/i386/os/images/pxeboot/
## Also note that the 32 bit images are *non* PAE.

# Drop the vmlinuz and initrd files
{%- for distro in ['co7'] %}
  {%- for arch in ['x86_64''] %}
    {%- for file in ['vmlinuz','initrd.img','upgrade.img'] %}
    {%- block tftp_file scoped %}
tftp-service-{{ distro }}-{{ arch }}-{{ file }}:
  file.managed:
    - name: /tftpboot/{{ distro }}/{{ arch }}/{{ file }}
    - source: salt://compounds/tftp-server/files/tftpboot/{{ distro }}/{{ arch }}/{{ file }}
    - user: root
    - group: root
    - makedirs: True
    - file_mode: '0644'
    - dir_mode: '0755'
    {%- endblock %}
    {%- endfor %}
  {%- endfor %}
{%- endfor %}

# Copy the memtest binary into /tftpboot, a symlink won't work.
tftp-service-memtest:
  cmd.run:
    - cwd: /
    - name: cp -a /boot/memtest86+-5.01 /tftpboot/memtest
    - creates: /tftpboot/memtest

tftp-service-memtest-perms:
  cmd.run:
    - names:
      - chmod 644 /tftpboot/memtest
      - restorecon /tftpboot/memtest

# PXELinux config file
tftp-service-pxelinux:
  file.managed:
    - name: /tftpboot/pxelinux.cfg/default
    - source: salt://compounds/tftp-server/files/tftpboot/pxelinux.cfg/default.template
    - template: jinja
    - user: root
    - group: root
    - mode: '0644'


# Set SELinux contexts
tftp-context:
  cmd.run:
    - name: chcon -R system_u:object_r:tftpdir_rw_t:s0 /tftpboot

#
# Enable the xinetd service
#

# Fedora 20 and CentOS 7 serve tftp via xinetd.  Fedora 21 does not, and instead uses systemd directly. >.>
{% if salt['grains.get']('osfinger') in ['Fedora-20','Centos-7'] %}
tftp-xinetd-enable:
  file.replace:
    - name: /etc/xinetd.d/tftp
    - pattern: '(\s+)disable\s+= yes'
    - repl: '\1disable                 = no'
    - count: 1

# Tell it to look in the right spot. :(
tftp-xinetd-moveroot:
  file.replace:
    - name: /etc/xinetd.d/tftp
    - pattern: '\/var\/lib\/tftpboot'
    - repl: '/tftpboot'
    - count: 1

# Turn on xinetd
xinetd-service:
  service.running:
    - name: xinetd
    - enable: True
    - require:
      - pkg: xinetd
{% else %}
tftp-moveroot:
  file.replace:
    - name: /usr/lib/systemd/system/tftp.service
    - pattern: '\/var\/lib\/tftpboot'
    - repl: '/tftpboot'
    - count: 1
    - onchanges: 
      - cmd: tftp-fix-systemd

tftp-fix-systemd:
  cmd.run:
    - name: systemctl daemon-reload

tftp-enable-systemd:
  service.running:
    - name: tftp
    - enable: True

{% endif %}
