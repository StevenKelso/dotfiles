import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    property var output: Pipewire.defaultAudioSink
    property var input: Pipewire.defaultAudioSource
    property var barWindow: QsWindow.window

    PwObjectTracker {
        objects: [root.output, root.input]
    }

    Row {
        id: row
        spacing: 12

        // Output (speakers/headphones)
        Text {
            font.pixelSize: Theme.fontSize
            color: Theme.text
            text: root.output && root.output.audio
                ? (root.output.audio.muted
                    ? "Vol muted"
                    : "Vol " + Math.round(root.output.audio.volume * 100) + "%")
                : "No output"
        }

        // Input (microphone)
        Text {
            font.pixelSize: Theme.fontSize
            color: Theme.text
            text: root.input && root.input.audio
                ? (root.input.audio.muted
                    ? "Mic muted"
                    : "Mic " + Math.round(root.input.audio.volume * 100) + "%")
                : "No mic"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: popup.visible = !popup.visible
    }

    PopupWindow {
        id: popup
        anchor.item: root
        anchor.edges: Edges.Bottom | Edges.Right
        anchor.gravity: Edges.Bottom | Edges.Left
        implicitWidth: 280
        implicitHeight: content.implicitHeight + 24
        color: Theme.surface

        PwObjectTracker {
            objects: Pipewire.nodes.values
        }

        Column {
            id: content
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 12
            spacing: 6

            // ---------- Output ----------
            Text {
                text: "Output"
                font.pixelSize: Theme.fontSize
                font.bold: true
                color: Theme.subtext
            }

            VolumeSlider {
                width: content.width
                node: root.output
                label: "Vol"
            }

            Repeater {
                model: Pipewire.nodes

                Rectangle {
                    id: entry
                    required property var modelData

                    // Hardware sinks only (skip app streams and sources)
                    visible: modelData.isSink && !modelData.isStream

                    width: content.width
                    height: 28
                    radius: 4
                    color: modelData === root.output ? Theme.accent : Theme.surfaceHigh

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 8
                        elide: Text.ElideRight
                        text: entry.modelData.description
                        font.pixelSize: Theme.fontSize
                        color: entry.modelData === root.output ? Theme.base : Theme.text
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Pipewire.preferredDefaultAudioSink = entry.modelData
                    }
                }
            }

            // ---------- Input ----------
            Text {
                text: "Input"
                font.pixelSize: Theme.fontSize
                font.bold: true
                color: Theme.subtext
                topPadding: 8
            }

            VolumeSlider {
                width: content.width
                node: root.input
                label: "Mic"
            }

            Repeater {
                model: Pipewire.nodes

                Rectangle {
                    id: inEntry
                    required property var modelData

                    // Audio sources only (skip app streams, sinks, and video devices)
                    visible: !modelData.isSink && !modelData.isStream && modelData.audio !== null

                    width: content.width
                    height: 28
                    radius: 4
                    color: modelData === root.input ? Theme.accent : Theme.surfaceHigh

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 8
                        elide: Text.ElideRight
                        text: inEntry.modelData.description
                        font.pixelSize: Theme.fontSize
                        color: inEntry.modelData === root.input ? Theme.base : Theme.text
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Pipewire.preferredDefaultAudioSource = inEntry.modelData
                    }
                }
            }
        }
    }

    HyprlandFocusGrab {
        windows: [popup, root.barWindow]
        active: popup.visible
        onCleared: popup.visible = false
    }
}
