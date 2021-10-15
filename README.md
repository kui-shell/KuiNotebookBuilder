# Kui Notebook Builder

This repository helps you to build a set of webpack bundles that can
host a fixed set of Kui Notebooks. The build is dockerized, so you
don't even need to clone this template repository to get started.

## Quick Start (no need to clone this repo)

```sh
docker run --rm \
       -v "$BUNDLE_TARGET_DIR":/kui/dist/webpack \
       -v "$NOTEBOOKS_DIR":/config.d \
       -v "$CONFIG_DIR":/config.d \
       -e OFFLINE=$OFFLINE \
       quay.io/kuishell/notebook-builder
```

You will need to specify three inputs:

1. `$BUNDLE_TARGET_DIR`: absolute path to the target directory for the
   generated web app (index.html, etc.).
2. `$NOTEBOOKS_DIR`: absolute path to your [Kui
   Notebooks](#authoring-notebooks).
2. `$CONFIG_DIR`: absolute path to your config choices, such as the
   name of the application.
3. `OFFLINE=true|false`. If you want a [static single page
   application](https://en.wikipedia.org/wiki/Single-page_application),
   set `OFFLINE=true`. (Coming soon: quick builds for a hosted
   client/server architecture) 

A suggested usage is to instantiate this template repository once per
desired web application. This lets you store the `config.d` elements
(application name, set of notebooks) on a per-app basis. Also, if you
clone the repository, this process is slightly simplified:

```sh
./build.sh /tmp/bundles $PWD/notebooks $PWD/config.d offline
```

## Live Watching

If you wish to to live development, use the `watch.sh` script in place
of `build.sh`. Once the watcher is up, you can visit
`http://localhost:9080`. Changes to your notebooks or to your config.d
entries should be reflected on that web page.

## `config.d`: Specifying your application name, etc.

You may find an example configuration directory [here](config.d). You
may set the application title and favicon here. See the [example
config](config.d) for guidance.

## Authoring Notebooks

[Download Kui](https://github.com/kubernetes-sigs/kui/releases). You
may find help in the stock Kui client by consulting the
`Notebooks->Make Your Own Notebook` menu. Once you have a candidate
notebook, do a File->Save, and save it to your `config.d/notebooks`
directory.

## Advanced

If for some reason you need to generate a custom base image, consult
the [advanced documentation](advanced/README.md).
