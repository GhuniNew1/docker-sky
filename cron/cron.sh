#!/bin/sh
set -eu
mount /mnt/data
exec busybox crond -f -l 0 -L /dev/stdout
