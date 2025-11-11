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
    spacing: 5

    // No player
    Text {
      visible: !Music.currentPlayer
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: "  No player active"
    }

    // Spotify icon
    Text {
      visible: Music.currentPlayer
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: ""
    }

    // Play/pause button
    Text {
      visible: Music.currentPlayer
      font.pixelSize: Appearance.font.pixelSize.small
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: Music.currentPlayer.isPlaying ? "" : ""

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Music.playPause()
      }
    }
  }
}

