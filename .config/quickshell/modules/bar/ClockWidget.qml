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
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: DateTime.time
    }

    Text {
      visible: Config.options.bar.calendarVisible
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: " • "
    }

    Text {
      visible: Config.options.bar.calendarVisible
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: DateTime.date
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: Config.options.bar.calendarVisible = !Config.options.bar.calendarVisible
    }
  }
}
