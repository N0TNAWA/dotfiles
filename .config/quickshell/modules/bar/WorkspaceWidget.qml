import qs
import qs.modules.common
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
  id: root
  implicitWidth: rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight

  RowLayout {
    id: rowLayout
    spacing: 5

    Repeater {
      model: Hyprland.workspaces
      
      Item {
        width: 25
        height: 15

        Rectangle {
          id: workspaceIndicator
          anchors.centerIn: parent
          width: modelData.active ? 25 : 15
          height: 15
          radius: 100
          color: modelData.active ? Colors.colors.color5 : Colors.colors.color4

          Behavior on width {
            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
          }

          Behavior on color {
            ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: Hyprland.dispatch(`workspace ${modelData.id}`)
          }
        }
      }
    }
  }
}

