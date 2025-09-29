import QtQuick
import Quickshell
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
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

  StackView {
    id: stackView
    anchors.fill: parent
    initialItem: bar
  }

  Component {
    id: bar

    Rectangle {
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
          stack: stackView
          aiPage: aiChat
        }

        // Your row content goes here
      }

    }

  }

  Component {
    id: aiChat

    Rectangle {
      anchors.fill: parent
      color: Dat.Wal.color0
      radius: 10
      
      Chat {
        width: parent.width
        height: parent.height
        stack: stackView
        aiPage: aiChat
      } 

    }
  }
}

