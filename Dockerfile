#!/usr/bin/env bash
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

FROM images.zeelos.io/library/cp-base:5.2.1
LABEL maintainer="dev@zeelos.io" description="Kafka MirrorMaker - A stand-alone tool for copying data between two Apache Kafka clusters"

ENV COMPONENT kafka-mirrormaker

RUN echo "===> installing ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-kafka-2.11 \
    \
    && echo "===> clean up ..."  \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    \
    && echo "===> Setting up ${COMPONENT} dirs" \
    && mkdir -p /etc/${COMPONENT} \    
    && chmod -R ag+w /etc/${COMPONENT}

COPY include/etc/confluent/docker /etc/confluent/docker

CMD ["/etc/confluent/docker/run"]
