#!/bin/bash
url=$1
I=1
MAX=400

while test $I -le $MAX; do
    if test $I -le 9; then
	append=0$I.jpg
    else
	append=$I.jpg
    fi
    if curl --output /dev/null --silent --head --fail "$url$append"; then
	I=$((I+1))
    else
	I=$((I-1))
	echo "There are $I issues"
	break
    fi
done
