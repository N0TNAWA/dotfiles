pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#1d1e25"
   readonly property color color1: "#605868"
   readonly property color color2: "#A53A53"
   readonly property color color3: "#9A5B5C"
   readonly property color color4: "#DA6A65"
   readonly property color color5: "#EC9674"
   readonly property color color6: "#997489"
   readonly property color color7: "#c6c6c8"
   readonly property color color8: "#636379"
   readonly property color color9: "#605868"
   readonly property color color10: "#A53A53"
   readonly property color color11: "#9A5B5C"
   readonly property color color12: "#DA6A65"
   readonly property color color13: "#EC9674"
   readonly property color color14: "#997489"
   readonly property color color15: "#c6c6c8"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
