import QtQuick

Item {
    id: root

    property var node: null
    property string label: ""
    readonly property var audio: node ? node.audio : null
    readonly property real level: audio ? audio.volume : 0
    readonly property bool muted: audio ? audio.muted : false

    implicitHeight: 28

    // Mute button
    Rectangle {
        id: muteBtn
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 52
        height: 24
        radius: 4
        color: root.muted ? Theme.danger : Theme.surfaceHigh

        Text {
            anchors.centerIn: parent
            text: root.label
            font.pixelSize: Theme.fontSize
            color: root.muted ? Theme.base : Theme.text
        }

        MouseArea {
            anchors.fill: parent
            onClicked: if (root.audio) root.audio.muted = !root.audio.muted
        }
    }

    // Slider
    Item {
        id: track
        anchors.left: muteBtn.right
        anchors.leftMargin: 10
        anchors.right: pct.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        height: 20

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: 6
            radius: 3
            color: Theme.surfaceHigh

            Rectangle {
                width: parent.width * Math.min(1, root.level)
                height: parent.height
                radius: 3
                color: root.muted ? Theme.dim : Theme.accent
            }
        }

        MouseArea {
            anchors.fill: parent

            function setFromX(x) {
                if (root.audio)
                    root.audio.volume = Math.max(0, Math.min(1, x / width))
            }

            onPressed: mouse => setFromX(mouse.x)
            onPositionChanged: mouse => { if (pressed) setFromX(mouse.x) }
        }
    }

    // Percentage
    Text {
        id: pct
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: 40
        horizontalAlignment: Text.AlignRight
        text: Math.round(root.level * 100) + "%"
        font.pixelSize: Theme.fontSize
        color: Theme.text
    }
}
