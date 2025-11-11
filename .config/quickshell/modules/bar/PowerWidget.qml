import qs
import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
  id: root
  implicitWidth: rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight

  RowLayout {
    id: rowLayout
    anchors.centerIn: parent
    spacing: 10
    
    Item {
      implicitWidth: menuButton.implicitWidth
      implicitHeight: menuButton.implicitHeight

      Text {
        id: menuButton
        font.pixelSize: Appearance.font.pixelSize.small
        font.family: Appearance.font.family.main
        color: Colors.colors.color5
        text: "󰣇" 
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Config.options.bar.power.togglePowerOptions = !Config.options.bar.power.togglePowerOptions
      }
    }
  }
}
