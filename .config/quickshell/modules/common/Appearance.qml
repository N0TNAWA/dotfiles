import QtQuick
import Quickshell
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
  id: root
  property QtObject font
  property QtObject sizes
  property QtObject paddings

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
      property int massive: 26
      property int supermassive: 34
      property int extrememassive: 38
      property int title: huge
    }
  }

  sizes: QtObject {
    property int barHeight: 40
    property int menubarWidth: 450
    property int menubarHeight: 600

    property QtObject aiWindow: QtObject {
      property int menubarWidth: 450
      property int menubarHeight: 1000 
    }
  }

  paddings: QtObject {
    property int smallPad: 5
    property int mediumPad: 10
    property int bigPad: 20
    property int overflowPadding: 20
  }
}

