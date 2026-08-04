import qs
import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  anchors.fill: parent

  function closeEntry() {
    stackView.pop()
    GlobalStates.quickAccessBusy = false
    
    console.log("quickAccess global status: ", GlobalStates.quickAccessBusy)
  }

  ColumnLayout {
    id: containerLayout

    anchors.fill: parent

    anchors {
      fill: parent

      topMargin: 15
      leftMargin: 15
      rightMargin: 15
      bottomMargin: 15
    }

    RowLayout {
      id: buttons

      Layout.fillWidth: true
      height: 30

      Rectangle {
        id: buttonsContainer
        height: parent.height
        Layout.fillWidth: true

        color: Colors.colors.color1
        radius: 10

      }
    }

		Rectangle {
			id: clipboardContainer
			implicitHeight: parent.height - 40
			Layout.fillWidth: true

			color: Colors.colors.color1
			radius: 10

      Component.onCompleted: {
        Clipboard.loadClipboard()
      }

			ScrollView {
				anchors.fill: parent
				padding: 10
				clip: true

				ColumnLayout {
					id: clipboardColumn
					width: parent.width
					spacing: 20

					Repeater {
            model: Clipboard.clipArray 

						Rectangle {
							required property var modelData
							required property int index

              color: Colors.colors.color4

              radius: 10

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
									text: modelData.data
								}
							}

							MouseArea {
								anchors.fill: parent
								cursorShape: Qt.PointingHandCursor
								onClicked: { 
                  console.log(modelData.raw)
                  Clipboard.setCopy(modelData.raw)
								}
          		}
						}
					}
				}
			}
		}
  }
}
