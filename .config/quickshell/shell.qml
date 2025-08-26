// @ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Io   // <-- for IpcHandler
import "./Modules/"

ShellRoot {
    id: root

    // both components exist; we just show/hide them
    Bar { id: bar; visible: true }
    Settings { id: settings; visible: false }

    // IPC: callable from outside via `qs ipc call shell <fn>`
    IpcHandler {
        target: "shell"
        function showBar(): void { bar.visible = true }
        function hideBar(): void { bar.visible = false }
        function toggleBar(): void { bar.visible = !bar.visible }

        function showSettings(): void { settings.visible = true }
        function hideSettings(): void { settings.visible = false }
        function toggleSettings(): void { settings.visible = !settings.visible }
    }
}
