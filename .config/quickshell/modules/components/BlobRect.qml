import QtQuick
import QtQuick.Shapes

Item {
  id: root

  property color color: "white"

  property real radius: 20

  property int topLeft: none
  property int topRight: none
  property int bottomLeft: none
  property int bottomRight: none


  readonly property int none: 0
  readonly property int normal: 1
  readonly property int inverse: 2


  Shape {
    anchors.fill: parent

    ShapePath {
      fillColor: root.color
      strokeWidth: 0

      startX: root.getStartX()
      startY: 0


      // Top edge
      PathLine {
        x: root.checkInverse(root.topRight) ? root.width + root.cornerSize(root.topRight) : root.width - root.cornerSize(root.topRight)
        y: 0
      }


      // Top right corner
      PathCubic {
        x: root.width
        y: root.cornerSize(root.topRight)

        control1X: root.width
        control1Y: 0

        control2X: root.width
        control2Y: root.cornerSize(root.topRight)
      }


      // Right edge
      PathLine {
        x: root.width
        y: root.checkInverse(root.bottomRight) ? root.height + root.cornerSize(root.bottomRight) : root.height - root.cornerSize(root.bottomRight)
      }


      // Bottom right
      PathCubic {
        x: root.width - root.cornerSize(root.bottomRight)
        y: root.height

        control1X: root.width
        control1Y: root.height

        control2X: root.width - root.cornerSize(root.bottomRight)
        control2Y: root.height
      }


      // Bottom edge
      PathLine {
        x: root.cornerSize(root.bottomLeft)
        y: root.height
      }


      // Bottom left
      PathCubic {
        x: 0
        y: root.checkInverse(root.bottomLeft) ? root.height + root.cornerSize(root.bottomLeft) : root.height - root.cornerSize(root.bottomLeft)

        control1X: 0
        control1Y: root.height

        control2X: 0
        control2Y: root.checkInverse(root.bottomLeft) ? root.height + root.cornerSize(root.bottomLeft) : root.height - root.cornerSize(root.bottomLeft)
      }

      // Left edge
      PathLine {
        x: 0
        y: root.cornerSize(root.topLeft)
      }


      // Top left
      PathCubic {
        x: root.checkInverse(root.topLeft) ? root.cornerSize(root.topLeft) : -root.cornerSize(root.topLeft)
        y: 0

        control1X: 0
        control1Y: 0

        control2X: root.checkInverse(root.topLeft) ? root.cornerSize(root.topLeft) : -root.cornerSize(root.topLeft)
        control2Y: 0
      }
    }
  }


  function cornerSize(type) {
    if (type === none)
      return 0

    return radius
  }

  function checkInverse(type) {
    if (type === inverse)
      return true

    return false
  }

  function getStartX() {
    return cornerSize(topLeft)
  }
}
