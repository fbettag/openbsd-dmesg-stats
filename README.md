The goal of this project is to have a script which pulls dmesg data from nycbug and makes statistics about drivers and configurations used.

## Dependencies to run the scripts

OpenBSD base system is enough.

## Running

First run **./download.sh**, then once it downloaded all the dmesgs that aren't already in the repo, proceed to run **./analyse.sh 6.7** or some other OpenBSD version.

