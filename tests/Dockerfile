FROM nanobox/build

# Remove existing engines, we don't want to test those
RUN rm -rf /opt/engines/*

# Create folders for this engine
RUN mkdir -p /opt/engines/php/bin && \
    mkdir -p /opt/engines/php/lib && \
    mkdir -p /opt/engines/php/templates

# Add in this engine's files
ADD bin/. /opt/engines/php/bin
ADD lib/. /opt/engines/php/lib
ADD templates/. /opt/engines/php/templates