pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

    property string shellName: "quickshell"
    property string settingsDir: Quickshell.env("HOME") + "/.config/" + shellName + "/Tmp/"
    property string settingsFile: settingsDir + "Settings.json"
    property var settings: settingAdapter

    Item {
        Component.onCompleted: {
            // ensure settings dir
            Quickshell.execDetached(["mkdir", "-p", settingsDir]);
        }
    }

    FileView {
        id: settingFileView
        path: settingsFile
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        Component.onCompleted: function() {
            reload()
        }
        JsonAdapter {
            id: settingAdapter
            property string profileImage: Quickshell.env("HOME") + "/.face"
            property string user: "NaWa"
            property string fontFam: "CaskaydiaMono Nerd Font"
            property string notifData: Qt.resolvedUrl("file:///home/nawa/.cache/notifications.json")
            property string chatData: Qt.resolvedUrl("file:///home/nawa/.cache/chat.json")
            property string currentWallpaper: Quickshell.env("HOME") + "/.cache/mineral/wallpaper.png"
            property string srcDir: Quickshell.env("Home") + "/.config/hypr/scripts/"
        }
    }
}
