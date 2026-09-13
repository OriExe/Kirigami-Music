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

        Kirigami.Page {
            title: qsTr("Kirigami Music player")

            ApiCalls {
                id: apicalls

                sourceText: sourceArea.text 
            }

            ColumnLayout {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                RowLayout {
                    Layout.fillWidth: true

                    Controls.Button {
                        text: qsTr("Send Api request")

                        onClicked: formattedText.text = apicalls.getAllSongs()
                    }
                } 

                Text {
                    id: formattedText

                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    text: sourceArea.text
                    color: "white"

                    Layout.fillWidth: true
                    Layout.minimumHeight: Kirigami.Units.gridUnit * 5
                }
            }
    	}
    }
}
