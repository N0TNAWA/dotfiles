pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#151014"
   readonly property color color1: "#976D67"
   readonly property color color2: "#B48477"
   readonly property color color3: "#DD9575"
   readonly property color color4: "#FDC277"
   readonly property color color5: "#B79489"
   readonly property color color6: "#DFAB90"
   readonly property color color7: "#c4c3c4"
   readonly property color color8: "#6e5a6e"
   readonly property color color9: "#976D67"
   readonly property color color10: "#B48477"
   readonly property color color11: "#DD9575"
   readonly property color color12: "#FDC277"
   readonly property color color13: "#B79489"
   readonly property color color14: "#DFAB90"
   readonly property color color15: "#c4c3c4"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
