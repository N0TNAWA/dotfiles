// StyledSlider.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import qs.Data

Slider {
  id: control

  // Theme knobs
  property color trackColor: "#2b2f33"
  property color fillColor: "#3ecf8e"
  property color handleColor: "#ffffff"
  property color handleBorderColor: "#1a1d20"
  property real  grooveHeight: 14
  property real  handleSize: 0
  property bool  roundedEnds: true 

  implicitWidth: 200
  implicitHeight: Math.max(handleSize, grooveHeight) + topPadding + bottomPadding
  hoverEnabled: true

  // Track
  background: Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    x: control.leftPadding
    width: control.availableWidth
    height: control.grooveHeight
    radius: control.roundedEnds ? height / 2 : 0
    color: control.enabled ? control.trackColor : Qt.darker(control.trackColor, 1.3)

    // Filled portion
    Rectangle {
      height: parent.height
      width: control.visualPosition * parent.width
      radius: parent.radius
      color: control.fillColor
      opacity: control.enabled ? 1 : 0.6
    }
  }

  // Thumb
  handle: Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    width: control.handleSize
    height: control.handleSize
    radius: width / 2
    y: (control.height - height) / 2
    x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
    color: control.pressed
             ? Qt.darker(control.handleColor, 1.15)
             : (control.hovered ? Qt.lighter(control.handleColor, 1.05)
                                : control.handleColor)
    border.color: control.handleBorderColor
    border.width: 0

    // Subtle motion/ink
    Behavior on x { NumberAnimation { duration: 90; easing.type: Easing.OutCubic } }
    Behavior on color { ColorAnimation { duration: 120 } }
  }
}
