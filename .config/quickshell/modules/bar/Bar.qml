import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.modules.common

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
        exclusiveZone: implicitHeight
        WlrLayershell.namespace: "quickshell:bar"
        implicitHeight: Config.options.bar.barHeight
        color: "transparent"

        margins {
          top: 10
          left: 10
          right: 10
        }

        anchors {
          top: true
          bottom: false
          left: true
          right: true
        }

        Item {
          id: barContent

          anchors {
            right: parent.right
            left: parent.left
            top: parent.top
            bottom: undefined
          }
          
          implicitHeight: Config.options.bar.barHeight
          height: Config.options.bar.barHeight

          Rectangle {
            id: barBackground
            anchors.fill: parent
            color: Colors.colors.color0
            radius: 10
          }
          
          // Left section //
          RowLayout {
            id: leftSection
            anchors.left: parent.left

            anchors {
              topMargin: 0
              bottomMargin: 0
              leftMargin: 10
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

            BarGroup {
              id: middleSectionLeftGroup
              anchors.fill: parent.centerIn

              WindowWidget {
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
              id: rightSectionCenterGroup
              anchors.fill: parent.centerIn

              MusicWidget {
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
