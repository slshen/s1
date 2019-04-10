# Enable remote use of Docker

## Status

accepted

## Narrative

So it turns out that on my Windows Home laptop and desktop I can't
quite so seamlessly run Docker desktop (requires Hyper-V, which is
only available with Windows Pro, and I'm too cheap.)  But here
I've got this box running Docker, why can't I use that?

And so I can.  But I'm not going to just open it up blindly to anyone
on my network - I do sorta trust my home network, but then again, I
also sorta don't trust my home network.

So docker remote access for docker is enabled, but it requires mutual
TLS.  The certs have been dropped into `/var/local/docker` on the
hosts and are readable for any user in the `docker` group.  (Because,
look, if they're in the `docker` group that already have access to
`/var/run/docker.sock` and this is just the remote form of that.)

I'm using a different cert for each machine I connect from (e.g. my
Windows laptop, my Windows desktop, and my Mac all have different
certs.)  To generate a new client cert, I run:

    $ sudo ./create-docker-client-cert.sh my-new-machine

I then `scp` the certs out of the host
`/var/local/docker/client-certs/my-new-machine/*` to `~/.docker` and
set `DOCKER_HOST` and `DOCKER_TLS_VERIFY=1`.
