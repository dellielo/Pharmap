extension = {
    "geo":[
        "shp",
         "geojson"],
    "tab":[
        "csv", "json"]
}

dataDir = './data/dataset'
testDir = './data/test'

taxonomyDir = "./data/obis"
taxonomyFile = "porifera_obis_light.csv"

methodList = ['offset', 'nearest', "meanNearest"]
method = "nearest"

offset = {
    "offset": {
        "lat": 1,
        "lon": 1,
        "depth": 100
    },
    "nearest": {
        "lat": 5,
        "lon": 5,
        "depth": 1000
    },
    "meanNearest": {
        "lat": 5,
        "lon": 5,
        "depth": 1000
    },
}
tempDepthOffset = 100

tempLatitudeOffset = 1
tempLongitudeOffset = 1