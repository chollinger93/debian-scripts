#!/bin/bash
if [[ -z "${MUSIC_PATH}" ]]; then
	MUSIC_PATH="/mnt/6TB/Music"
fi
URL=$1
ARTIST=$2
SONG=$3
SKIP_YT_FILE=$4
TARGET="${MUSIC_PATH}/${ARTIST}/"
source ../util/package_installed.sh
source ../util/logging.sh
if [ $# -le 2 ]; then
	logErr "Wrong arguments, usage \$URL \$ARTST \$SONG"
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
#pip install youtube-dl --user
youtubedl=$(youtube-dl --version)
log "youtube-dl is in version ${youtubedl}; if you encounter issues, please check"
log "https://github.com/ytdl-org/youtube-dl/blob/master/README.md#how-do-i-update-youtube-dl"

# Trying update
if [[ $(id -u) -ne 0 ]]; then
	logWarn "Can't run youtube-dl update, you are not root - and probably shouldn't be. Please try:"
	logWarn "sudo youtube-dl -U"
else 
	youtube-dl -U
	if [[ $? -ne 0 ]]; then
		logWarn "Couldn't update youtube-dl"
	fi
fi

log "Creating ${TARGET}"
mkdir -p "${TARGET}"
if [[ ! -z $4 ]]; then
	log "Skipping youtube, weirdo... (cp $4 to ${SONG}.mp3)"
	cp "${4}" "${SONG}.mp3"
	if [[ $? -ne 0 ]]; then logErr "Yeah, that worked out greaaaaaat. Param \$4 is the MP3 name if you want to skip the YT download." && exit 1; fi
else
	youtube-dl --verbose --extract-audio --audio-format "mp3" -o "${SONG}" --audio-quality 0 --prefer-ffmpeg  --output "${SONG}.%(ext)s"  "${URL}"
fi
if [ $? -ne 0 ]; then
	logErr "Download failed!"
fi

log "Creating Id3 Tags..."
id3v2 "${SONG}.mp3" -a "${ARTIST}"
id3v2 "${SONG}.mp3" -t "${SONG}"

log "Moving ${SONG}.mp3 to ${TARGET}"
mv "${SONG}.mp3" "${TARGET}"
log "Done"
