import qs
import qs.modules.common
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell

Item {
  id: root

  RowLayout {
    anchors.fill: parent

    Rectangle {
      id: avatar
      width: 50
      height: 50
      radius: 1000
      color: "transparent"
      clip: true
      Layout.margins: 10
      Layout.alignment: Qt.AlignHCenter
      

      Image {
        id: avatarImage
        anchors.fill: parent
        source: Config.options.user.icon
        fillMode: Image.PreserveAspectCrop
        visible: false
        asynchronous: true
        cache: false
        sourceSize.width: 80
        sourceSize.height: 46
      }

      OpacityMask {
        anchors.fill: avatarImage
        source: avatarImage
        maskSource: Rectangle {
          width: avatarImage.width
          height: avatarImage.height
          radius: avatarImage.width / 2
          visible: false
        }
      }
    }

    Column {
      id: textColumn
      spacing: 5

      Text {
        font.pixelSize: Appearance.font.pixelSize.large
        font.family: Appearance.font.family.main
        color: Colors.colors.color5
        text: Config.options.user.name + "@" + Config.options.user.host
      }

      Text {
        font.pixelSize: Appearance.font.pixelSize.smaller
        font.family: Appearance.font.family.main
        color: Colors.colors.color5
        text: "I do my best."
      }
    }
  }
}
