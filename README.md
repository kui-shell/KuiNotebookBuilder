# Kui Notebook Builder

This repository helps you to build a set of webpack bundles that can
host a fixed set of Kui Notebooks. The build is dockerized, so you
don't even need to clone this template repository. If offers some
convenience scripts, and examples, which may help you or hinder you,
depending on your needs.

## Quick Start (no need to clone this repo)

```sh
docker run --rm \
       -v "$BUNDLE_TARGET_DIR":/kui/dist/webpack \
       -v "$CONFIG_DIR":/config.d \
       -e OFFLINE=$OFFLINE \
       quay.io/kuishell/notebook-builder
```

You will need to specify three inputs:

1. `$BUNDLE_TARGET_DIR`: absolute path to the target directory for the
   generated web app (index.html, etc.).
2. `$CONFIG_DIR`: absolute path to your notebooks and other config
   choices. Populate `config.d/notebooks` with your [Kui
   Notebooks](#authoring-notebooks).
3. `OFFLINE=true|false`. If you want a [static single page
   application](https://en.wikipedia.org/wiki/Single-page_application),
   set `OFFLINE=true`. (Coming soon: quick builds for a hosted
   client/server architecture) 

If you clone the repository, then this process is slightly simplified:

```sh
./build.sh /tmp/bundles $PWD/config.d offline
```

## `config.d`: Specifying your list of Notebooks, etc.

You may find an example configuration directory [here](config.d). The
minimum requirement for this directory is that it contain a
subdirectory [config.d/notebooks](config.d/notebooks). This directory
contains a set of Kui Notebooks that will be presented in your client.

You may set the application title and favicon as well. See the
[example config](config.d) for guidance.

## Authoring Notebooks

[Download Kui](https://github.com/kubernetes-sigs/kui/releases). You
may find help in the stock Kui client by consulting the
`Notebooks->Make Your Own Notebook` menu. Once you have a candidate
notebook, do a File->Save, and save it to your `config.d/notebooks`
directory.

## Advanced

If for some reason you need to generate a custom base image, consult
the [advanced documentation](advanced/README.md).
