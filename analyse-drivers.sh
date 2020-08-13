#!/bin/sh

_openbsd_rel=6.7
if [ $# -eq 1 ]; then
	_openbsd_rel=$1
fi
_out=$(mktemp)

for _dmesg in dmesgs/*.dmesg; do
	echo "analysing ${_dmesg}..."
	if [ `grep -c "OpenBSD ${_openbsd_rel}" ${_dmesg}` -eq 0 ]; then
		echo "${_dmesg} is not OpenBSD ${_openbsd_rel}, ignoring..."
		continue
	fi

	cat ${_dmesg} | egrep -ve 'not configured|Contact us|&quot|\[drm\]| ohci\* at|WARNING|\* at|entry point at|You can exit' | egrep -oe '^.* at' | sed -Ee 's;[0-9]+ at$;;g' -e 's; at at;;g' | grep -v : | sort | uniq >> ${_out}
done

cat ${_out} | sort | uniq -c | sort -r > dmesgs/dmesg-${_openbsd_rel}.drivers
rm -f ${_out}
