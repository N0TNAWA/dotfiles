import qs.modules.common
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  property real padding: 10
  implicitHeight: Config.options.bar.barHeight
  height: Config.options.bar.barHeight
  implicitWidth: rowLayout.implicitWidth + padding * 2
  default property alias items: rowLayout.children

  Rectangle {
    id: background

    anchors {
      fill: parent
      topMargin: 7
      bottomMargin: 7
      leftMargin: 0
      rightMargin: 0
    }

    radius: 6
    color: Config.options.bar.barGroupBackground ?  Colors.colors.color1 : "transparent"
  }

  RowLayout {
    id: rowLayout

    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      right: parent.right
      leftMargin: root.padding
      rightMargin: root.padding
    }

    spacing: 15

  }
}
