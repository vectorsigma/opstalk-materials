disable-common-services:
  service.dead:
    - names:
      - exim
      - avahi-daemon
    - enable: False
