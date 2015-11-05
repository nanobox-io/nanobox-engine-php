FROM nanobox/build:beta

# Remove existing engines, we don't want to test those
RUN rm -rf /opt/engines/*

# Create folders for this engine
RUN mkdir -p /opt/engines/php/bin && \
    mkdir -p /opt/engines/php/lib && \
    mkdir -p /opt/engines/php/templates

RUN curl https://codeload.github.com/nanobox-io/nanobox-engine-nodejs/tar.gz/master | \
    tar -xzC /opt/engines/php --strip-components 1

# Add in this engine's files
ADD bin/. /opt/engines/php/bin
ADD lib/. /opt/engines/php/lib
ADD templates/. /opt/engines/php/templates