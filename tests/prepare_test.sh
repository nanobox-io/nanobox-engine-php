echo running tests for php
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-php sleep 365d

defer docker kill $UUID

pass "create db dir for pkgsrc" docker exec $UUID mkdir -p /data/var/db

pass "Failed to update pkgsrc" docker exec $UUID /data/bin/pkgin up -y

pass "Failed to run prepare script" docker exec $UUID bash -c "cd /opt/engines/php/bin; ./prepare '$(payload default-prepare)'"