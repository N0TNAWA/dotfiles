import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import qs.Data
import "../Components"

Rectangle {
  implicitHeight: listLayout.implicitHeight + 50
  color: Wal.color0

  property var notificationData: Notifications.notificationData

  Rectangle {
    id: notifications
    color: "transparent"
    clip: true
    anchors.fill: parent
    anchors.margins: 5
    
    Column {
      id: listLayout
      width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 5

      Component.onCompleted: {
        Notifications.fetchNotifications()
      }

      Text {
        text: "Notifications"
        color: Wal.color7
        font.pixelSize: 16
        font.family: Settings.settings.fontFam 
      }

      Rectangle {
        width: parent.width
        height: 2
        radius: 5

        color: Wal.color2
      }
      
      Repeater {
        id: repeater
        model: notificationData

        delegate: NotificationCard {
          icon: modelData.icon || ""
          title: modelData.summary || ""
          body: modelData.body || ""
          timestamp: modelData.timestamp || ""
        }
      }
    }
  }
}
