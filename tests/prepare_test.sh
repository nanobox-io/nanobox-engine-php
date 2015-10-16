echo running tests for php
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-php sleep 365d

defer docker kill $UUID

pass "Failed to run prepare script" docker exec $UUID /opt/engines/php/bin/prepare "$(payload default-prepare)"