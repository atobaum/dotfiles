#! /usr/bin/python3

import sys
import datetime
import requests

filePath = sys.argv[1]

res = requests.get("https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US")
imgUrl = res.json()['images'][0]['url']
imgUrl = imgUrl.split('&')[0]
fullImgUrl = "https://www.bing.com"+imgUrl

imgData = requests.get(fullImgUrl).content
with open(filePath, 'wb') as f:
    f.write(imgData)
