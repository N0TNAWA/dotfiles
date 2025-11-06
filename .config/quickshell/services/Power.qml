// systemControls.qml
pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    Process {
        id: powerOffProc
        command: ["systemctl", "poweroff"]
    }

    Process {
        id: rebootProc
        command: ["systemctl", "reboot"]
    }

    Process {
        id: lockProc
        command: ["hyprlock"]
    }

    Process {
        id: exitProc
        command: ["hyprctl", "dispatch", "exit", "0"]
    }

    function powerOff() {
        powerOffProc.running = true
    }

    function reboot() {
        rebootProc.running = true
    }

    function lock() {
        lockProc.running = true
    }

    function exitHyprland() {
        exitProc.running = true
    }
}
