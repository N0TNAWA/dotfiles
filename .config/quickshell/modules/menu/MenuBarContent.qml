import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  anchors.fill: parent
  property StackView stackView


  GridLayout {
    columns: 4
    rows: 5
    rowSpacing: 15
    columnSpacing: 15
  
    anchors {
      fill: parent

      leftMargin: 15
      rightMargin: 15
      bottomMargin: 15
    }

    Repeater {
      model: 4

      Item {
        Layout.column: index
        Layout.fillWidth: true
      }
    }
    
    Rectangle {
      id: a
      color: Colors.colors.color1
      Layout.rowSpan: 2
      Layout.columnSpan: 2
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 10

      Clock { anchors.fill: parent }
    }

    Rectangle {
      id: b
      color: Colors.colors.color1
      Layout.rowSpan: 1
      Layout.columnSpan: 2
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 10

      Profile { anchors.fill: parent }
    }

    Rectangle {
      id: e
      color: Colors.colors.color1
      Layout.rowSpan: 1
      Layout.columnSpan: 1
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 10

      DoNotDisturb{ anchors.fill: parent }
    }

    Rectangle {
      id: c
      color: Colors.colors.color1
      Layout.rowSpan: 1
      Layout.columnSpan: 1
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 10

      AiChatButton{ anchors.fill: parent; stackView: root.stackView }
    }

    Rectangle {
      id: d
      color: Colors.colors.color1
      Layout.rowSpan: 1
      Layout.columnSpan: 4
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 10

      Sliders { anchors.fill: parent; stackView: root.stackView }
    }

    Rectangle {
      id: f
      color: Colors.colors.color1
      Layout.rowSpan: 1
      Layout.columnSpan: 4
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 10
    }
        
        
    Rectangle {
      id: g
      color: Colors.colors.color1
      Layout.rowSpan: 1
      Layout.columnSpan: 4
      Layout.fillWidth: true
      Layout.preferredHeight: 150
      radius: 10
    }
  }
}
