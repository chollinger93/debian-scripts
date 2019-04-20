#!/bin/bash
MUSIC_PATH="/mnt/6TB/Music"
URL=$1
ARTIST=$2
SONG=$3
TARGET="${MUSIC_PATH}/${ARTIST}/"
source ./package_installed.sh
if [ $# -ne 3 ]; then
	>&2 echo "Wrong arguments, usage \$URL \$ARTST \$SONG"
	exit 1
fi
# Checking dependencies
isInstalled "youtube-dl"
if [[ $? -ne 0 ]]; then
	exit 1
fi
isInstalled "id3v2"
if [[ $? -ne 0 ]]; then
	exit 1
fi
echo "Creating ${TARGET}"
mkdir -p "${TARGET}"
youtube-dl --extract-audio --audio-format "mp3" -o "${SONG}" --audio-quality 0 --prefer-ffmpeg  --output "${SONG}.%(ext)s"  "${URL}"
if [ $? -ne 0 ]; then
	>&2 echo "Download failed!"
fi

echo "Creating Id3 Tags..."
id3v2 "${SONG}.mp3" -a "${ARTIST}"
id3v2 "${SONG}.mp3" -t "${SONG}"

echo "Moving ${SONG}.mp3 to ${TARGET}"
mv "${SONG}.mp3" "${TARGET}"
echo "Done"
