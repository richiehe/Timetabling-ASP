#! /bin/bash
echo "PASSWORD" |sudo -S sh -c 'echo 1 >/proc/sys/vm/drop_caches'
echo "PASSWORD" |sudo -S sh -c 'echo 2 >/proc/sys/vm/drop_caches'
echo "PASSWORD" |sudo -S sh -c 'echo 3 >/proc/sys/vm/drop_caches'
