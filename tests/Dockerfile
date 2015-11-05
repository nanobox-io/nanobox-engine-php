FROM nanobox/build:beta

# Remove existing engines, we don't want to test those
RUN rm -rf /opt/engines/*

# Create folders for this engine
RUN mkdir -p /opt/engines/php/bin && \
    mkdir -p /opt/engines/php/lib && \
    mkdir -p /opt/engines/php/templates

RUN curl https://github.com/nanobox-io/nanobox-engine-nodejs/archive/master.tar.gz | tar -xzC /opt/engines/php

# Add in this engine's files
ADD bin/. /opt/engines/php/bin
ADD lib/. /opt/engines/php/lib
ADD templates/. /opt/engines/php/templates