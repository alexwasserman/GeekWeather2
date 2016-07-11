#!/usr/bin/python
import sys


def cityinfo(lat, lon):
    from geopy.geocoders import GoogleV3
    locator = GoogleV3()
    address = locator.reverse([lat, lon])
    city = address[3].address.split(",")[0]
    print(city.replace(" ", ""))
    return


cityinfo(sys.argv[1], sys.argv[2])
