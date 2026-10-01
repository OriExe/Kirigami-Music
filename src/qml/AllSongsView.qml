import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
Kirigami.ScrollablePage {
    objectName: "songPage"
    property var albumName: "All Songs"
    property var albumList: []
    property var songImages: []
    property var integerLength: 0
    title: albumName
        
    function pushArrayValues(albumNAME,songName, songImage){
        console.error(albumName)
        console.error(songImage)
        albumName = albumNAME
        albumList.push(songName)
        songImages.push(songImage)
        integerLength = albumList.length
    }
    Kirigami.CardsListView {
        id: view
        model: integerLength

        delegate: Kirigami.AbstractCard {
            //NOTE: never put a Layout as contentItem as it will cause binding loops
            contentItem: Item {
                implicitWidth: delegateLayout.implicitWidth
                implicitHeight: delegateLayout.implicitHeight
                GridLayout {
                    id: delegateLayout
                    anchors {
                        left: parent.left
                        top: parent.top
                        right: parent.right
                        //IMPORTANT: never put the bottom margin
                    }
                    rowSpacing: Kirigami.Units.largeSpacing
                    columnSpacing: Kirigami.Units.largeSpacing
                    columns: width > Kirigami.Units.gridUnit * 20 ? 4 : 2
                    Kirigami.Icon {
                        source: songImages[modelData]
                        Layout.fillHeight: true
                        Layout.maximumHeight: Kirigami.Units.iconSizes.huge
                        Layout.preferredWidth: height
                    }
                    Kirigami.Heading {
                        level: 2
                        text: albumList[modelData]
                    }
                    Controls.Button {
                        Layout.alignment: Qt.AlignRight
                        Layout.columnSpan: 2 
                        text: qsTr("Install")
                    }
                }
            }
        }
}
}
