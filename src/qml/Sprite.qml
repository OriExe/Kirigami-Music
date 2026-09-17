import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
ColumnLayout 
{
    
    property var albumTextName: "Hello"
    property var imagePath: "https://demo.navidrome.org/rest/getCoverArt.view?id=al-0T2ybWQjvdxqwNOncne6N6_640a926e&u=demo&p=demo&v=1.13.0&c=AwesomeClientName&f=json"
    spacing: 2
    Item {
    width: 150
    height: 150

    Rectangle {
        anchors.fill: parent
    }
    Image {
        id: albumCover
        source: imagePath
        width: 150
        height: 150
    }

    }
    Text {
        id: albumText
        Layout.alignment: Qt.AlignCenter
        text: albumTextName
    }
}
                    
