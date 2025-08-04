import QtQuick
import QtQuick.Layouts
import Quickshell
import Qt5Compat.GraphicalEffects
import Quickshell.Hyprland
import qs.Data

Rectangle {
  width: parent.width
  implicitHeight: columnLayout.implicitHeight + 20
  height: implicitHeight
  color: Wal.color1
  radius: 5
  clip: true

  property string title: ""
  property string body: ""
  property string timestamp: ""
  property string icon: ""

  Component.onCompleted: {
    console.log("Card created with title:", title, "body:", body, "timestamp:", timestamp, "icon:", icon);
  }

  RowLayout {
    id: rowLayout
    spacing: 10
    anchors.fill: parent
    anchors.margins: 10

    Rectangle {
      width: 54
      height: 54
      clip: true
      visible: icon ? true : false
      layer.enabled: true
      layer.smooth: true
      color: "transparent"
      Layout.alignment: Qt.AlignTop

      Image {
        id: artImage
        anchors.fill: parent
        source: icon
        fillMode: Image.PreserveAspectCrop
        visible: false
        asynchronous: true
        cache: false
        sourceSize.width: 54
        sourceSize.height: 54
      }

      OpacityMask {
        anchors.fill: artImage
        source: artImage
        maskSource: Rectangle {
          width: artImage.width
          height: artImage.height
          radius: 5
          visible: false
        }
      }
    }

    ColumnLayout {
      id: columnLayout
      spacing: 4
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop

      Text {
        text: title
        font.bold: true
        font.family: Settings.settings.fontFam
        color: Wal.color7
        wrapMode: Text.NoWrap
        maximumLineCount: 1
        elide: Text.ElideRight
        Layout.fillWidth: true
      }

      Text {
        text: body
        color: Wal.color7
        font.family: Settings.settings.fontFam
        font.pixelSize: 13
        wrapMode: Text.WordWrap
        maximumLineCount: mouseArea.containsMouse ? 10 : 1
        elide: Text.ElideRight
        Layout.fillWidth: true
      }

      Text {
        text: timestamp
        font.pixelSize: 10
        color: Wal.color7
        font.family: Settings.settings.fontFam
      }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
  }

  Behavior on height {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InOutQuad
    }
  }
}
