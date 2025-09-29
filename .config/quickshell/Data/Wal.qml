pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#181b23"
   readonly property color color1: "#635e60"
   readonly property color color2: "#5c6268"
   readonly property color color3: "#6c6b6b"
   readonly property color color4: "#787375"
   readonly property color color5: "#818284"
   readonly property color color6: "#8a8d94"
   readonly property color color7: "#94969e"
   readonly property color color8: "#616676"
   readonly property color color9: "#847E81"
   readonly property color color10: "#7B838B"
   readonly property color color11: "#908F8F"
   readonly property color color12: "#A09A9C"
   readonly property color color13: "#ADAEB1"
   readonly property color color14: "#B8BDC6"
   readonly property color color15: "#c5c6c8"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
