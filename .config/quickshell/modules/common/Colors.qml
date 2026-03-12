pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property QtObject colors

  colors: QtObject {
     property color color0: "#140d0a"
     property color color1: "#A78A72"
     property color color2: "#C89A75"
     property color color3: "#B19F92"
     property color color4: "#CBB4A1"
     property color color5: "#BBC4BA"
     property color color6: "#D7C8B5"
     property color color7: "#e9e5e0"
     property color color8: "#a3a09c"
     property color color9: "#A78A72"
     property color color10: "#C89A75"
     property color color11: "#B19F92"
     property color color12: "#CBB4A1"
     property color color13: "#BBC4BA"
     property color color14: "#D7C8B5"
     property color color15: "#e9e5e0"
  }
}
