from PySide6.QtCore import QObject, Signal, Slot, Property
from PySide6.QtQml import QmlElement, QQmlComponent
import requests
import json
import globalValues


QML_IMPORT_NAME = "oriexe.KirigamiMusicPLayer"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class ApiCalls(QObject):
    
    hostserver = "https://demo.navidrome.org"
    username = "demo"
    password = "demo"
    CLIENT = "KirigamiMusic"
    """Calls the opensonic api"""


    @Slot(result=str)
    def getAllAlbums(self):
        url = f"{self.hostserver}/rest/getAlbumList.view?type=alphabeticalByName&u={self.username}&p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
        response = requests.get(url)
        print(response)
        if response.status_code == 200:
            #print(response.json()["subsonic-response"]["albumList"]["album"][0]["name"])
            window = globalValues.engine.rootObjects()[0]
            albumPageFunction = window.findChild(QObject, "albumPage")
            jsonResponse = response.json()
            ##Get album name and Image
            for x in jsonResponse["subsonic-response"]["albumList"]["album"]:
                imageUrl = f"{self.hostserver}/rest/getCoverArt.view?id={x["coverArt"]}&u={self.username}&p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
                print(imageUrl)
                albumPageFunction.createSpriteObjects(x["name"], imageUrl)
            return json.dumps(response.json())
        else:
            print("Failed to retrieve data",response.status_code)
            return json.dumps(response.status_code)