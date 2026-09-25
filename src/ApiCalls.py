from PySide6.QtCore import QObject, Signal, Slot, Property
from PySide6.QtQml import QmlElement, QQmlComponent
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
    
    @Slot(result=str)
    def getAllAlbums(self):
        url = f"{self.hostserver}/rest/getAlbumList.view?type=alphabeticalByName&u={self.username}&p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
        response = requests.get(url)
        ##Run sucessfully 
        if response.status_code == 200:
            #print(response.json()["subsonic-response"]["albumList"]["album"][0]["name"])
            window = globalValues.engine.rootObjects()[0]
            albumPageFunction = window.findChild(QObject, "albumPage")
            jsonResponse = response.json() ##Turn into json
            ##Get album name and Image
            for x in jsonResponse["subsonic-response"]["albumList"]["album"]:
                imageUrl = f"{self.hostserver}/rest/getCoverArt.view?id={x["coverArt"]}&u={self.username}&p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
                print(imageUrl)
                albumPageFunction.createSpriteObjects(x["name"], self.saveToCache(x["name"],x["coverArt"] ,imageUrl))
            return json.dumps(response.json())
        ##Run fails
        else:
            print("Failed to retrieve data",response.status_code)
            return json.dumps(response.status_code)
        
    def saveToCache(self, name, albumID, albumLink):
        if self.cachePath == "":
            self.cachePath = os.getenv("XDG_CACHE_HOME") or os.path.join(os.getenv("HOME"),".cache")
            self.cachePath = self.cachePath + "/oriexe.Kirigami"
        print(albumLink)
        return 
        filePath = self.cachePath + albumID + ".png"
        urllib.request.urlretrieve(albumLink,filePath)
            
        return filePath
            