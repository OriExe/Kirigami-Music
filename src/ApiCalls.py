from PySide6.QtCore import QObject, Signal, Slot, Property
from PySide6.QtQml import QmlElement, QQmlComponent
from io import BytesIO
import requests
import urllib.request
import json
import globalValues
import os

QML_IMPORT_NAME = "oriexe.KirigamiMusicPLayer"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class ApiCalls(QObject):
    
    hostserver = "https://demo.navidrome.org"
    username = "demo"
    password = "demo"
    CLIENT = "KirigamiMusic"
    """Calls the opensonic api"""
    cachePath = ""
    
    ##Called from album View qml
    @Slot()
    def main(self):
        print(self.cachePath)
        ##Set and make the cache path for the app
        if self.cachePath == "":
            self.cachePath = os.getenv("XDG_CACHE_HOME") or os.path.join(os.getenv("HOME"),".cache")
            self.cachePath = os.path.join(self.cachePath,"oriexe-Kirigami")
            print(self.cachePath)
        if not os.path.exists(self.cachePath):
            print("Cache path created")
            os.makedirs(self.cachePath)
        print("Cache variables set")
    
    @Slot(result=str)
    def getAllAlbums(self):
        url = f"{self.hostserver}/rest/getAlbumList.view?type=alphabeticalByName&u={self.username}&p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
        response = requests.get(url)
        ##Get Albums from api
        if response.status_code == 200:
            #print(response.json()["subsonic-response"]["albumList"]["album"][0]["name"])
            window = globalValues.engine.rootObjects()[0]
            albumPageFunction = window.findChild(QObject, "albumPage")
            jsonResponse = response.json() ##Turn into json
            ##Get album name and Image
            for x in jsonResponse["subsonic-response"]["albumList"]["album"]:
                imageUrl = f"{self.hostserver}/rest/getCoverArt.view?id={x["coverArt"]}&u={self.username}&p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
                imagePath = ""
                if not os.path.exists(self.cachePath + "/" + x["coverArt"] + ".png"):
                    print("Image doesn't exist creating it")
                    imagePath = self.saveToCache(x["name"],x["coverArt"] ,imageUrl)
                else:
                    imagePath = self.cachePath + "/" + x["coverArt"] + ".png"
                #print(imageUrl)
                albumPageFunction.createAlbumObjects(x["name"], imagePath)
            return json.dumps(response.json())
        ##Run fails
        else:
            print("Failed to retrieve data",response.status_code)
            return json.dumps(response.status_code)
        
    #Gets the image online and saves it in the cache
    def saveToCache(self, name, albumID, albumLink):
        filePath = self.cachePath + "/" + albumID + ".png" #File path for each image
        print(filePath)
        r = requests.get(albumLink).content
        image = bytes(r)
        file = open(filePath,"wb")
        file.write(image)
        return filePath
            