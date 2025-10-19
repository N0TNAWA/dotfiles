pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#1a2122"
   readonly property color color1: "#5B5E57"
   readonly property color color2: "#546A6F"
   readonly property color color3: "#6B7377"
   readonly property color color4: "#927361"
   readonly property color color5: "#5C7681"
   readonly property color color6: "#747C83"
   readonly property color color7: "#c5c7c7"
   readonly property color color8: "#617377"
   readonly property color color9: "#5B5E57"
   readonly property color color10: "#546A6F"
   readonly property color color11: "#6B7377"
   readonly property color color12: "#927361"
   readonly property color color13: "#5C7681"
   readonly property color color14: "#747C83"
   readonly property color color15: "#c5c7c7"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
