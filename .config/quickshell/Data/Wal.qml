pragma Singleton
import Quickshell
import QtQuick 2.0

QtObject {
   readonly property color color0: "#111016"
   readonly property color color1: "#654847"
   readonly property color color2: "#90363B"
   readonly property color color3: "#913A45"
   readonly property color color4: "#A0514F"
   readonly property color color5: "#D3685B"
   readonly property color color6: "#E0956E"
   readonly property color color7: "#c3c3c4"
   readonly property color color8: "#5f5a6f"
   readonly property color color9: "#654847"
   readonly property color color10: "#90363B"
   readonly property color color11: "#913A45"
   readonly property color color12: "#A0514F"
   readonly property color color13: "#D3685B"
   readonly property color color14: "#E0956E"
   readonly property color color15: "#c3c3c4"

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
