# Run samba

## Status

exploratory

## Narrative

The [AWS SAM tooling](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) by default runs stuff in the local docker engine.

But when I'm running on a Windows Home machine I don't have a local docker engine.

Fortunately it seems that `sam` supports this via the
[--docker-volume-basedir](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-local-start-api.html)
option.  But that requires sharing the `sam` working directory with the docker host.

So I need to run `samba` on the host, mount the shared directory on
windows, and supply the right flag to `sam local ...` and it should
work.

A secondary motivation is to migrate my existing https://freenas.org/
storage server to the much more efficient NUC-box.  (I really don't
need all the features of FreeNAS.)
