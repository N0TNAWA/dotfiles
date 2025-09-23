pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#121111"
   readonly property color color1: "#78827A"
   readonly property color color2: "#968C72"
   readonly property color color3: "#C6AB6A"
   readonly property color color4: "#B0A58A"
   readonly property color color5: "#DDCFAB"
   readonly property color color6: "#E2D5B0"
   readonly property color color7: "#c3c3c3"
   readonly property color color8: "#6e5959"
   readonly property color color9: "#78827A"
   readonly property color color10: "#968C72"
   readonly property color color11: "#C6AB6A"
   readonly property color color12: "#B0A58A"
   readonly property color color13: "#DDCFAB"
   readonly property color color14: "#E2D5B0"
   readonly property color color15: "#c3c3c3"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
