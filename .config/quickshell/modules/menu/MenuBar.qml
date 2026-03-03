import qs
import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Controls
import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
  id: root
  
  Loader {
    id: menubarLoader
    active: true

    sourceComponent: PanelWindow {
      id: menubarRoot
      //visible: GlobalStates.menubarOpen
      visible: true

      property var contentParent: menubarBackground
      property real menubarWidth: Appearance.sizes.menubarWidth

      function hide() {
        GlobalStates.menubarOpen = false
      }

      exclusionMode: ExclusionMode.Normal
      exclusiveZone: root.pin ? menubarWidth : 0
      implicitWidth: Appearance.sizes.menubarWidth + 10 // <-- + 10 for padding for the animation
      implicitHeight: GlobalStates.aiChatOpen ? Appearance.sizes.aiWindow.menubarHeight : Appearance.sizes.menubarHeight // <-- + 10 for padding for the animation
      WlrLayershell.namespace: "quickshell:menubar"
      focusable: true
      color: "transparent"

      anchors {
        left: true
        top: true
        right: false
        bottom: false
      }

      margins {
        top: 10
        left: 0
      }

      mask: Region {
        item: menubarBackground
      }

      HyprlandFocusGrab { 
        id: grab
        windows: [ menubarRoot ]
        active: menubarRoot.visible && !root.pin

        onCleared: () => {
          if (!active) menubarRoot.hide()
        }
      }

      Rectangle {
        id: menubarBackground
        anchors.top: parent.top
        width: menubarRoot.menubarWidth
        height: parent.height 
        color: Colors.colors.color0
        radius: 12

        StackView {
          id: stackView
          anchors.fill: parent
          initialItem: MenuBarContent {
              stackView: stackView
          }
        }

        x: GlobalStates.menubarOpen ? 10 : -width

        Behavior on x {
          NumberAnimation {
            id: slideAnim
            duration: Config.options.animation.animationDur
            easing.type: Easing.OutCubic
            alwaysRunToEnd: true


            onStarted: {
              if (GlobalStates.menubarOpen)
                menubarRoot.visible = true
            }

            onFinished: {
              if (!GlobalStates.menubarOpen)
                menubarRoot.visible = false
            }
          }
        }

        Behavior on height {
          NumberAnimation {
            id: scaleAnim
            duration: Config.options.animation.animationDur
            easing.type: Easing.OutCubic
            alwaysRunToEnd: true
          }
        }

        Keys.onPressed: (event) => {
          if (event.key === Qt.Key_Escape) {
            menubarRoot.hide();
          }
          event.accepted = true;
        }
      }
    }
  }

  IpcHandler {
    target: "menubar"

    function toggle(): void {
      GlobalStates.menubarOpen = !GlobalStates.menubarOpen
    }

    function close(): void {
      GlobalStates.menubarOpen = false
    }

    function open(): void {
      GlobalStates.menubarOpen = true
    }
  }

  GlobalShortcut {
    name: "menubarToggle"
    description: "Toggles menubar on press"

    onPressed: {
      GlobalStates.menubarOpen = !GlobalStates.menubarOpen;
    }
  }

  GlobalShortcut {
    name: "menubarOpen"
    description: "Opens menubar on press"

    onPressed: {
      GlobalStates.menubarOpen = true;
    }
  }

  GlobalShortcut {
    name: "menubarClose"
    description: "Closes menubar on press"

    onPressed: {
      GlobalStates.menubarOpen = false;
    }
  }
}
