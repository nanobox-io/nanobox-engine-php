#!/bin/bash

. /test/util/env.sh

# prepare environment (create directories etc)
prepare_environment

# prepare pkgsrc
prepare_pkgsrc

# create the code_dir
mkdir -p /tmp/code

# copy the app into place
cp -ar /test/apps/phpinfo/* /tmp/code

cd /engine/bin
