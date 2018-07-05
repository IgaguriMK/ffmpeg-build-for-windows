#! /bin/sh

set -ex

echo running >> /mnt/artifacts/check-mount

(cd /home/builder && su builder -c ./build.sh)
cp /home/builder/bin/* /mnt/artifacts/

rm /mnt/artifacts/check-mount

tput bel
