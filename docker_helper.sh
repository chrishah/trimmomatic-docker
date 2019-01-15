#! /bin/bash

. ~/.bashrc

#if [ "$1" == "/bin/bash" ]
#then
#	/bin/bash -c bash
if [ -z "$*" ]
then
	/bin/bash -c bash
elif [ "$1" == "trimmomatic" ]
then
	shift
	exec java -jar $DEST/$VERSION/$SW_NAME-$VERSION/trimmomatic-0.38.jar "$@"
else
	exec "$@"
fi
