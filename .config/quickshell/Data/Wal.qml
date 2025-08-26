pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#100f0d"
   readonly property color color1: "#8A2E1C"
   readonly property color color2: "#903623"
   readonly property color color3: "#A06A2F"
   readonly property color color4: "#B86A40"
   readonly property color color5: "#728963"
   readonly property color color6: "#A79263"
   readonly property color color7: "#c3c3c2"
   readonly property color color8: "#6b6b58"
   readonly property color color9: "#8A2E1C"
   readonly property color color10: "#903623"
   readonly property color color11: "#A06A2F"
   readonly property color color12: "#B86A40"
   readonly property color color13: "#728963"
   readonly property color color14: "#A79263"
   readonly property color color15: "#c3c3c2"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
