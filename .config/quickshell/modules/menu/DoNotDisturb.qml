import qs
import qs.modules.common
import qs.services
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell

Item {
  	id: root
	anchors.fill: parent

	Rectangle {
		id: button

		color: "transparent"
		Layout.margins: 10
		anchors.fill: parent

		Component.onCompleted: {
			if (NotificationData.statusNotif) NotificationData.statusNotif()
		}

		Text {
			anchors.centerIn: parent
			font.pixelSize: Appearance.font.pixelSize.extrememassive
			font.family: Appearance.font.family.main
			color: Colors.colors.color5
			text: NotificationData.dndState ? "" : ""
		}

		MouseArea {
			anchors.fill: parent
			cursorShape: Qt.PointingHandCursor
			onClicked: if (NotificationData.toggleNotif) NotificationData.toggleNotif()
    	}
	}
}
