import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
Kirigami.ScrollablePage {
    title: "All Songs"
        Controls.Button {
            anchors.centerIn: parent
            text: "Pop!"
            onClicked: pageStack.pop()
}
}