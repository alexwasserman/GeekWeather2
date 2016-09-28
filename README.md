GeekWeather 2
=============

GeekWeather is a geeklet for [Geektool] that shows the [DarkSky] weather on your desktop. LIGHT is a lighter image for use on darker desktops, DARK is a darker image for use on lighter desktops. LAT and LON are the coordinates of the location you want the weather report for.

[Powered By DarkSky]

*Requirements*
  - WebKit2Png  ```brew install webkit2png```
  - ImageMagick ```brew install imagemagick```

Version
----
2.0

Tech
-----------

GeekWeather uses:

* WebKit2Png: Converts the  webpage to a PNG
* ImageMagick: Image convertion
* ForeCast [API]

Script usage
--------------

```sh
USAGE: ./geekWeather2.sh -A LAT -O LON [-n NAME] [-d LIGHT/DARK] [-u units] [-f font] [-z zoom ] [-h help]

OPTIONS:
   -A		Coordinates: LAT
   -O		Coordinates: LON
   -n		Name. One word. Defaults to GeekWeather
   -d		Dark or Light output. Default: LIGHT
   -u      	Units: US is the default, or pick: US UK SI CA. Default: US [optional]
   -f      	Font: Set a font to use. Default: Helvetica [optional]
   -z 		Zoom: Defaults to 1. 2 will double the output image.
   -h      	Show this message and exit.
```

Example
-------
```sh
alex@Smiley:~/Developer/Scripts/GeekWeather2|master
⇒  ./geekWeather2.sh -A 40.410259 -O -74.035 -n AtlanticHighlands -d DARK -u SI -f Garamond -z 2
Converting to image
Fetching http://forecast.io/embed/#lat=40.410259&lon=-74.035&name=AtlanticHighlands&font=Garamond&units=SI ...
 ... done
Running image smoothing
```

GeekTool
--------

Run the script via LaunchD or via a script geeklet that returns no output. For LaunchD a plist is included.

* GeekWeather.plist

Drop that into ~/Library/LaunchAgents

Then, point an image geeklet at /tmp/GeekWeather.png

NB
__

Webkit2Png uses Python, and on OSX when it runs it'll put an icon in the dock. To suppress the Python icon follow these [steps].


License
----

MIT.


[GeekTool]:http://projects.tynsoe.org/en/geektool/
[DarkSky]:http://darksky.net/
[API]: https://developer.forecast.io/
[steps]:http://stackoverflow.com/questions/13865826/get-rid-of-the-python-launcher-icon-os-x
[Powered by DarkSky]:https://darksky.net/poweredby/

    
