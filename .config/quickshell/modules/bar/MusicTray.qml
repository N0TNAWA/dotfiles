import qs.modules.common
import qs.services
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  visible: Music.currentPlayer
  implicitWidth: rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight
  
  RowLayout {
    id: rowLayout
    anchors.centerIn: parent
    spacing: 5
    
    Item {
      id: scrollingArea
      visible: Music.currentPlayer
      implicitHeight: scrollContent.implicitHeight
      
      property string fullText: Music.currentArtist + " - " + Music.currentTrack
      property int maxWidth: 180
      
      implicitWidth: Math.min(scrollContent.width, maxWidth)

      clip: true
      
      Row {
        id: scrollContent
        spacing: 50
        anchors.verticalCenter: parent.verticalCenter

        Row {
          id: content1
          spacing: 5

          Text { text: Music.currentArtist; font.pixelSize: Appearance.font.pixelSize.small; font.family: Appearance.font.family.main; color: Colors.colors.color5; }
          Text { text: "-"; font.pixelSize: Appearance.font.pixelSize.small; font.family: Appearance.font.family.main; color: Colors.colors.color5; }
          Text { text: Music.currentTrack; font.pixelSize: Appearance.font.pixelSize.small; font.family: Appearance.font.family.main; color: Colors.colors.color5; }
        }

        Row {
          id: content2
          spacing: 5

          Text { text: Music.currentArtist; font.pixelSize: Appearance.font.pixelSize.small; font.family: Appearance.font.family.main; color: Colors.colors.color5; }
          Text { text: "-"; font.pixelSize: Appearance.font.pixelSize.small; font.family: Appearance.font.family.main; color: Colors.colors.color5; }
          Text { text: Music.currentTrack; font.pixelSize: Appearance.font.pixelSize.small; font.family: Appearance.font.family.main; color: Colors.colors.color5; }
        }
      }
      
      function resetAnimation() {
        scrollAnim.stop()
        scrollContent.x = 0

        Qt.callLater(function() {
          if (scrollContent.width > scrollingArea.maxWidth) {
            scrollAnim.start()
          }
        })
      }
      
      NumberAnimation {
        id: scrollAnim
        target: scrollContent
        property: "x"
        from: 0
        to: -(content1.width + scrollContent.spacing)
        duration: Math.max(content1.width * 20, 8000)
        loops: Animation.Infinite
        running: false
        easing.type: Easing.Linear
      }
      
      Component.onCompleted: {
        if (scrollingArea.fullText.length > 50 || scrollContent.width > scrollingArea.maxWidth) {
          scrollAnim.start()
        }
      }
      
      Connections {
        target: Music.currentPlayer
        enabled: Music.currentPlayer !== null
        
        function onTrackChanged() {
          console.log("New track started - resetting animation")
          scrollingArea.resetAnimation()
        }
      }
    }
  }
}
