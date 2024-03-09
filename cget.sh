#/bin/bash
# script downloads up to 50 images from url to the page of comics.
# in readcomicsonline.ru site.
# 1st argument will be url to an issue.
# f is name of comics
# s is url from site
# I is number of issue

# check cmd presence
test "$1" = "" && { echo "No arguments" ; exit 1; }
# get 'https://readcomicsonline.ru/comic/what-if-aliens-2024/1' as url
read url <<< `echo "$1" | sed 's/comic/uploads\/manga/2' | sed -r 's/\//\/chapters\//6'`
# get 'what-if-aliens-2024' as name via regex
read name <<< `echo "$url" | sed -r 's/.{42}//' | sed -r 's/\/[^0-9]*\//_/' | sed -r 's/\/.*//'`

# make directory to put comics in
if test ! -d /home/pi/Pictures/Comics/$name; then
    mkdir /home/pi/Pictures/Comics/$name
else
    echo "Directory \"$name\" already exists!"
    exit 1
fi

# checking number of issues
checkurl=$url/
II=1
MAX=400

while test $II -le $MAX; do
    if test $II -le 9; then
	append=0$II.jpg
    else
	append=$II.jpg
    fi
    if curl --output /dev/null --silent --head --fail "$checkurl$append"; then
	II=$((II+1))
    else
	I=$((II-1))
	value=$II
	break
    fi
done

# main program
I=1
while test $I -le $value; do
    if test "$I" -le "9"; then
	wget -q --directory-prefix=/home/pi/Pictures/Comics/$name/ "$url/0$I.jpg"
    else
	wget -q --directory-prefix=/home/pi/Pictures/Comics/$name/ "$url/$I.jpg"
    fi
    I=$((I+1))
done
