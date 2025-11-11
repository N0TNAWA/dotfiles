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
      
      // Dynamic width: fit text, but cap at maxWidth
      implicitWidth: Math.min(scrollContent.width, maxWidth)

      clip: true
      
      Row {
        id: scrollContent
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter
        
        Text {
          id: artistText
          font.pixelSize: Appearance.font.pixelSize.small
          font.family: Appearance.font.family.main
          color: Colors.colors.color5
          text: Music.currentArtist
        }
        
        Text {
          id: dash
          font.pixelSize: Appearance.font.pixelSize.small
          font.family: Appearance.font.family.main
          color: Colors.colors.color5
          text: "-"
        }
        
        Text {
          id: trackText
          font.pixelSize: Appearance.font.pixelSize.small
          font.family: Appearance.font.family.main
          color: Colors.colors.color5
          text: Music.currentTrack
        }
      }
      
      // Helper function to reset and start animation with current dimensions
      function resetAnimation() {
        // Stop the animation first
        scrollAnim.stop()
        
        // Reset position to start
        scrollContent.x = 0
        
        // Give QML a moment to recalculate widths
        Qt.callLater(function() {
          // Only run if content is wider than container
          if (scrollingArea.fullText.length > 50 || scrollContent.width > scrollingArea.maxWidth) {
            console.log("Adding new animation attributes")
            scrollAnim.from = 0
            scrollAnim.to = -(scrollContent.width - scrollingArea.maxWidth)
            scrollAnim.duration = Math.max(scrollContent.width * 20, 8000)
            scrollAnim.start()
          }
        })
      }
      
      // Animation for scrolling text
      NumberAnimation {
        id: scrollAnim
        target: scrollContent
        property: "x"
        from: 0
        to: -(scrollContent.width - scrollingArea.maxWidth)
        duration: Math.max(scrollContent.width * 20, 8000)
        loops: Animation.Infinite
        running: false  // Don't auto-start
        easing.type: Easing.InOutQuad  // Changed to Linear for smoother continuous scroll
      }
      
      // Start animation when component is ready
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
      
      // Also reset when the text content changes (backup mechanism)
      onFullTextChanged: {
        scrollingArea.resetAnimation()
      }
    }
  }
}
