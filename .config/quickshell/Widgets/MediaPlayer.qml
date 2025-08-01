import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import qs.Data

Rectangle {
  id: player

  implicitWidth: 100
  implicitHeight: 64

  color: "transparent"

  Rectangle {
    id: card
    anchors.fill: parent
    color: Wal.color9
    radius: 5

    Item {
      width: parent.width
      height: parent.height

      visible: !Media.currentPlayer

      ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        Text {
          text: ""
          font.family: Settings.settings.fontFam
          font.pixelSize: 96
          color:  Wal.color7
          Layout.alignment: Qt.AlignHCenter
        }

        Text {
          text: Media.hasPlayer ? "No music controller connected..." : "No music controller detected..."
          color: Wal.color7
          font.family: Settings.settings.fontFam
          font.pixelSize: 18
          Layout.alignment: Qt.AlignHCenter
        }
      }
    }

    Row {
      height: parent.height
      width: parent.height

      leftPadding: 35
      spacing: 10

      Rectangle {
        width: 128
        height: 128
        clip: true
        layer.enabled: true
        layer.smooth: true
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Image {
          id: artImage
          anchors.fill: parent
          source: Media.currentArtUrl 
          fillMode: Image.PreserveAspectCrop
          visible: false
          asynchronous: true
          cache: false
          sourceSize.width: 128
          sourceSize.height: 128
        }

        OpacityMask {
          anchors.fill: artImage
          source: artImage
          maskSource: Rectangle {
            width: artImage.width
            height: artImage.height
            radius: 15
            visible: false
          }
        }
      }

      ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        visible: Media.currentPlayer

        spacing: 10

        Text {
          text: Media.currentTrack
          color: Wal.color7

          Layout.alignment: Qt.AlignHCenter
          Layout.preferredWidth: 160
          Layout.maximumWidth: 160

          elide: Text.ElideRight
          wrapMode: Text.NoWrap
          horizontalAlignment: Text.AlignHCenter

          font.family: Settings.settings.fontFam
          font.pixelSize: 18

          
        }

        Text {
          text: Media.currentArtist
          color: Wal.color7

          Layout.alignment: Qt.AlignHCenter

          font.family: Settings.settings.fontFam
          font.pixelSize: 14
        }

        Rectangle {
          id: progressBarBackground
          width: 160
          height: 10
          radius: 3
          color: Wal.color2 
          Layout.alignment: Qt.AlignHCenter

          property real progressRatio: Math.min(1, Media.trackLength > 0 ? 
                                     (Media.currentPosition / Media.trackLength) : 0)

          Rectangle {
            id: progressFill
            width: progressBarBackground.progressRatio * parent.width
            height: parent.height
            radius: parent.radius
            color: Wal.color5

            Behavior on width {
              NumberAnimation { duration: 200 }
            }
          }

          // Interactive progress handle
          Rectangle {
            id: progressHandle
            width: 12
            height: 12
            radius: 6
            color: Wal.color5
            border.color: Wal.color5
            border.width: 1

            x: Math.max(0, Math.min(parent.width - width, progressFill.width - width/2))
            anchors.verticalCenter: parent.verticalCenter

            visible: Media.trackLength > 0
            scale: progressMouseArea.containsMouse || progressMouseArea.pressed ? 1.2 : 1.0

            Behavior on scale {
              NumberAnimation { duration: 150 }
            }
          }

          // Mouse area for seeking
          MouseArea {
            id: progressMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            enabled: Media.trackLength > 0 && Media.canSeek

            onClicked: function(mouse) {
              let ratio = mouse.x / width
              Media.seekByRatio(ratio)
            }

            onPositionChanged: function(mouse) {
              if (pressed) {
                let ratio = Math.max(0, Math.min(1, mouse.x / width))
                Media.seekByRatio(ratio)
              }
            }
          }
        }

        Rectangle {
          id: buttons
          Layout.alignment: Qt.AlignHCenter
          color: "transparent"  // or Wal.color3 if you want background
          width: 135
          height: 20  // adjust as needed

          Row {
            anchors.fill: parent

            spacing: 40

            Item {

              width: 20
              height: 20

              Text {
                text: Media.isPlaying ? "󰒮" : "󰒮"
                color: Wal.color7
                font.family: Settings.settings.fontFam
                font.pixelSize: 30
                anchors.centerIn: parent
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                enabled: Media.canGoPrevious
                onClicked: Media.previous()
              }
            }
            
            Item {

              width: 20
              height: 20

              Text {
                text: Media.isPlaying ? "" : ""
                color: Wal.color7
                font.family: Settings.settings.fontFam
                font.pixelSize: 20
                anchors.centerIn: parent

                scale: progressMouseArea.containsMouse || progressMouseArea.pressed ? 1.2 : 1.0

                Behavior on scale {
                  NumberAnimation { duration: 150 }
                }
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                enabled: Media.canPlay || Media.canPause
                onClicked: Media.playPause()
              }
            }

            Item {

              width: 20
              height: 20

              Text {
                text: Media.isPlaying ? "󰒭" : "󰒭"
                color: Wal.color7
                font.family: Settings.settings.fontFam
                font.pixelSize: 30
                anchors.centerIn: parent
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                enabled: Media.canGoNext
                onClicked: Media.next()
              }
            }
          }
        }
      }
    }
  }
}
