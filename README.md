# Kui Notebook Builder

This repository helps you to build a set of webpack bundles that can
host a fixed set of Kui Notebooks.

## Usage

```sh
#
# Usage
#   build.sh <bundleTargetDir> <configDir> [offline]
#
# Required Parameters
#   - bundleTargetDir: The webpack bundles, index.html, etc. will be placed here
#   - configDir: Your configuration options, which includes a directory of notebooks.
#
# Notes:
#   1) All directories must be absolute paths.
#   2) If the final optional parameter is the string "offline" then the bundles will be configured.
#
```

For example, if you want to use the [example config.d](config.d):

```sh
./build.sh /tmp/bundles $PWD/config.d offline
```

### `config.d`: Specifying your list of Notebooks, etc.

You may find an example configuration directory [here](config.d). The
minimum requirement for this directory is that it contain a
subdirectory [config.d/notebooks](config.d/notebooks). This directory
contains a set of Kui Notebooks that will be presented in your client.

### Authoring Notebooks

[Download Kui](https://github.com/kubernetes-sigs/kui/releases). You
may find help in the stock Kui client by consulting the
`Notebooks->Make Your Own Notebook` menu. Once you have a candidate
notebook, do a File->Save, and save it to your `config.d/notebooks`
directory here.

## Advanced

If for some reason you need to generate a custom base image, consult
the [advanced documentation](advanced/README.md).
