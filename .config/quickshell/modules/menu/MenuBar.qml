import qs
import qs.services
import qs.modules.common
import qs.modules.components
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
      property real menubarHeight: Appearance.sizes.menubarHeight
      property real overflowPadding: Appearance.paddings.overflowPadding

      function hide() {
        GlobalStates.menubarOpen = false
      }

      exclusionMode: ExclusionMode.Normal
      exclusiveZone: root.pin ? menubarWidth : 0
      implicitWidth: Appearance.sizes.menubarWidth + overflowPadding * 2 // <-- + 10 for padding for the animation
      implicitHeight: GlobalStates.aiChatOpen ? Appearance.sizes.aiWindow.menubarHeight + overflowPadding * 2 : Appearance.sizes.menubarHeight + overflowPadding // <-- + 10 for padding for the animation
      WlrLayershell.namespace: "quickshell:menubar"
      focusable: true
      color: "transparent"

      anchors {
        left: true
        top: true
        right: true
        bottom: false
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

      BlobRect {
        id: menubarBackground
        anchors.top: parent.top
        width: menubarRoot.menubarWidth
        height: menubarRoot.menubarHeight 
        color: Colors.colors.color0
        
        radius: 20
        topRight: inverse
        topLeft: none
        bottomRight: normal
        bottomLeft: inverse

        StackView {
          id: stackView
          anchors.fill: parent
          initialItem: MenuBarContent {
              stackView: stackView
          }
        }

        x: GlobalStates.menubarOpen ?  0 : -width -20

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
