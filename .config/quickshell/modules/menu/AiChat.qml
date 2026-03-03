import qs
import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    anchors.fill: parent

	function closeAiChat() {
		stackView.pop()
		GlobalStates.aiChatOpen = false

		console.log("aiChatOpen global status: ", GlobalStates.aiChatOpen)
	}

	ColumnLayout {
		id: containerLayout

		anchors {
			fill: parent

			topMargin: 15
			leftMargin: 15
			rightMargin: 15
			bottomMargin: 15
		}

		RowLayout {
			id: buttonRow
			Layout.fillWidth: true
			spacing: 0

			Rectangle {
				id: back
				color: "transparent"
				implicitHeight: 25

				Layout.fillWidth: true
				Layout.preferredWidth: 1

				Text {
					anchors.centerIn: parent
					font.pixelSize: Appearance.font.pixelSize.supermassive
					font.family: Appearance.font.family.main
					color: Colors.colors.color5
					text: "󱞳"
				}

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onClicked: root.closeAiChat()
				}
			}

			Rectangle {
				id: logs
				color: "transparent"
				implicitHeight: 25

				Layout.fillWidth: true
				Layout.preferredWidth: 1

				Text {
					anchors.centerIn: parent
					font.pixelSize: Appearance.font.pixelSize.supermassive
					font.family: Appearance.font.family.main
					color: Colors.colors.color5
					text: "󰅍"
				}

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onClicked: GlobalStates.logsMenuOpen = !GlobalStates.logsMenuOpen
				}
			}

			Rectangle {
				id: settings
				color: "transparent"
				implicitHeight: 25

				Layout.fillWidth: true
				Layout.preferredWidth: 1

				Text {
					anchors.centerIn: parent
					font.pixelSize: Appearance.font.pixelSize.supermassive
					font.family: Appearance.font.family.main
					color: Colors.colors.color5
					text: ""
				}

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					//onClicked: "stackView.push('AiSettings.qml')"
				}
			}
		}

		//Regular chat area
		Rectangle {
			id: chatContainer
			implicitHeight: 850
			Layout.fillWidth: true

			color: Colors.colors.color1
			radius: 10

			visible: GlobalStates.logsMenuOpen ? true : false

			Component.onCompleted: {
				AiService.loadChat()
			}

			ScrollView {
				anchors.fill: parent
				padding: 10
				clip: true

				ColumnLayout {
					id: messagesColumn
					width: parent.width
					spacing: 20

					Repeater {
						model: AiService.chatMessages

						Rectangle {
							required property var modelData
							required property int index
							
							color: "transparent"
							visible: index !== 0

							Layout.fillWidth: true
							implicitHeight: messageColumn.implicitHeight

							Column {
								id: messageColumn
								width: parent.width
								spacing: 6

								Text {
									text: modelData.role === "user" ? Config.options.user.name : Config.options.ai.name
									font.pixelSize: Appearance.font.pixelSize.small
									font.family: Appearance.font.family.main
									color: Colors.colors.color7
								}

								Rectangle {
									color: Colors.colors.color3
									radius: 6

									width: Math.min(parent.width, messageText.implicitWidth + 20)
									implicitHeight: messageText.implicitHeight + 16

									Text {
										id: messageText
										anchors.margins: 8
										anchors.fill: parent
										wrapMode: Text.WordWrap

										font.pixelSize: Appearance.font.pixelSize.small
										font.family: Appearance.font.family.main
										color: Colors.colors.color7
										text: modelData.content
									}
								}
							}
						}
					}
				}
			}
		}

		// Drop down area
		Rectangle {
			id: logsContainer
			implicitHeight: 850
			Layout.fillWidth: true

			color: Colors.colors.color1
			radius: 10

			visible: GlobalStates.logsMenuOpen ? false : true

			Component.onCompleted: {
				AiService.getConversations()
				console.log("Model length:", Config.options.ai.conversations.length)
			}

			ScrollView {
				anchors.fill: parent
				padding: 10
				clip: true

				ColumnLayout {
					id: logsColumn
					width: parent.width
					spacing: 10

					Repeater {
						model: Config.options.ai.conversations

						Rectangle {
							required property var modelData
							required property int index
							
							color: Colors.colors.color4
							radius: 6

							Layout.fillWidth: true
							implicitHeight: 50

							Rectangle {
								anchors.fill: parent
								anchors.margins: 10

								color: "transparent"

								Text {
									anchors.verticalCenter: parent.verticalCenter

									font.pixelSize: Appearance.font.pixelSize.small
									font.family: Appearance.font.family.main
									color: Colors.colors.color7
									text: modelData.split("/").pop()
								}
							}

							MouseArea {
								anchors.fill: parent
								cursorShape: Qt.PointingHandCursor
								onClicked: { 
									AiService.openChat(index)
								 	GlobalShortcut.logsMenuOpen = !GlobalShortcut.logsMenuOpen
								}
          					}
						}
					}
				}
			}
		}

		Rectangle {
			id: textArea
			Layout.fillWidth: true
			implicitHeight: 50
			radius: 5
			color: Colors.colors.color3

			FocusScope {
				anchors.fill: parent

				ScrollView {
					anchors.fill: parent
					clip: true

					TextArea {
						id: inputField
						anchors.fill: parent
						font.family: Appearance.font.family.main
						color: Colors.colors.color7
						placeholderText: "Type your message..."
						wrapMode: Text.Wrap
						activeFocusOnPress: true
						focus: false

						background: Rectangle {
							radius: 10
							implicitWidth: parent.width
							implicitHeight: parent.height
							color: Colors.colors.color1
							border.color: "transparent"
						}

						Keys.onPressed: (event) => {
							if (event.key === Qt.Key_Return && !event.modifiers) {
								console.log("Submitted:", text)
								AiService.postFunction(text)

								text = ""
								event.accepted = true
							}
						}
					}
				}
			}
		}
	}
}