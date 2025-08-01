import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Data

Rectangle {
  implicitWidth: 100
  implicitHeight: 64

  radius: 5
  color: Wal.color9

  ColumnLayout {
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 10
    anchors.margins: 5

    Text {
      text: "⏻"
      font.family: Settings.settings.fontFam
      font.pixelSize: 20
      color: Wal.color7
      anchors.verticalCenter: parent.horizontalCenter

      MouseArea {
        anchors.fill: parent
        onClicked: SysInfo.poweroff()
      }
    }

    Text {
      text: ""
      font.family: Settings.settings.fontFam
      font.pixelSize: 20
      color: Wal.color7
      anchors.verticalCenter: parent.horizontalCenter

      MouseArea {
        anchors.fill: parent
        onClicked: SysInfo.reboot()
      }
    }

    Text {
      text: "󰤄"
      font.family: Settings.settings.fontFam
      font.pixelSize: 20
      color: Wal.color7
      anchors.verticalCenter: parent.horizontalCenter


      MouseArea {
        anchors.fill: parent
        onClicked: SysInfo.hibernate()
      }
    }

    Text {
      text: "󰍃"
      font.family: Settings.settings.fontFam
      font.pixelSize: 20
      color: Wal.color7
      anchors.verticalCenter: parent.horizontalCenter


      MouseArea {
        anchors.fill: parent
        onClicked: SysInfo.logout()
      }
    } 
  }
}
