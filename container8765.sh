# create /tmp/cgrp, mount RDMA cgroup controller into it and create child cgroup 
mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp && mkdir /tmp/cgrp/x 
# Enable the notify_on_release flag
echo 1 > /tmp/cgrp/x/notify_on_release
# Define host_path parameter with the container path on host
host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
# Define path in release_agent which execute when all a cgroup tasks are done.
echo "$host_path/cmd" > /tmp/cgrp/release_agent
echo '#!/bin/sh' > /cmd
echo "ps aux > $host_path/output" >> /cmd
