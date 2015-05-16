# Atom for DHCP server
dhcp-server-pkg:
  pkg.latest:
    - name: dhcp

dhcp-server-config:
  file.managed:
    - name: /etc/dhcp/dhcpd.conf
    - source: salt://elements/dhcpd/files/etc/dhcp/dhcpd.conf.template
    - mode: 640
    - user: root
    - group: root
    - template: jinja

dhcp-service:
  service.running:
    - name: dhcpd
    - enable: True
    - watch:
      - file: /etc/dhcp/dhcpd.conf
