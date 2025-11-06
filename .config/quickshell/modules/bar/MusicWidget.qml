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
    spacing: 10 

    Text {
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color6
      text: "  " + Music.currentArtist
    }
    
    Text {
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color6
      text: "-"
    }

    Text {
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color6
      text: Music.currentTrack
    }

  }
}
