pragma ComponentBehavior: Bound
pragma Singleton
import qs.modules.common
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  
  property var clipArray: []
  property var currentCopy: null 

  Process {
    id: loadClipboardProc
    running: false
    command: ["cliphist", "list"]

    stdout: StdioCollector {
      onStreamFinished: {
        clipArray = processClipboard(this.text)
      }
    }
  }

  Process {
    id: copyClipboardProc
    running: false
    command: [ "bash", "-c", "printf '%s' \"$1\" | cliphist decode | wl-copy", "_", currentCopy ]

    stdout: StdioCollector {
      onStreamFinished: {
        console.log("Copied to clipboard!")
      }
    }
  }

  Process {
    id: deleteClipboardProc
    running: false
    command: [ "bash", "-c", "printf '%s' cliphist wipe", ]
  }

  function loadClipboard() {
    loadClipboardProc.running = true
  }

  function copyClipboard() {
    copyClipboardProc.running = true
  }

  function deleteClipboard() {
    deleteClipboardProc.running = true
  }

  function setCopy(id) {
    if (currentCopy != id) {
      currentCopy = id
    }

    copyClipboard()
  }

  function processClipboard(text) {
    let entries = text
      .trim()
      .split(/\r?\n/)
      .map(line => { 
        const [id, data] = line.split("\t")
        return {
          id: Number(id),
          data,
          raw: line
        };
      });

    return entries
  }
}
