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


License
----

MIT


**Free Software, Hell Yeah!**

[GeekTool]:http://projects.tynsoe.org/en/geektool/t/
[ForeCast]:http://forecast.io/


    