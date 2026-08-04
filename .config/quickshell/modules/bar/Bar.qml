import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.modules.common
import qs.modules.components

Scope {
  id: bar

  Variants {
    model: [Quickshell.screens[0]]
    
    LazyLoader {
      id: barLoader

      active: GlobalStates.barOpen
      
      component: PanelWindow {
        id: barRoot
        screen: Quickshell.screens[0]
        exclusionMode: ExclusionMode.Ignore
        exclusiveZone: Appearance.sizes.barHeight
        WlrLayershell.namespace: "quickshell:bar"
        implicitHeight: Appearance.sizes.barHeight + 20
        color: "transparent"

        anchors {
          top: true
          bottom: false
          left: true
          right: true
        }

        Item {
          id: barContent

          anchors {
            left: parent.left
            right: parent.right
            top: parent.top
          }

          height: Appearance.sizes.barHeight

          BlobRect {
            id: barBackground

            anchors {
              left: parent.left
              right: parent.right
              top: parent.top
            }

            height: Appearance.sizes.barHeight

            bottomRight: inverse
            bottomLeft: inverse

            color: Colors.colors.color0
          }
          
          // Left section //
          RowLayout {
            id: leftSection
            anchors.left: parent.left

            anchors {
              topMargin: 0
              bottomMargin: 0
              leftMargin: 15
              rightMargin: 0
            }

            BarGroup {
              id: leftSectionLeftGroup
              anchors.fill: parent.centerIn

              PowerWidget {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }

              PowerTray {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }
            }

            BarGroup {
              id: leftSectionCenterGroup
              anchors.fill: parent.centerIn

              ClockWidget {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }
            }

            BarGroup {
              id: leftSectionRightGroup
              anchors.fill: parent.centerIn

              UpdateWidget {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }
            }
          }
          
          // Middle section //
          RowLayout {
            id: middleSection
            anchors.centerIn: parent

            BarGroup {
              id: middleSectionCenterGroup
              anchors.fill: parent.centerIn

              WorkspaceWidget {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }
            }
          }
          
          // Right section //
          RowLayout {
            id: rightSection
            anchors.right: parent.right

            anchors {
              topMargin: 0
              bottomMargin: 0
              leftMargin: 0
              rightMargin: 10
            }

            BarGroup {
              id: rightSectionRightGroup
              anchors.fill: parent.centerIn

              WindowWidget {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }
            }
            
            BarGroup {
              id: rightSectionCenterGroup
              anchors.fill: parent.centerIn

              MusicWidget {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }

              MusicTray {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
              }
            }
          }
        }
      }
    }
  }
}
