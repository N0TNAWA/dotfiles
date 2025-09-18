pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#151212"
   readonly property color color1: "#A6653F"
   readonly property color color2: "#967060"
   readonly property color color3: "#C58E73"
   readonly property color color4: "#7D7A86"
   readonly property color color5: "#A99B9F"
   readonly property color color6: "#D1B0A6"
   readonly property color color7: "#c4c3c3"
   readonly property color color8: "#6f5a5a"
   readonly property color color9: "#A6653F"
   readonly property color color10: "#967060"
   readonly property color color11: "#C58E73"
   readonly property color color12: "#7D7A86"
   readonly property color color13: "#A99B9F"
   readonly property color color14: "#D1B0A6"
   readonly property color color15: "#c4c3c3"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
