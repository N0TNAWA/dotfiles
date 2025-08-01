// @ pragma UseQApplication

import QtQuick
import Quickshell
import "./Bar/"

ShellRoot {
    id: root


    Loader {
        active: true
        sourceComponent: Bar {}
    }
}
