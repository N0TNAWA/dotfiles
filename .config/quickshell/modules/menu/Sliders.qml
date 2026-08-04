import qs
import qs.modules.common
import qs.modules.components
import qs.services
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import Quickshell

Item {
  id: root

  property StackView stackView

  function openEntry(entry) {
    console.log(stackView)
    stackView.push("buttons/" + entry + ".qml")
    GlobalStates.quickAccessBusy = true

    console.log("quickAccess global status: ", GlobalStates.quickAccessBusy)
  }

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
          model: ["clip", "wifi", "vol", "wp", "kbs"]

          Rectangle {
            required property var modelData
            required property int index

            property var icons: ({
              clip: "",
              wifi: "",
              vol:  "",
              wp:   "",
              kbs:  "",
            })

            property var entries: ({
              clip: "clipboard",
              wifi: "wifi",
              vol:  "volume",
              wp:   "wallpapers",
              kbs:  "keybindings",
            })

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.topMargin: 5
            Layout.bottomMargin: 5
            
            color: "transparent"

            Rectangle {
              id: arrow

              implicitWidth: parent.width
              implicitHeight: parent.height

              color: Colors.colors.color5

              radius: 10

              border.color: Colors.colors.color1

              Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rightPadding: 4
                font.pixelSize: Appearance.font.pixelSize.smaller
                font.family: Appearance.font.family.main
                color: Colors.colors.color7
                text: ""
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.openEntry(entries[modelData])
              }
            }

            Rectangle {
              id: button

              width: arrow.implicitWidth / 1.25
              height: parent.height

              color: Colors.colors.color5

              bottomLeftRadius: 10
              topLeftRadius: 10

              border.color: Colors.colors.color1

              Text {
                anchors.centerIn: parent
                font.pixelSize: Appearance.font.pixelSize.small
                font.family: Appearance.font.family.main
                color: Colors.colors.color7
                text: icons[modelData] || "?"
              }
            }
          }
        }
      }
    }
  }
}
