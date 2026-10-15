import QtQuick

Text {
    id: root

    property string format: "ddd d MMM  HH:mm"
    property date now: new Date()

    font.pixelSize: Theme.fontSize
    color: Theme.text
    text: Qt.formatDateTime(now, format)

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }
}
