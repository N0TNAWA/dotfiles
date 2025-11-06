import qs.modules.common
import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
  property int updates: 0
  property string updatesText: "Checking…"
  property string formatted: {
    const prefix = Config.options?.update?.format
    return `${prefix}${updates > 0 ? updates : "0"}`
  }

  property int refreshInterval: 600000 // 10 minutes

  // your command to check updates
  property string checkerPath: "~/dotfiles/.config/quickshell/scripts/fetch_update.sh"
  property string installPath: "~/dotfiles/.config/quickshell/scripts/update.sh"

  Timer {
    id: updateTimer
    interval: refreshInterval
    running: true
    repeat: true
    onTriggered: checkUpdates()
  }

  Process {
    id: updateChecker
    running: false
    command: [ "/usr/bin/bash", "-c", checkerPath ]

    stdout: StdioCollector {
      onStreamFinished: {
        const count = parseInt(text.trim())
        updates = isNaN(count) ? 0 : count
      }
    }
  }

  Process {
    id: updateInstaller
    running: false
    command: [ "kitty", "--title", "systemupdate", "/usr/bin/bash", "-c", installPath ]

    stdout: StdioCollector {
      onStreamFinished: {
        console.log("Update finished")
      }
    }
  }

  function checkUpdates() {
    updateChecker.running = true
  }

  function installUpdates() {
    updateInstaller.running = true 
  }

  Component.onCompleted: checkUpdates()
}
