# s1 - Single Host Simple Docker

This repo contains the setup that I use to run a couple of docker
containers at home on an Intel NUC-class machine (Intel Pentium Silver
J5005 with 8GB ram.)

This is my actual setup. (Any sensitve data isn't here, it's either
resident locally on the machine or been pushed into my own private s3
bucket.)

# Host Setup

I'm using Alpine linux as the host OS.  See <host_setup.sh> for
pseudo-code on how's it's been setup.

For docker, I've enabled mutual TLS with a locally signed cert.
The certs have been dropped into `/var/local/docker`.  The
certs and keys are readable for any user in the `docker` group.

I use a different cert for each machine I connect from (e.g. my
Windows laptop, my Windows desktop, and my Mac all have different certs.)
To generate a new client cert, I run:

    $ sudo ./create-docker-client-cert.sh my-new-machine

I then `scp` the certs out of the host
`/var/local/docker/client-certs/my-new-machine/*` to `~/.docker` and
set `DOCKER_HOST` and `DOCKER_TLS_VERIFY=1`.

# Network Setup

I've chosen to use an `ipvlan` network with space carved out
of the 192.168.1.0/24 network that my router uses my default.

See https://hicu.be/macvlan-vs-ipvlan for some helpful background.

Regarding `ipvlan`:

* All the ip's have the same mac address so I can't use DHCP.  But I'm
delegating IP address assignment to docker, so I don't care.
* Perhaps sharing mac address is a performance issue on the host's
network interface?  But this is my home network so I don't care.
* The `ipvlan` documentation says you've got to talk to your system
administrator -- I believe so that you know the IP block isn't going
to conflict with anything.  But I'm my own system administrator, and I
can talk to myself.
* The big win - `ipvlan` lets me start containers where each container
gets its own ip address that is completely accessible on my home
network.  I can even start a container with a fixed IP address.  No
bridging, proxy or overlay network required.  It's almost like running
a bunch of VM's on the box, except simpler.

# dhcp container

Ok, it's a bit of [changing the lightbulb thing](https://www.youtube.com/watch?v=AbSehcT19u0)
here.

My router (Netgear Orbi, which is otherwise fine) does not let me
carve out an IP range in its DHCP server -- I have to disable the
router's DHCP server and run my own.



