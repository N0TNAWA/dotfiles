pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property QtObject colors

  colors: QtObject {
     property color color0: "#12101a"
     property color color1: "#6E3843"
     property color color2: "#3F4359"
     property color color3: "#654D57"
     property color color4: "#A05252"
     property color color5: "#AF5553"
     property color color6: "#DD8C75"
     property color color7: "#c3c3c5"
     property color color8: "#5f5c70"
     property color color9: "#6E3843"
     property color color10: "#3F4359"
     property color color11: "#654D57"
     property color color12: "#A05252"
     property color color13: "#AF5553"
     property color color14: "#DD8C75"
     property color color15: "#c3c3c5"
  }
}
