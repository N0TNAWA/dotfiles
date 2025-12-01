import qs
import qs.services
import qs.modules.common
import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
  id: root
  property Component contentComponent: MenuBarContent {}
  property Item menubarContent

  Component.onCompleted: {
    root.menubarContent = contentComponent.createObject(null, {
      "scopeRoot": root,
    });
    menubarLoader.item.contentParent.children = [root.menubarContent];
  }

  Loader {
    id: menubarLoader
    active: true

    sourceComponent: PanelWindow {
      id: menubarRoot
      visible: GlobalStates.menubarOpen

      property var contentParent: menubarBackground
      property real menubarWidth: Appearance.sizes.menubarWidth

      function hide() {
        GlobalStates.menubarOpen = false
      }

      exclusionMode: ExclusionMode.Normal
      exclusiveZone: root.pin ? menubarWidth : 0
      implicitWidth: Appearance.sizes.menubarWidth
      implicitHeight: Appearance.sizes.menubarHeight
      WlrLayershell.namespace: "quickshell:menubar"
      color: "transparent"

      anchors {
        top: true
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
        bottomLeftRadius: 12
        bottomRightRadius: 12

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
