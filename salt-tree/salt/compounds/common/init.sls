# Common control files.
# I split out the super basic stuff into a bootstrap state that I can run once
# by hand on a freshly built node to point it to local resources and do some
# ultra-basic configuration stuff.  Could probably even do it using salt-ssh.
include:
  - .bootstrap
  - .packages
  - .stop
  - .start
