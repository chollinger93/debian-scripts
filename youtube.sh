#!/bin/bash
MUSIC_PATH="/mnt/6TB/Music"
URL=$1
ARTIST=$2
SONG=$3
SKIP_YT_FILE=$4
TARGET="${MUSIC_PATH}/${ARTIST}/"
source ./package_installed.sh
if [ $# -le 3 ]; then
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
# Update youtube-dl
pip install --upgrade pip --user
pip install youtube-dl --user
if [[ $? -ne 0 ]]; then
	echo "Something went wrong when updating" >&2
fi

echo "Creating ${TARGET}"
mkdir -p "${TARGET}"
if [[ ! -z $4 ]]; then
	echo "Skipping youtube, weirdo... (cp $4 to ${SONG}.mp3)"
	cp "${4}" "${SONG}.mp3"
	if [[ $? -ne 0 ]]; then echo "Yeah, that worked out greaaaaaat. Param \$4 is the MP3 name if you want to skip the YT download." && exit 1; fi
else
	youtube-dl --verbose --extract-audio --audio-format "mp3" -o "${SONG}" --audio-quality 0 --prefer-ffmpeg  --output "${SONG}.%(ext)s"  "${URL}"
fi
if [ $? -ne 0 ]; then
	>&2 echo "Download failed!"
fi

echo "Creating Id3 Tags..."
id3v2 "${SONG}.mp3" -a "${ARTIST}"
id3v2 "${SONG}.mp3" -t "${SONG}"

echo "Moving ${SONG}.mp3 to ${TARGET}"
mv "${SONG}.mp3" "${TARGET}"
echo "Done"
