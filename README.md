# How Not To Fail At Ops: presentation materials

## What's here?

All of the materials that we used, referenced, or demonstrated during our talk: "How not to fail at ops."

This is the same content that is available on the thumb drives we distributed,
with the exception of the [CentOS 7 ISO](http://mirrors.kernel.org/centos/7.1.1503/isos/x86_64/CentOS-7-x86_64-Everything-1503-01.iso).  
No need to add a 7GB ISO to an otherwise tiny git repo.

## Rough details

* `kickstart/` :: Contains the kickstart file we used for the boot strap node and the subsequent VMs
* `salt-tree/` :: Contains the saltstack states we used to configure the bootstrap node
* `scripts/` :: Contains the scripts we used to automatically build the demo VMs
* `slides/` :: PDF and PPTx copies of our slide deck, with speaker notes for lulz.

## Documentation Links

The following is a small, focused list of further reading to help understand what
we've talked about, and where you can learn more:

*note:* You can google for answers to just about anything, and you'll likely find
something on [SuperUser](https://superuser.com/).  But that's just google giving
you a fish.  We want you to learn how to fish, and sometimes, the canonical
documentation is the best place to start.  It's worth the time.

1. [Getting started with SaltStack](http://docs.saltstack.com/en/latest/#getting-started)
  1. [Full Saltstack Documentation](http://docs.saltstack.com/en/latest/contents.html)
2. [Redhat 7 Systems Administrator Guide](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/pdf/System_Administrators_Guide/Red_Hat_Enterprise_Linux-7-System_Administrators_Guide-en-US.pdf)
3. [Fedora Kickstart Guide](https://fedoraproject.org/wiki/Anaconda/Kickstart)
4. [Fedora 21 System Administrator Guide](http://docs.fedoraproject.org/en-US/Fedora/21/html/System_Administrators_Guide/index.html)

