pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: notification

    property bool dndState: true
    property string dndStateTxt: ""
    
    Process {
        id: toggleNotifProc
        running: false
        command: ["dunstctl", "set-paused", "toggle"]

        stdout: StdioCollector {
            onStreamFinished: {
                console.log("Toggled notification")
                statusNotifProc.running = true
            }
        }
    
    }

    Process {
        id: statusNotifProc
        running: false
        command: ["dunstctl", "is-paused"]

        stdout: StdioCollector {
            onStreamFinished: {
                dndStateTxt = text.trim()
                console.log("Do not disturb status:", dndStateTxt)

                if (dndStateTxt == "true") {
                    dndState = true
                } else {
                    dndState = false
                }
            }
        }
    }

    function toggleNotif() {
        toggleNotifProc.running = true
    }

    function statusNotif() {
        statusNotifProc.running = true
    }

}