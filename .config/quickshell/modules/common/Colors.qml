pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property QtObject colors

  colors: QtObject {
     property color color0: "#0C1617"
     property color color1: "#0C494D"
     property color color2: "#2F584F"
     property color color3: "#5B6D51"
     property color color4: "#967137"
     property color color5: "#947545"
     property color color6: "#788441"
     property color color7: "#c8c192"
     property color color8: "#8c8766"
     property color color9: "#0C494D"
     property color color10: "#2F584F"
     property color color11: "#5B6D51"
     property color color12: "#967137"
     property color color13: "#947545"
     property color color14: "#788441"
     property color color15: "#c8c192"
  }
}
