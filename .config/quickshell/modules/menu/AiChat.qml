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

		}

		//Regular chat area
		Rectangle {
			id: chatContainer
			Layout.fillHeight: true
			Layout.fillWidth: true

			color: Colors.colors.color1
			radius: 10

			Layout.topMargin: 15
			Layout.bottomMargin: 15

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
			Layout.fillHeight: true
			Layout.fillWidth: true

			color: Colors.colors.color1
			radius: 10

			Layout.topMargin: 15

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

					// Add chat button
					Rectangle {
						id: addChat
						color: Colors.colors.color4
						radius: 6

						Layout.fillWidth: true
						implicitHeight: 50

						Rectangle {
							id: addChatContainer

							anchors.fill: parent
							anchors.margins: 10

							color: "transparent"

							Text {
								anchors.verticalCenter: parent.verticalCenter

								font.pixelSize: Appearance.font.pixelSize.small
								font.family: Appearance.font.family.main
								color: Colors.colors.color7
								text: "+ New chat"
							}

							TextArea {
								id: addChatField
								visible: false
								anchors.fill: parent
								font.family: Appearance.font.family.main
								color: Colors.colors.color7
								placeholderText: "Chat name..."
								wrapMode: Text.Wrap
								activeFocusOnPress: true
								focus: false

								background: Rectangle {
									radius: 5
									implicitWidth: parent.width
									implicitHeight: parent.height
									color: Colors.colors.color1
									border.color: "transparent"
								}

								Keys.onPressed: (event) => {
									if (event.key === Qt.Key_Return && !event.modifiers) {
										console.log("Submitted:", text)
										AiService.addChat(text)

										text = ""
										event.accepted = true
										addChatContainer.createChat()
									}
								}
							}

							function createChat() {
								addChatField.visible = !addChatField.visible
								addChatButton.enabled = !addChatButton.enabled
							}
						}

						MouseArea {
							id: addChatButton
							anchors.fill: parent
							cursorShape: Qt.PointingHandCursor
							onClicked: addChatContainer.createChat()
						}
					}

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
									GlobalStates.logsMenuOpen = !GlobalStates.logsMenuOpen
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
			Layout.preferredHeight: inputField.focus ? 200 : 50
			radius: 10
			color: Colors.colors.color3
			visible: GlobalStates.logsMenuOpen ? true : false

			Behavior on Layout.preferredHeight {
				NumberAnimation {
					id: scaleInput
					duration: Config.options.animation.animationDur
					easing.type: Easing.OutCubic
					alwaysRunToEnd: true
				}
			}

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
						onPressed: focus = true

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
								inputField.focus = false
							}
						}
					}
				}
			}
		}
	}
}
