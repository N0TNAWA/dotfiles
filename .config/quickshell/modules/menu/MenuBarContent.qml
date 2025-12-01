import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  anchors.fill: parent

  GridLayout {
    columns: 4
    rowSpacing: 8
    columnSpacing: 8
  
    anchors {
      fill: parent
      margins: 8
    }
    
        // A (tall, spans 2 rows)
    Rectangle {
      id: a
      color: "transparent"
      Layout.rowSpan: 2
      Layout.fillWidth: true
      Layout.fillHeight: true

      Profile {}
    }

    // B (wide, spans 2 columns)
    Rectangle {
      id: b
      color: "transparent"
      Layout.columnSpan: 2
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    // E (tall, spans 2 rows)
    Rectangle {
      id: e
      color: "transparent"
      Layout.rowSpan: 2
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    // Row 2 starts here automatically

    // C
    Rectangle {
      id: c
      color: "transparent"
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    // D
    Rectangle {
      id: d
      color: "transparent"
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
  }
}
