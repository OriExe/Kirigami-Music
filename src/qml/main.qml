import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import oriexe.KirigamiMusicPLayer 1.0

Kirigami.ApplicationWindow {
    id: root

    title: qsTr("Kirigami Music player")

    minimumWidth: Kirigami.Units.gridUnit * 50
    minimumHeight: Kirigami.Units.gridUnit * 40
    width: minimumWidth
    height: minimumHeight

    pageStack.initialPage: initPage
    globalDrawer: Kirigami.GlobalDrawer {
        modal: false;
        collapsible: true;
        collapsed: false;
        actions: [
           Kirigami.Action {
               text: "Albums"
               icon.name: "media-optical-audio-symbolic"
           },
            Kirigami.Action {
               text: "Songs"
               icon.name: "library-music-symbolic"
           }
        ]
    }

    Component {
        id: initPage

        Kirigami.ScrollablePage {
            title: qsTr("Kirigami Music player")

            // Makes an album cover 
            function createAlbumCover() {
                        var component2 = Qt.createComponent("Sprite.qml");
                        var sprite = component2.createObject(albumRow);

                        if (sprite == null) {
                            // Error Handling
                            console.log("Error creating object");
                        }
                }
            ApiCalls {
                id: apicalls

                sourceText: sourceArea.text 
            }

            ColumnLayout {
                anchors.fill: parent
                Controls.Button {
                    text: qsTr("Send Api request")

                    onClicked: formattedText.text = apicalls.getAllAlbums()
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
