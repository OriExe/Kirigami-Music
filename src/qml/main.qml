import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import oriexe.KirigamiMusicPLayer 1.0
Kirigami.ApplicationWindow {
    id: root

    title: qsTr("Kirigami Music player")

    //minimumWidth: Kirigami.Units.gridUnit * 50
    //minimumHeight: Kirigami.Units.gridUnit * 40
    width: minimumWidth
    height: minimumHeight

    pageStack.initialPage: initPage
    pageStack.columnView.columnResizeMode: Kirigami.ColumnView.SingleColumn

    property bool albumSelected: true
    property bool songSelected: false

    function accessSongs()
    {
        albumSelected = false
        songSelected = true 
    }
    globalDrawer: Kirigami.GlobalDrawer {
        modal: false;
        collapsible: true;
        collapsed: false;
        actions: [
           Kirigami.Action {
                id: albumID
               text: "Albums"
               checked: albumSelected
               icon.name: "media-optical-audio-symbolic"
           },
            Kirigami.Action {
                id: songID
               text: "Songs"
               icon.name: "library-music-symbolic"
               checked: songSelected
               displayHint: Kirigami.DisplayHint.KeepVisible
               onTriggered: accessSongs()
           }
        ]
    }

    Component {
        id: initPage
        Kirigami.ScrollablePage {
            title: qsTr("Kirigami Music player")
            objectName: "albumPage"
            //Function to load album data
            function createSpriteObjects(name, imagePath) {
                var component = Qt.createComponent("Sprite.qml");
                var sprite = component.createObject(albumRow);
                sprite.albumTextName = name
                sprite.imagePath = imagePath
                if (sprite == null) {
                    // Error Handling
                    console.error("Error creating object");
                }
            }
            ApiCalls {
                id: apicalls
            }

            ColumnLayout {
                anchors.fill: parent
                Controls.Button {
                    text: qsTr("Send Api request")

                    onClicked: apicalls.getAllAlbums()
                }
                Controls.Button {
                    text: qsTr("Load Another Page")

                    onClicked: pageStack.push(Qt.resolvedUrl("songView.qml")) //Why does adding layers fix this
                }
                    
                Flow {
                    id: albumRow
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: Kirigami.Units.largeSpacing
                    }
                Text {
                    id: formattedText
                  
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.minimumHeight: Kirigami.Units.gridUnit * 5

                }
            }
           
    	}
    }
}
