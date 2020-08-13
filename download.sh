#!/bin/sh

_url="https://dmesgd.nycbug.org/index.cgi?do=index&fts=OpenBSD"
_dmesg_url_r="https://dmesgd.nycbug.org/index.cgi\\?do=view[^\"]+"

mkdir -p dmesgs || exit 1

for dmesg_url in $(ftp -o- ${_url} | egrep -oe ${_dmesg_url_r} || exit 1); do
	_id=$(echo ${dmesg_url} | sed -E 's;^.*id=;;g')
	if [ ! -f dmesgs/${_id}.dmesg ]; then
		echo "Downloading new dmesg ${_id}..."
		ftp -o dmesgs/${_id}.dmesg ${dmesg_url} || echo "Failed to download dmesg ${_id} :( maybe on the next run.."
	fi
done

