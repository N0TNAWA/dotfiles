import qs.modules.common
import qs.services
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  implicitWidth: rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight

  RowLayout {
    id: rowLayout
    anchors.centerIn: parent
    spacing: 4

    Item {
      implicitWidth: textItem.implicitWidth
      implicitHeight: textItem.implicitHeight

      Text {
        id: textItem
        font.pixelSize: Appearance.font.pixelSize.small
        font.family: Appearance.font.family.main
        color: Colors.colors.color6
        text: Updates.formatted
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Updates.installUpdates()
      }
    }
  }
}
