#!/bin/bash

export PATH=/usr/local/bin:$PATH

test $# -ne 4 && echo "Usage: `basename $0` LAT LON NAME UNITS FONT COLOR" && exit $E_BADARGS

hash /usr/local/bin/webkit2png &> /dev/null
if [ $? -eq 1 ]; then
    echo "WebKit2Png not found."
echo "brew install webkit2png"
    exit 1
fi

hash /usr/local/bin/convert &> /dev/null
if [ $? -eq 1 ]; then
    echo "ImageMagick not found."
echo "brew install imagemagick"
    exit 1
fi

if [[ $4 =~ !(ca|si|uk|us|) ]] ; then
    echo "Arg 4 must be either ca, si, us, or uk"
    echo $4
    exit $E_BADARGS
fi

if [[ $6 =~ ~#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3}) ]] ; then
    echo "Arg 5 must be a hexadecimal color starting with #"
    echo $6
    exit $E_BADARGS
fi

cd `dirname $0`

export TEMPLATE_URL='http://forecast.io/embed/#lat=$LAT&lon=$LON&name=$NAME&font=$FONT&units=$UNITS&color=$COLOR'

export URL=$(echo $TEMPLATE_URL | sed -e "s/\$LAT/$1/" -e "s/\$LON/$2/" -e "s/\$NAME/$3/" -e "s/\$FONT/$4/" -e "s/\$UNITS/$5/" -e "s/\$COLOR/$6/")

echo "Converting to image"
webkit2png --width=500 --clipwidth=500 --height=245 --scale=1 -F --transparent --delay=5 -o tmpWeather -D /tmp $URL

echo "Moving image"
mv /tmp/tmpWeather-full.png /tmp/GeekWeather.png

exit 0
