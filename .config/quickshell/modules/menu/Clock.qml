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

    Text {
      font.pixelSize: Appearance.font.pixelSize.supermassive * 2
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: DateTime.sliced
    }
  }
}
