import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import qs.Data
import qs.Components

Rectangle {
  id: settings

  property StackView stack
  property Component btPage

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
      width: -5 + parent.width / 2
      height: 50
      radius: 5
      color: Wal.color1

      ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        anchors.margins: 5

        Text {
          text: Buttons.isDnd ? "" + "  Notifications" : "" + "  Notifications"
          font.family: Settings.settings.fontFam
          font.pixelSize: 16
          color: Wal.color7
          anchors.verticalCenter: parent.horizontalCenter

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Buttons.changeDnd()
          }
        }
      }
    }

    Rectangle {
      width: -5 + parent.width / 2
      height: 50
      radius: 5
      color: Wal.color1

      ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        anchors.margins: 5

        Text {
          text: "󰂯" + "  Bluetooth"
          font.family: Settings.settings.fontFam
          font.pixelSize: 16
          color: Wal.color7
          anchors.verticalCenter: parent.horizontalCenter

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: settings.stack.push(settings.btPage)
          }
        }
      }
    }
  }
}
