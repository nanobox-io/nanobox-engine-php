echo running tests for php
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-php sleep 365d

defer docker kill $UUID

pass "unable to create code folder" docker exec $UUID mkdir -p /opt/code

fail "Detected something when there shouldn't be anything" docker exec $UUID /opt/engines/php/bin/sniff /opt/code

pass "Failed to inject php file" docker exec $UUID touch /opt/code/index.php

pass "Failed to detect PHP" docker exec $UUID /opt/engines/php/bin/sniff /opt/code