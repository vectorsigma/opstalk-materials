# Services we want running out of the box..
enable-common-services:
  service.running:
    - names:
      - gpm
      - smartd
    - enable: True
