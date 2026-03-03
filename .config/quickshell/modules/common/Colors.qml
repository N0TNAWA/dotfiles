pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property QtObject colors

  colors: QtObject {
     property color color0: "#0d0e12"
     property color color1: "#334B56"
     property color color2: "#114B62"
     property color color3: "#4E4F53"
     property color color4: "#625B59"
     property color color5: "#A05839"
     property color color6: "#98634D"
     property color color7: "#d6bfae"
     property color color8: "#958579"
     property color color9: "#334B56"
     property color color10: "#114B62"
     property color color11: "#4E4F53"
     property color color12: "#625B59"
     property color color13: "#A05839"
     property color color14: "#98634D"
     property color color15: "#d6bfae"
  }
}
