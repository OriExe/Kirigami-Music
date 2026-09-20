import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
ColumnLayout 
{
    property var albumTextName: "Hello"
    property var imagePath: "https://demo.navidrome.org/rest/getCoverArt.view?id=al-0T2ybWQjvdxqwNOncne6N6_640a926e&u=demo&p=demo&v=1.13.0&c=AwesomeClientName&f=json"
    
    Layout.preferredWidth: 150
    Image {
        id: albumCover
        Layout.preferredWidth: 150
        Layout.preferredHeight : 150
        fillMode: Image.PreserveAspectFit
        source: imagePath
    }

    
    Text {
        id: albumText
        Layout.preferredWidth: 150
        text: albumTextName
        wrapMode: Text.WordWrap
        color: Kirigami.Theme.textColor
         horizontalAlignment: Text.AlignHCenter
    }
}
                    
