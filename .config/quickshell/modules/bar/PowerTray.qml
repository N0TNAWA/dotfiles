import qs
import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
  id: root
  
  property bool togglePowerOptions: Config.options.bar.power.togglePowerOptions

  visible: opacity > 0 || togglePowerOptions
  implicitHeight: menuRow.implicitHeight
  implicitWidth: menuRow.implicitWidth
  width: togglePowerOptions ? menuRow.implicitWidth : 0
  opacity: togglePowerOptions ? 1 : 0
  transform: Translate { id: slide; x: 0 }

  Behavior on width {
    NumberAnimation { 
      duration: 200 
      easing.type: Easing.InOutQuad 
    }
  }
  Behavior on opacity {
    NumberAnimation { 
      id: fadeAnim
      duration: 200 
      easing.type: Easing.InOutQuad 
    }
  }

  PropertyAnimation {
    id: slideAnim
    target: slide
    property: "x"
    duration: 200
    easing.type: Easing.OutQuad
  }

  onVisibleChanged: {
    slideAnim.to = visible ? 0 : -40
    slideAnim.start()
  }

  RowLayout {
    id: menuRow
    spacing: 10

    function createItem(icon, color, func) {
      let item = Qt.createQmlObject(`
        import QtQuick
        import Quickshell
        import qs.modules.common

        Item {
          property var func
          implicitWidth: textItem.implicitWidth
          implicitHeight: textItem.implicitHeight

          Text {
            id: textItem
            font.pixelSize: Appearance.font.pixelSize.small
            font.family: Appearance.font.family.main
            color: "${color}"
            text: "${icon}"
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: if (func) func()
          }
        }
      `, menuRow)

      item.func = func
      return item
    }

    Component.onCompleted: {
      createItem("⏼", Colors.colors.color6, Power.powerOff)
      createItem("", Colors.colors.color6, Power.reboot)
      createItem("", Colors.colors.color6, Power.lock)
      createItem("", Colors.colors.color6, Power.exitHyprland)
    }
  }
}
