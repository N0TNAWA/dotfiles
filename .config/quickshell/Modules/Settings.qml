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
    right: true
    bottom: true

  }
  
  implicitWidth: 400
  implicitHeight: 100

  margins {
    top: 10
    left: 0
    right: 10
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

      Volume {
        width: parent.width
        height: 150
      }

      PrefButtons {
        width: parent.width
        height: 100
      }

      // Your row content goes here
    }

  }
      
}

