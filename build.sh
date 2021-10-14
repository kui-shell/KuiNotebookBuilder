#
# Copyright 2021 The Kubernetes Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This file is used *outside of the container* to assist in performing
# the bundle build. It is mere convenience, nothing deep is intended
# here.
#
# Usage
#   build.sh <bundleTargetDir> <configDir> [offline]
#
# Required Parameters
#   - bundleTargetDir: The webpack bundles, index.html, etc. will be placed here
#   - configDir: Your configuration options, which includes a directory of notebooks.
#
# Notes:
#   1) all directories must be absolute paths.
#   2) if the final optional parameter is the string "offline" then the bundles will be configured
#

set -e
set -o pipefail

BUNDLE_TARGET_DIR="$1"
CONFIG_DIR="$2"

if [ "$3" = "offline" ]; then
    OFFLINE=true
else
    OFFLINE=false
fi

if [ ! -e "$BUNDLE_TARGET_DIR" ]; then
    mkdir "$BUNDLE_TARGET_DIR";
elif [ ! -d "$BUNDLE_TARGET_DIR" ]; then
    echo "Error: specified bundle target is not a directory: $BUNDLE_TARGET_DIR"
    exit 1
fi

docker run --rm \
       -e OFFLINE=$OFFLINE \
       -v "$BUNDLE_TARGET_DIR":/kui/dist/webpack \
       -v "$CONFIG_DIR":/config.d \
       quay.io/kuishell/notebook-builder
