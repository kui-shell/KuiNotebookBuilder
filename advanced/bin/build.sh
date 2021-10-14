#!/usr/bin/env bash

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
# This file is used *inside of the container* to perform the final
# bundle build. It is not used to rebuild the base image itself. For
# that, a simple `docker build` suffices in the advanced/ directory of
# the template repository.
#

set -e
set -o pipefail

cd /kui

export MODE=${MODE-production}

#if [ ! -d /bundles ]; then
#    echo "Perhaps you forgot to mount your output bundle directory on /bundles?"
#    exit 1
#else
#    export KUI_BUILDDIR=/bundles
#fi

if [ ! -d /config.d ]; then
    echo "Perhaps you forgot to mount your config on /config?"
    exit 1
fi

if [ ! -d /config.d/notebooks ]; then
    echo "Your config includes no notebooks"
    exit 1
fi

# this is just a convenience variable, nothing deep here
CLIENT=node_modules/@kui-shell/client

# copy in the build-time notebooks and configuration
cp /config.d/*.json $CLIENT/config.d
cp /config.d/notebooks/* $CLIENT/notebooks

# and add then to the autoplay.json
ls /config.d/notebooks | awk 'BEGIN { printf "["} {if (FNR > 1) printf ","; printf "\"" $1 "\""} END { printf "]" }' > $CLIENT/config.d/autoplay.json

echo "AUTOPLAY: $(cat $CLIENT/config.d/autoplay.json)"

# were we were asked to build an offline service?
if [ -n "$OFFLINE" ]; then
    mv $CLIENT/config.d/proxy-offline.json $CLIENT/config.d/proxy.json
    mv $CLIENT/config.d/client-offline.json $CLIENT/config.d/client.json
fi

# now build the webpack bundles
npx kui-build-webpack
