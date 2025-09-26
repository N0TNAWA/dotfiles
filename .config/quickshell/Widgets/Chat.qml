import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import qs.Data
import qs.Components

Rectangle {
  id: chat

  property StackView stack
  property Component aiPage

  implicitWidth: 100
  implicitHeight: 64
  radius: 5
  color: Wal.color0

  Rectangle {
    id: chatFrame
    anchors.fill: parent
    anchors.margins: 10
    color: Wal.color0
    radius: 5

    ColumnLayout {
      anchors.fill: parent

      Rectangle {
        id: backButton
        width: 100
        height: 50
        radius: 5
        color: Wal.color1
        anchors.margins: 10

        ColumnLayout {
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
          spacing: 10
          anchors.margins: 5

          Text {
            text: "Back" 
            font.family: Settings.settings.fontFam
            font.pixelSize: 16
            color: Wal.color7

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onClicked: chat.stack.pop() 
            }
          }
        }
      }

      Rectangle {
        id: chatContainer
      }


    }
  } 
}
