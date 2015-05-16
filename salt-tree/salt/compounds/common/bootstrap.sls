#
# Bootstrap the minimum necessary configs for Salt.
# You could also put states here to enable, say, a repository definition for
# for a local mirror, etc.

# Control the salt minion configs
salt-minon-conf:
  file.managed:
    - name: /etc/salt/minion.d/example.conf
    - source: salt://common/files/etc/salt/minion.d/example.conf
    - user: root
    - group: root
    - mode: '0600'

salt-minion-svc:
  service.running:
    - name: salt-minion
    - enable: True
    - watch:
      - file: /etc/salt/minion.d/example.conf

