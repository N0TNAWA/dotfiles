import qs.services
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
    anchors.centerIn: parent
    spacing: 4

    Text {
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: ""
    }

    Text {
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: HyprData.focusedWindow
    }
  }
}
