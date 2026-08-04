import qs
import qs.modules.common
import qs.services
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell

Item {
  id: root
  anchors.fill: parent
  property StackView stackView

  function openAiChat() {
    console.log(stackView)
    stackView.push("AiChat.qml")
    GlobalStates.aiChatOpen = true

    console.log("aiChatOpen global status: ", GlobalStates.aiChatOpen)
  }

  Rectangle {
    id: button

    color: "transparent"
    Layout.margins: 10
    anchors.fill: parent

    Text {
      anchors.centerIn: parent
      font.pixelSize: Appearance.font.pixelSize.extrememassive
      font.family: Appearance.font.family.main
      color: Colors.colors.color5
      text: ""
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: root.openAiChat()
    }
  }
}
