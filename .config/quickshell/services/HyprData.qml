pragma Singleton
pragma ComponentBehavior: Bound
import qs.modules.common
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  property int activeWorkspace: 0
  property var workspaceList: []
  property string focusedWindow: "No window focused"
  property var windowList: []

  // Initial trigger
  Item {
    Component.onCompleted: {
      fetchWorkspaces()
      updateFocusedWindow()
    }
  }

  // Periodic updates
  Timer {
    id: updater
    interval: 100
    running: true
    repeat: true
    onTriggered: {
      if (!updateFocusedWindowProc.running) {
        updateFocusedWindowProc.running = true
      }
    }
  }

  // --- WORKSPACES ---
  Process {
    id: fetchWorkspaceProc
    running: false
    command: ["hyprctl", "workspaces", "-j"]

    stdout: StdioCollector {
      id: workspaceCollector
      onStreamFinished: {
        try {
          const output = workspaceCollector.text.trim()
          if (output.length === 0) {
            console.log("No workspace data received.")
            return
          }

          const parsed = JSON.parse(output)
          workspaceList = []
          for (let ws of parsed) {
            workspaceList.push(ws.id)
          }

          console.log("Current workspaces:", workspaceList)
        } catch (e) {
          console.log("Failed to parse workspace data:", e)
          console.log("Raw output:", workspaceCollector.text)
        }
      }
    }
  }

  // --- FOCUSED WINDOW ---
  Process {
    id: updateFocusedWindowProc
    running: false
    command: ["hyprctl", "activewindow", "-j"]

    stdout: StdioCollector {
      id: focusedCollector
      onStreamFinished: {
        try {
          const output = focusedCollector.text.trim()
          if (output.length === 0) {
            focusedWindow = "No window focused"
            return
          }

          const parsed = JSON.parse(output)
          if (parsed.title.length > Config.options.bar.maxCharLength) {
            const slicedString = parsed.title.slice(0, 20);
            focusedWindow = slicedString + "..." || "No window focused"
          } else {
            focusedWindow = parsed.title || "No window focused"
          }
        } catch (e) {
          focusedWindow = "No window focused"
        }
      }
    }
  }

  // --- FUNCTIONS ---
  function fetchWorkspaces() {
    fetchWorkspaceProc.running = true
  }

  function updateFocusedWindow() {
    updateFocusedWindowProc.running = true
  }
}
