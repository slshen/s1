# Use ipvlan docker network

## Status

accepted

## Narrative

The default `docker` network is a private network that isn't accessible
from outside the host without doing something.  I don't want to do anything,
I want to treat my containers like tiny little VM's that are really fast to
boot and easier to manage.

I've chosen to use an `ipvlan` network - see
https://hicu.be/macvlan-vs-ipvlan for some helpful background.

The [host_setup.sh](../host_setup.sh) pseudo-code sets up an `ipvlan` network named
`net160` that gives each container its own ip in a range I've carved
out of my local home network (192.168.1.160/27).

Some other notes:

* All the ip's have the same mac address so I can't use DHCP.  But I'm
delegating IP address assignment to docker, so I don't care.
* Perhaps sharing mac address is a performance issue on the host's
network interface?  But this is my home network so I don't care.
* The `ipvlan` documentation says you've got to talk to your system
administrator -- I believe so that you know the IP block isn't going
to conflict with anything.  But I'm my own system administrator, and I
can talk to myself.  (And what I did is covered in
(004-dhcp-container.md).)

