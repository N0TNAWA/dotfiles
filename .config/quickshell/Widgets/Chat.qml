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
      spacing: 10

      Rectangle {
        id: backButton
        Layout.fillWidth: true
        Layout.preferredHeight: 20
        radius: 5
        color: Wal.color0

        Text {
          text: "Back"
          font.family: Settings.settings.fontFam
          font.pixelSize: 16
          color: Wal.color7
        }

        MouseArea {
          anchors.fill: parent 
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: chat.stack.pop()
          focus: false
        }
      }

      Rectangle {
        id: chatContainer
        Layout.fillWidth: true
        Layout.fillHeight: true
        radius: 5
        color: Wal.color3
      }

      Rectangle {
        id: textArea
        Layout.fillWidth: true
        Layout.preferredHeight: 64
        radius: 5
        color: Wal.color3
        z: 2

        FocusScope {
          anchors.fill: parent

          TextArea {
            id: inputField
            anchors.fill: parent
            anchors.margins: 8
            font.family: Settings.settings.fontFam
            font.pixelSize: 16
            color: Wal.color7
            placeholderText: "Type your message..."
            wrapMode: Text.Wrap
            activeFocusOnPress: true  
            focus: false 
          }
        }
      }
    }
  }
}

