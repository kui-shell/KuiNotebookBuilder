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

FROM node:12-bullseye-slim

WORKDIR /kui
EXPOSE 9080

## preesed tzdata, update package index, upgrade packages and install needed software
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

COPY package.json package.json
COPY package-lock.json package-lock.json
COPY tsconfig.json tsconfig.json
COPY packages packages
COPY plugins plugins
COPY bin bin

RUN echo "tzdata tzdata/Areas select America\ntzdata tzdata/Zones/America select New_York" > /tmp/preseed.txt && \
        debconf-set-selections /tmp/preseed.txt && \
        rm -f /etc/timezone /etc/localtime && \
        apt update && apt install -y --no-install-recommends python build-essential && \
        npm ci && npm run compile && \
        npm cache clean --force && \
        apt autoremove -y python build-essential && apt -y clean

ENTRYPOINT ["bin/build.sh"]
