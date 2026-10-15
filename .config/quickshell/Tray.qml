import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Row {
    spacing: 8

    Repeater {
        model: SystemTray.items

        MouseArea {
            id: item
            required property var modelData

            width: 18
            height: 18
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            function openMenu() {
                const pos = item.mapToItem(null, 0, item.height)
                item.modelData.display(QsWindow.window, pos.x, pos.y)
            }

            onClicked: mouse => {
                if (mouse.button === Qt.MiddleButton) {
                    item.modelData.secondaryActivate()
                } else if (mouse.button === Qt.RightButton || item.modelData.onlyMenu) {
                    if (item.modelData.hasMenu) openMenu()
                } else {
                    item.modelData.activate()
                    if (item.modelData.hasMenu) openMenu()
                }
            }

            IconImage {
                anchors.fill: parent
                source: item.modelData.icon
            }
        }
    }
}
