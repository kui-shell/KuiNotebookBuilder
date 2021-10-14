# Advanced Use Only

This directory contains the source to the published image:
[quay.io/kuishell/notebook-builder](https://quay.io/kuishell/notebook-builder). You
probably want to consume this image, rather than re-generate it. To
consume the notebook builder, consult the [top level
README](../README.md).

If you really want to rebuild it:

```sh
docker build -t quay.io/kuishell/notebook-builder .
```

You may also want to adjust the Kui version dependences in
[package.json](package.json). If you do this, make sure to re-generate
the package-lock.json.
