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
  
  Rectangle {
    id: volumeBackground
    width: parent.width
    height: 50
    radius: 3
    color: Wal.color0

    ColumnLayout {
      id: controller
      width: parent.width
      height: parent.height
      
      Rectangle {
        id: volumeHeader
        Layout.fillWidth: true
        Layout.preferredHeight: 35  
        color: Wal.color0

        ColumnLayout {
          width: parent.width
          height: parent.height
          anchors.margins: 1
          spacing: 1

          Text {
            text: "Volume"
            color: Wal.color3
            font.family: Settings.settings.fontFam
            font.pixelSize: 16
            Layout.margins: 2
          }

          Rectangle {
            Layout.fillWidth: true
            height: 2
            Layout.margins: 2
            radius: 5

            color: Wal.color2
          }
        }
      }

      Rectangle {
        id: primaryOutput
        Layout.fillWidth: true
        Layout.preferredHeight: 50  
        color: Wal.color0

        RowLayout {
          id: outputRow
          visible: Pipewire.ready && audio.defaultOutput
          anchors.fill: parent   
          anchors.margins: 8
          spacing: 10

          Item {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20

            width: 20; height: 20    
            Text {
              anchors.centerIn: parent
              text: Volume.sinkMuted ? "󰖁" : "󰕾"
              color: Wal.color7
              font.family: Settings.settings.fontFam
              font.pixelSize: 20
            }
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onClicked: Volume.toggleSinkMute()
            }
          }

          StyledSlider {
            id: outputVol
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true 

            from: 0; to: 1; stepSize: 0.01
            value: Volume.sinkVolume
            onMoved: Volume.setSinkVolume(value)

            fillColor: Wal.color5
            trackColor: Wal.color2
            handleColor: Wal.color5
          }

          Text {
            Layout.alignment: Qt.AlignVCenter
            text: Math.round(Volume.sinkVolume * 100) + "%"
            color: Wal.color7
            font.family: Settings.settings.fontFam
            font.pixelSize: 16
          }
        }
      }

      Rectangle {
        id: primaryInput
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        color: Wal.color0

        RowLayout {
          id: inputRow
          visible: Pipewire.ready && audio.defaultInput
          anchors.fill: parent        
          anchors.margins: 8
          spacing: 10

          Item {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20

            width: 20; height: 20     
            Text {
              anchors.centerIn: parent
              text: Volume.sourceMuted ? "󰍭" : "󰍬"
              color: Wal.color7
              font.family: Settings.settings.fontFam
              font.pixelSize: 20
            }
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onClicked: Volume.toggleSourceMute()
            }
          }

          StyledSlider {
            id: inputVol
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true 

            from: 0; to: 1; stepSize: 0.01
            value: Volume.sourceVolume
            onMoved: Volume.setSourceVolume(value)

            fillColor: Wal.color5
            trackColor: Wal.color2
            handleColor: Wal.color5
          }
          
          Text {
            Layout.alignment: Qt.AlignVCenter
            text: Math.round(Volume.sourceVolume * 100) + "%"
            color: Wal.color7
            font.family: Settings.settings.fontFam
            font.pixelSize: 16
          }
        } 
      }
    }
  }
}
