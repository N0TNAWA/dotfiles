import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import qs.Data
import qs.Components

Rectangle {
  id: settings

  implicitWidth: 100
  implicitHeight: 64
  radius: 5
  color: Wal.color0

  Flow {
    id: widgetFlow
    spacing: 10
    anchors.fill: parent
    anchors.margins: 10
    flow: Flow.LeftToRight
    
    Rectangle {
      width: 100
      height: 50
      radius: 5
      color: Wal.color1

      ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        anchors.margins: 5

        Text {
          //text: "DND  " + (Buttons ? Buttons.currentDnd : "...")
          font.family: Settings.settings.fontFam
          font.pixelSize: 15
          color: Wal.color7
          anchors.verticalCenter: parent.horizontalCenter

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            //onClicked: Buttons.changeDnd()
          }
        }
      }
    }
  }
}
