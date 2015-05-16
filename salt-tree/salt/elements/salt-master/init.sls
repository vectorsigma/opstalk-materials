salt-master-pkg:
  pkg.installed:
    - name: salt-master


salt-master-svc:
  service.running:
    - name: salt-master
    - enable: True
