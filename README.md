GeekWeather 2
=============

GeekWeather is a geeklet for [Geektool] that shows the [ForeCast] weather on your desktop. LIGHT is a lighter image for use on darker desktops, DARK is a darker image for use on lighter desktops. LAT and LON are the coordinates of the location you want the weather report for.

*Requirements*
  - WebKit2Png  ```brew install webkit2ping```
  - ImageMagick ```brew install imagemagick```

Version
----
2.0

Tech
-----------

GeekWeather uses:

* WebKit2Png: Converts the  webpage to a PNG
* ImageMagick: Image convertion

Script usage
--------------

```sh
$./geekWeather2.sh
Usage: geekWeather2.sh LAT LON NAME LIGHT/DARK
$./geekWeather2.sh 40.4118 74.0198 AtlHighlands LIGHT
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

Don't care.


[GeekTool]:http://projects.tynsoe.org/en/geektool/
[ForeCast]:http://forecast.io/
[steps]:http://stackoverflow.com/questions/13865826/get-rid-of-the-python-launcher-icon-os-x

    
