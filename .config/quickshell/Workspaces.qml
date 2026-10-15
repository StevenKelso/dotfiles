import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            id: box
            required property var modelData

            width: 28
            height: 24
            radius: 4
            color: modelData.focused
            ? (modelData.id < 0 ? Theme.special : Theme.accent)
            : Theme.surface

            Text {
                anchors.centerIn: parent
                text: box.modelData.id < 0 ? "★" : box.modelData.id
                font.pixelSize: Theme.fontSize
                color: box.modelData.focused ? Theme.base : Theme.text
            }

            // ...MouseArea stays here...
            MouseArea {
                anchors.fill: parent
                onClicked: box.modelData.activate()
            }
        }
    }
}
