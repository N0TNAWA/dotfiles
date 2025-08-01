import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import qs.Data

Rectangle {
  id: profile

  implicitWidth: 100
  implicitHeight: 64
  radius: 5
  color: Wal.color9
  
  ColumnLayout {
    height: parent.height
    width: parent.width
    spacing: 10

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.margins: 6
      color: "transparent"

      Row {
        id: contentRow
        spacing: 15
        anchors.fill: parent

        Rectangle {
          width: 46
          height: 46
          radius: 1000
          color: Wal.color2
          clip: true
          layer.enabled: true
          layer.smooth: true

          Image {
            id: avatarImage
            anchors.fill: parent
            source: Settings.settings.profileImage 
            fillMode: Image.PreserveAspectCrop
            visible: false
            asynchronous: true
            cache: false
            sourceSize.width: 46
            sourceSize.height: 46
          }

          OpacityMask {
            anchors.fill: avatarImage
            source: avatarImage
            maskSource: Rectangle {
              width: avatarImage.width
              height: avatarImage.height
              radius: avatarImage.width / 2
              visible: false
            }
          }
        }
      }
    }

    Rectangle {
      Layout.fillWidth: true
      height: 2
      Layout.margins: 6
      radius: 5

      color: Wal.color2
    }

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.leftMargin: 10
      Layout.topMargin: 5
      Layout.bottomMargin: 15
      color: "transparent"

      ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter

        Text {
          text: " : " + Settings.settings.user
          color: Wal.color7
          font.pixelSize: 16
          font.family: Settings.settings.fontFam 
        }

        Text {
          text: "󱂬 : " + Quickshell.env("XDG_CURRENT_DESKTOP") || Quickshell.env("XDG_SESSION_DESKTOP")
          color: Wal.color7
          font.pixelSize: 16
          font.family: Settings.settings.fontFam 
        }

        Text {
          text: "󰥔 : " + SysInfo.uptimeText 
          color: Wal.color7
          font.pixelSize: 16
          font.family: Settings.settings.fontFam 
        }
      }
    }
  }
}
