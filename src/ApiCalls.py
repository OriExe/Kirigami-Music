from PySide6.QtCore import QObject, Signal, Slot, Property
from PySide6.QtQml import QmlElement
import requests
import json

QML_IMPORT_NAME = "oriexe.KirigamiMusicPLayer"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class ApiCalls(QObject):
    
    hostserver = "https://demo.navidrome.org"
    username = "demo"
    password = "demo"
    CLIENT = "KirigamiMusic"
    """Calls the opensonic api"""

    sourceTextChanged = Signal()

    def __init__(self, _source_text=""):
        super().__init__()
        self._source_text = _source_text

    @Property(str, notify=sourceTextChanged)
    def sourceText(self):
        return self._source_text

    @sourceText.setter
    def sourceText(self, val):
        self._source_text = val
        self.sourceTextChanged.emit()
        
    @Slot(result=str)
    def getAllAlbums(self):
        url = f"{self.hostserver}/rest/getAlbumList.view?type=alphabeticalByName&u={self.username}&p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
        response = requests.get(url)
        print(response)
        if response.status_code == 200:
            apidata = response.json()
            return json.dumps(apidata)
        else:
            print("Failed to retrieve data",response.status_code)
            return json.dumps(response.status_code)
        
    def getImageOfAlbum(self, imageId):
        url = f"{self.hostserver}/rest/getCoverArt.view?id={imageId}&u={self.username}p={self.password}&v=1.16.1.0&c={self.CLIENT}&f=json"
        