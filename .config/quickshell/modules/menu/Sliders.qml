import qs
import qs.modules.common
import qs.modules.components
import qs.services
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell

Item {
  id: root

  ColumnLayout {
    anchors.fill: parent

    //Volume
    Rectangle {
      id: volume

      Layout.fillWidth: true
      Layout.fillHeight: true
      
      Layout.topMargin: 5
      Layout.leftMargin: 5
      Layout.rightMargin: 5

      color: "transparent"

      RowLayout {
        spacing: 5

        anchors.fill: parent

        Rectangle {
          id: volIcon

          Layout.preferredHeight: 35
          Layout.preferredWidth: 35

          color: "transparent"

          Text {
            anchors.centerIn: parent

            font.pixelSize: Appearance.font.pixelSize.massive
            font.family: Appearance.font.family.main

            color: Colors.colors.color5

            text: Volume.sinkMuted ? "" : ""
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Volume.toggleSinkMute()
          }
        }

        Rectangle {
          id: volumeSlider

          Layout.fillHeight: true
          Layout.fillWidth: true

          color: "transparent"

          StyledSlider {
            id: outputVol

            anchors.centerIn: parent

            implicitWidth: parent.width - 10
            grooveHeight: 25

            from: 0; to: 1; stepSize: 0.01
            value: Volume.sinkVolume
            onMoved: Volume.setSinkVolume(value)

            fillColor: Colors.colors.color5
            trackColor: Colors.colors.color2
            handleColor: Colors.colors.color5
          }
        }
      }
    }

    //Buttons

    Rectangle {
      id: buttons

      Layout.fillWidth: true
      Layout.fillHeight: true
      
      Layout.bottomMargin: 5
      Layout.leftMargin: 5
      Layout.rightMargin: 5

      color: "transparent"

      RowLayout {
        id: buttonRow

        anchors.fill: parent
        spacing: 5

        Repeater {
          model: ["bluetooth", "wifi", "volume", "wallpaper", "keybinds"]

          Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.topMargin: 5
            Layout.bottomMargin: 5

            radius: 50
            
            color: Colors.colors.color4
          }
        }
      }
    }
  }
}