# Bootstrapping a new Salt Master

Let's say you accidentally the data on your old salt master.  How do you recover?

Well, it goes something like this..

## Prerequisities

1. A freshly reinstalled Fedora system, version >= 20.
2. Internet access
3. This repository.
4. Make sure you have a non-root user that can:
  1. SSH into the machine via public key authentication.
  2. become root with no password via sudo.
5. Ensure you have a proper entry in your `~/.ssh/confg` for the master.

## Making it work

1. Log into the salt master
2. Become root.
3. `mkdir -p /srv/{salt,pillar}`
4. `chown you:root /srv/{salt,pillar}`
5. `chmod -R 770 /srv/{salt,pillar}`
6. run the `bin/2salt` script.
7. Start the salt master: `sudo systemctl start salt-master`
8. Disable the firewall:
  1. `systemctl stop firewalld`
  2. `systemctl stop iptables`
9. Set the hostname correctly, if DHCP gets it wrong for some reason.

## Unfucking the minions

Perform the following on every minion:

1. log in via ssh
2. become root
3. remove /etc/salt/pki/minion/minion_master.pub
4. restart the minion

On the master:

1. `sudo salt-key -A` to re-add all the pub keys.

# NEXT TIME BACK UP YOUR FUCKING SALT KEYS.
