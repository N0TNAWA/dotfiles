import qs.modules.common
import qs
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
  id: root
  property bool barOpen: true
  property bool menubarOpen: false
  property bool aiChatOpen: false
  property bool logsMenuOpen: false
  property bool quickAccessBusy: false
}
