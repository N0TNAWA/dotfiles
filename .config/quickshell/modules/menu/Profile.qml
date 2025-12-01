import qs
import qs.modules.common
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell

Item {
  id: root
  anchors {
    fill: parent
    topMargin: 10
    bottomMargin: 10
    leftMargin: 10
    rightMargin: 10
  }

  Rectangle {
    id: frameItem
    anchors.horizontalCenter: parent.horizontalCenter
    width: 80
    height: 80
    radius: 1000
    color: Colors.colors.color2
    clip: true
    layer.enabled: true
    layer.smooth: true

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
}
