pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property QtObject colors

  colors: QtObject {
     property color color0: "#121111"
     property color color1: "#78827A"
     property color color2: "#968C72"
     property color color3: "#C6AB6A"
     property color color4: "#B0A58A"
     property color color5: "#DDCFAB"
     property color color6: "#E2D5B0"
     property color color7: "#c3c3c3"
     property color color8: "#6e5959"
     property color color9: "#78827A"
     property color color10: "#968C72"
     property color color11: "#C6AB6A"
     property color color12: "#B0A58A"
     property color color13: "#DDCFAB"
     property color color14: "#E2D5B0"
     property color color15: "#c3c3c3"
  }
}
