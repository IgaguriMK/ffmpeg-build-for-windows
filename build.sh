#! /bin/sh

set -ex

mkdir .ssh
chmod 700 .ssh
mv known_hosts .ssh/
chmod 700 .ssh/known_hosts

mkdir bin

git clone https://github.com/rdp/ffmpeg-windows-build-helpers.git

cd ffmpeg-windows-build-helpers

if [ "$TARGET_MARCH" == "" ]; then
	TARGET_MARCH=core2
fi

set +x

tput setaf 2

echo "TARGET_MARCH=$TARGET_MARCH" | tee /home/builder/bin/build-setting.txt
echo "\n--------------------------------------------------" | tee -a /home/builder/bin/build-setting.txt
git log -n 1 | tee -a /home/builder/bin/build-setting.txt
echo "--------------------------------------------------" | tee -a /home/builder/bin/build-setting.txt

tput sgr0

sleep 20

set -x

./cross_compile_ffmpeg.sh \
	--build-ffmpeg-static=y \
	--disable-nonfree=n \
	--compiler-flavors=win64 \
	--cflags='-march=silvermont -O3'

cd /home/builder
cp /home/builder/ffmpeg-windows-build-helpers/sandbox/win64/ffmpeg_git_with_fdk_aac/ffmpeg.exe bin/
cp /home/builder/ffmpeg-windows-build-helpers/sandbox/win64/ffmpeg_git_with_fdk_aac/ffmpeg_g.exe bin/
cp /home/builder/ffmpeg-windows-build-helpers/sandbox/win64/ffmpeg_git_with_fdk_aac/ffplay.exe bin/
cp /home/builder/ffmpeg-windows-build-helpers/sandbox/win64/x264_normal_bitdepth/x264.exe bin/
cp /home/builder/ffmpeg-windows-build-helpers/sandbox/win64/x265/source/x265.exe bin/
