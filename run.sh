#! /bin/sh

set -ex

(cd /home/builder && su builder -c ./build.sh)
cp /home/builder/bin/* /mnt/artifacts/

tput bel
