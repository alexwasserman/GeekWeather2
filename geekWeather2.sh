#!/bin/bash

export PATH=/usr/local/bin:$PATH

# echo "Starting: " `date`
# echo "******************"
# ps -ef | grep $PPID

test $# -ne 4 && echo "Usage: `basename $0` LAT LON NAME LIGHT/DARK" && exit $E_BADARGS

hash /usr/local/bin/gs &> /dev/null
if [ $? -eq 1 ]; then
    echo "GhostScript not found."
    exit 1
fi

hash /usr/local/bin/wkhtmltoimage &> /dev/null
if [ $? -eq 1 ]; then
    echo "wkhtmltoimage not found."
    exit 1
fi

hash /usr/local/bin/convert &> /dev/null
if [ $? -eq 1 ]; then
    echo "ImageMagick not found."
    exit 1
fi

export LIGHT=""

if [[ $4 == "LIGHT" ]]; then
    export LIGHT="-negate"
elif [[ $4 == "DARK" ]]; then
    echo ""
else 
    echo "Arg 4 must be one of LIGHT or DARK"
    exit $E_BADARGS
fi

cd `dirname $0`

export TEMPLATE_HTML='<iframe id="forecast_embed" type="text/html" frameborder="0" height="275" width="550" src="http://forecast.io/embed/#lat=$LAT&lon=$LON&name=$NAME"></iframe>'

export HTML=$(echo $TEMPLATE_HTML | sed -e "s/\$LAT/$1/" -e "s/\$LON/$2/" -e "s/\$NAME/$3/")

echo $HTML > /tmp/geekweather2.html

echo "Converting to image"
wkhtmltoimage --enable-javascript --javascript-delay 3000 --width 550 /tmp/geekweather2.html /tmp/tmp1.png

echo "Running image smoothing"
if [[ $4 == "LIGHT" ]]; then
	convert -quiet -negate png:/tmp/tmp1.png -fuzz 30% -transparent black -fill '#CCC' -fuzz 60% -opaque '#888' -fuzz 40% -fill white -opaque black -blur 0x.4 png:/tmp/weather.png
elif [[ $4 == "DARK" ]]; then
	convert -quiet png:/tmp/tmp1.png -fuzz 30% -transparent white -fuzz 30% -fill black -opaque white -blur 0x.4  png:/tmp/weather.png
fi

# rm /tmp/tmp1.png
rm /tmp/geekweather2.html

exit 0
