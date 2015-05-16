#
# Bootstrap the minimum necessary configs for Salt.
# You could also put states here to enable, say, a repository definition for
# for a local mirror, etc.

# Control the salt minion configs
salt-minon-conf:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://compounds/common/files/etc/salt/minion
    - user: root
    - group: root
    - mode: '0600'

salt-minion-svc:
  service.running:
    - name: salt-minion
    - enable: True
    - watch:
      - file: /etc/salt/minion

