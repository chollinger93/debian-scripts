#!/bin/bash
isInstalled(){
	PACKAGE=$1
	echo "Checking Package ${PACKAGE}"
	if [[ -z $(dpkg -l "${PACKAGE}") ]]; then
		>&2 echo "youtube-dl is not installed"
		>&2 echo "install with:"
		>&2 echo "sudo apt-get install ${PACKAGE}"
		return 1
	else
		>&2 echo "Package ${PACKAGE} is installed!"
	fi
	return 0
}
