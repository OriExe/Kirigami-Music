import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import oriexe.KirigamiMusicPLayer 1.0

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
    