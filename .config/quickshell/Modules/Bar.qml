import QtQuick
import Quickshell
import Quickshell.Hyprland
import QtQuick.Layouts
import "../Data/" as Dat
import "../Widgets"

PanelWindow {
  id: panel
  
  property bool enableDock: true

  anchors {
    top: true
    left: true
    bottom: true

  }
  
  implicitWidth: 400
  implicitHeight: 100

  margins {
    top: 10
    left: 10
    right: 0
    bottom: 10
  }

  color: "transparent"

  Rectangle {
    id: bar
    anchors.fill: parent
    color: Dat.Wal.color0
    radius: 10
    
    Flow {
      id: widgetFlow
      spacing: 10
      anchors.fill: parent
      anchors.margins: 10
      flow: Flow.LeftToRight

      Profile {
        width: parent.width - 65
        height: 150
      }

      Power {
        width: parent.width - 325
        height: 150
      }

      MediaPlayer {
        width: parent.width
        height: 200
      }

      NotificationArea {
        width: parent.width
        height: implicitHeight
      }
        // Your row content goes here
    }

  }
      
}

