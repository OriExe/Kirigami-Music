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

    pageStack.initialPage: AllAlbumsView {}
    pageStack.columnView.columnResizeMode: Kirigami.ColumnView.SingleColumn

    property bool albumSelected: true
    property bool songSelected: false

    function accessSongs()
    {
        albumSelected = false
        songSelected = true 
        pageStack.clear()
        pageStack.push(Qt.resolvedUrl("AllSongsView.qml"))
    }
    function accessAlbums()
    {
        albumSelected = true
        songSelected = false 
        pageStack.clear()
        pageStack.push(Qt.resolvedUrl("AllAlbumsView.qml"))
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
               onTriggered: accessAlbums()
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
}
