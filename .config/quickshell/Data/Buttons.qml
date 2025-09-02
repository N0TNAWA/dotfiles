pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
  id: root
  property bool lightMode: true 
  property string currentTheme: lightMode ? "" : ""
  
  Component.onCompleted: {
    console.log("Component.onCompleted running...")
    themeTimer.start()
  }
  
  property Timer themeTimer: Timer {
    interval: 1000  
    running: false
    repeat: true
    
    onTriggered: {
      if (!themeChecker.running) {  
        var scriptPath = Qt.resolvedUrl("../Scripts/lightMode.sh").toString()
        if (scriptPath.startsWith("file://")) {
          scriptPath = scriptPath.substring(7)
        }
        themeChecker.command = ["bash", scriptPath]
        themeChecker.running = true
      }
    }
  }
  
  function changeTheme() {
    console.log("changeTheme() called")
    var scriptPath = Qt.resolvedUrl("../Scripts/lightMode.sh").toString()
    if (scriptPath.startsWith("file://")) {
      scriptPath = scriptPath.substring(7) 
    }
    console.log("Script path:", scriptPath)
    changer.command = ["bash", scriptPath, "toggle"]
    changer.running = true
  }
  
  property Process themeChecker: Process {
    running: false
    
    stdout: StdioCollector {
      onStreamFinished: {
        console.log("Initial theme check output:", text)
        const v = text.trim()
        if (v === "0") {
          console.log("Setting initial lightMode to false (dark)")
          root.lightMode = false
        } else if (v === "1") {
          console.log("Setting initial lightMode to true (light)")
          root.lightMode = true
        }
        console.log("Final initial lightMode value:", root.lightMode)
        themeChecker.running = false
      }
    }
    
    stderr: StdioCollector {
      onStreamFinished: {
        if (text.trim() !== "") {
          console.log("Theme checker stderr:", text)
        }
      }
    }
  }
  
  property Process changer: Process {
    running: false
    
    onRunningChanged: console.log("Process running:", running)
    onExited: function(exitCode) { console.log("Process exited with code:", exitCode) }
    
    stdout: StdioCollector {
      onStreamFinished: {
        console.log("Process stdout:", text)
        const v = text.trim()
        if (v === "0") {
          root.lightMode = false
        } else if (v === "1") {
          root.lightMode = true
        }
        changer.running = false
      }
    }
    
    stderr: StdioCollector {
      onStreamFinished: {
        console.log("Process stderr:", text)
      }
    }
  }
}
