pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property QtObject colors

  colors: QtObject {
     property color color0: "#111212"
     property color color1: "#90928F"
     property color color2: "#A2A29C"
     property color color3: "#B0B3AF"
     property color color4: "#BEBDB5"
     property color color5: "#C9C5B9"
     property color color6: "#BCC4C5"
     property color color7: "#dddfdd"
     property color color8: "#9a9c9a"
     property color color9: "#90928F"
     property color color10: "#A2A29C"
     property color color11: "#B0B3AF"
     property color color12: "#BEBDB5"
     property color color13: "#C9C5B9"
     property color color14: "#BCC4C5"
     property color color15: "#dddfdd"
  }
}
