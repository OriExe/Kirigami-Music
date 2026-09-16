import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.AbstractCard {
                Layout.fillHeight: true

                header: Kirigami.Heading {
                    text: qsTr("AbstractCard")
                    level: 2
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "This is a card which shows how cool it looks"
                }
            }