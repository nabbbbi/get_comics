#/bin/bash
# script downloads up to 50 images from url to the page of comics.
# in readcomicsonline.ru site.
# 1st argument will be url to an issue.
# f is name of comics
# s is url from site
# I is number of issue

# check cmd presence
test "$1" = "" && { echo "No arguments" ; exit 1; }
# get 'https://readcomicsonline.ru/comic/what-if-aliens-2024/1'
read c <<< `echo "$1" | sed 's/comic/uploads\/manga/2' | sed -r 's/\//\/chapters\//6'`
# get 'what-if-aliens-2024'
read f <<< `echo "$c" | sed -r 's/.{42}//' | sed -r 's/\/[^0-9]*\//_/' | sed -r 's/\/.*//'`

# make directory to put comics in
if test ! -d /home/pi/Pictures/Comics/$f; then
    mkdir /home/pi/Pictures/Comics/$f
else
    echo "Directory \"$f\" already exists!"
    exit 1
fi

sum=0
value=100
I=1
while test $I -le $value; do
    if test "$I" -le "9"; then
	wget -q --directory-prefix=/home/pi/Pictures/Comics/$f/ "$c/0$I.jpg"
    else
	wget -q --directory-prefix=/home/pi/Pictures/Comics/$f/ "$c/$I.jpg"
    fi
    I=$((I+1))
done
