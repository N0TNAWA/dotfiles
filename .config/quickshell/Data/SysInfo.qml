pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

    property string uptimeText: "--:--"

    Process {
        id: uptimeProcess
        command: ["sh", "-c", "uptime -p | awk -F 'up ' '{print $2}'"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                uptimeText = this.text.trim();
                uptimeProcess.running = false;
            }
        }
    }

    Timer {
        interval: 60000 
        repeat: true
        onTriggered: updateSystemInfo()
    }

    Component.onCompleted: {
        uptimeProcess.running = true;
    }

    function updateSystemInfo() {
        uptimeProcess.running = true;
    }
    
    function suspend() {
        suspend.running = true;
    }
    function reboot() {
        reboot.running = true;
    }
    function poweroff() {
        poweroff.running = true;
    }

    function logout() {
        logout.running = true;
    }

    Process {
        id: suspend
        command: ["systemctl", "suspend"]
    }

    Process {
        id: reboot
        command: ["reboot"]
    }

    Process {
        id: poweroff
        command: ["systemctl", "poweroff"]
    }

    Process {
        id: logout
        command: ["hyprctl", "dispatch", "exit", "0"]
    }
}

