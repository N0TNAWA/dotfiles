pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.Data
import qs.Widgets

Singleton {
  property bool isDnd: false
  property string state: ""

  Component.onCompleted: {
    checkDndProc.running = true;
  }

  function checkDnd() {
    checkDndProc.running = true;
  }

  function changeDnd() {
    changeDndProc.running = true;
  }

  Process {
    id: changeDndProc
    command: ["/home/nawa/.config/quickshell/Scripts/dnd.sh", "-t"]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        changeDndProc.running = false;
        changeDndProc.running = false;
        checkDnd();
      }
    }
  }

  Process {
    id: checkDndProc
    command: ["/home/nawa/.config/quickshell/Scripts/dnd.sh", "-c"]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        state = this.text.trim();
        isDnd = (state === "true");
        console.log(isDnd);
        checkDndProc.running = false;
      }
    }
  }
}
