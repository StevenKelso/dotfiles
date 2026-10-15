pragma Singleton
import QtQuick
import Quickshell

Singleton {
    // Colors
    readonly property color base: "#1e1e2e"        // bar background
    readonly property color surface: "#313244"     // popup background, idle workspace
    readonly property color surfaceHigh: "#45475a" // rows, buttons, slider track
    readonly property color text: "white"
    readonly property color subtext: "#a6adc8"     // popup headings
    readonly property color accent: "#89b4fa"      // focused, selected, slider fill
    readonly property color special: "#cba6f7"     // special workspace
    readonly property color danger: "#f38ba8"      // muted button
    readonly property color dim: "#6c7086"         // muted slider fill

    // Sizes
    readonly property int fontSize: 15
    readonly property int barHeight: 36
}
