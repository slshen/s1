# Use dnscrypt-proxy to encrypt DNS traffic

## Status

accepted

## Narrative

So it's always bothered me that my external DNS traffic is unencrypted.
TBH - this is the original motivation for all of this stuff.

I don't want to configure each an every machine on my home network
to use (https://dnscrypt.info/).  I'm far too lazy, and there are some
devices (e.g. Nest cameras, Apple TV, Chromecast, Amazon Alexa etc)
that I have no control over.

But I can [run my own dhcp server](004-dhcp-container.md), and point
the nameserver at a
[dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy) container
that I run locally.

As a bonus feature I can locally override DNS resolution for specific
names - see https://github.com/jedisct1/dnscrypt-proxy/wiki/Cloaking.
