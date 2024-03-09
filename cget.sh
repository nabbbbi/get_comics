#/bin/bash
# script downloads up to 50 images from url to the page of comics.
# in readcomicsonline.ru site.
# 1st argument will be url to an issue.
# f is name of comics
# s is url from site
# counter_1 is number of issue

# check cmd presence
test "$1" = "" && { echo "No arguments" ; exit 1; }
# get 'https://readcomicsonline.ru/comic/what-if-aliens-2024/1' as url
read url <<< `echo "$1" | sed 's/comic/uploads\/manga/2' | sed -r 's/\//\/chapters\//6'`
# get 'what-if-aliens-2024' as name via regex
read name <<< `echo "$url" | sed -r 's/.{42}//' | sed -r 's/\/[^0-9]*\//_/' | sed -r 's/\/.*//'`

# make directory to put comics in
if test ! -d $HOME/Pictures/Comics/$name; then
    mkdir $HOME/Pictures/Comics/$name
else
    echo "Directory \"$name\" already exists!"
    exit 1
fi

# checking number of issues
checkurl=$url/
counter_2=1
MAX=400

while test $counter_2 -le $MAX; do
    if test $counter_2 -le 9; then
	append=0$counter_2.jpg
    else
	append=$counter_2.jpg
    fi
    if curl --output /dev/null --silent --head --fail "$checkurl$append"; then
	counter_2=$((counter_2+1))
    else
	counter_1=$((counter_2-1))
	value=$counter_2
	break
    fi
done

# main program
counter_1=1
while test $counter_1 -le $value; do
    if test "$counter_1" -le "9"; then
	wget -q --directory-prefix=$HOME/Pictures/Comics/$name/ "$url/0$counter_1.jpg"
	echo -n "*"
    else
	wget -q --directory-prefix=$HOME/Pictures/Comics/$name/ "$url/$counter_1.jpg"
	echo -n "*"
    fi
    counter_1=$((counter_1+1))
done
echo " "
