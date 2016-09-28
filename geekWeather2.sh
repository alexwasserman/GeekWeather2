#!/bin/bash
set -o nounset
set -o errexit

export PATH=/usr/local/bin:$PATH

usage()
{
cat << usage
USAGE: $0 -A LAT -O LON [-n NAME] [-d LIGHT/DARK] [-u units] [-f font] [-z zoom ] [-h help]

OPTIONS:
   -A		Coordinates: LAT
   -O		Coordinates: LON
   -n		Name. One word. Defaults to GeekWeather
   -d		Dark or Light output. Default: LIGHT
   -u      	Units: US is the default, or pick: US UK SI CA. Default: US [optional]
   -f      	Font: Set a font to use. Default: Helvetica [optional]
   -z 		Zoom: 2 will double the output image. Default: 1 [optional]
   -h      	Show this message and exit.
usage
}

# Set defaults
UNITS="US"
FONT="Helvetica"
HUE="LIGHT"
NAME="GeekWeather"
E_BADARGS=1
ZOOM=1

# Check we have at least 4 args
if [[ $# -lt 4 ]]; then
    usage
    exit $E_BADARGS
fi

A_FLAG=0
O_FLAG=0

# Process args
while getopts ":A:O:n:d:u:f:hz:" OPTION;
do
     case $OPTION in
 	    A)
 	     	LAT=$OPTARG
			A_FLAG=1
 	     	;;
		O)
	     	LON=$OPTARG
			O_FLAG=1
	     	;;			
		n)
		 	NAME=$OPTARG
			;;
		d)
			HUE=$OPTARG
			;;
        u)
            UNITS=$OPTARG
            ;;
        f)
            FONT=$OPTARG
            ;;
	    z)
	        ZOOM=$OPTARG
	        ;;
	    h)
	        usage
	        exit 1
	        ;;
        \?)
			echo "ERROR:"
			echo "    -$OPTARG is not an option"
			echo ""
            usage
            exit $E_BADARGS
            ;;
		:)
			echo "ERROR:"
			echo "    -$OPTARG requires an argument"
			echo ""
			usage
			exit $E_BADARGS
			;;
     esac
done

if [[ $A_FLAG == 0 || $O_FLAG == 0 ]];
then
    usage
    exit $E_BADARGS
fi

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

if [[ ! ( $NAME =~ (^[a-zA-Z0-9\_\ ]+$) ) ]] ; then
	echo "Error"
	echo "    $NAME is not an allowed name"
	echo ""
	usage
    exit $E_BADARGS
fi

if [[ ! ( $UNITS =~ [CA|SI|UK|US] ) ]] ; then
	echo "Error"
	echo "    $UNITS is not allowed set of units"
	echo ""
	usage
    exit $E_BADARGS
fi

if [[ ! ( $ZOOM =~ [1-4] ) ]] ; then
	echo "Error"
	echo "    $ZOOM is not allowed zoom size: 1-4"
	echo ""
    usage
    exit $E_BADARGS
fi

if [[ ( $HUE =~ [^LIGHT$|^DARK$] ) ]] ; then
	echo "Error"
	echo "    $HUE is not allowed output choice"
	echo ""
    usage
    exit $E_BADARGS
fi

cd `dirname $0`
export Space="%20"
export NAME="${NAME// /$Space}"
export TEMPLATE_URL='http://forecast.io/embed/#lat=$LAT&lon=$LON&name=$NAME&font=$FONT&units=$UNITS'

export URL=$(echo $TEMPLATE_URL | sed -e "s/\$LAT/$LAT/" -e "s/\$LON/$LON/" -e "s/\$NAME/$NAME/" -e "s/\$UNITS/$UNITS/" -e "s/\$FONT/$FONT/")

echo "Converting to image"
webkit2png --width=400 --clipwidth=400 --height=245 --scale=1 -z $ZOOM -F --transparent --delay=5 -o tmpWeather -D /tmp $URL

echo "Running image smoothing"
if [[ $HUE == "LIGHT" ]]; then
    convert -quiet -negate -modulate 150 png:/tmp/tmpWeather-full.png png:/tmp/GeekWeather.png
    rm /tmp/tmpWeather-full.png
elif [[ $HUE == "DARK" ]]; then
    mv /tmp/tmpWeather-full.png /tmp/GeekWeather.png
fi

echo "Completed"

exit 0
