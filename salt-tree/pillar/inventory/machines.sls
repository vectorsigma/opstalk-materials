# Warning: all machine entries that have a match in owners.sls *MUST*
# have a wireless option, whether or not they have a wifi card. 
machines:
  foo:
    description: "Derp's desktop"
    wired:
      mac: DE:AD:BE:EF:01:02
      ip: 192.168.1.10
    wireless:
  bar:
    description: "Herp's desktop"
    wired:
      mac: DE:AD:BE:EF:01:03
      ip: 192.168.1.11
    wireless:

