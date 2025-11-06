import QtQuick
import Quickshell
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
  id: root
  property QtObject font

  font: QtObject {
    property QtObject family: QtObject {
        property string main: "CaskaydiaMono Nerd font"
    }
    property QtObject pixelSize: QtObject {
        property int smallest: 10
        property int smaller: 12
        property int small: 15
        property int normal: 16
        property int large: 17
        property int larger: 19
        property int huge: 22
        property int hugeass: 23
        property int title: huge
    }
  }
}

