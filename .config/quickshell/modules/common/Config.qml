pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property alias options: configOptionsJsonAdapter
  property bool ready: false
  property int readWriteDelay: 50
  property bool blockWrites: false

  function setNestedValue(nestedKey, value) {
    let keys = nestedKey.split(".");
    let obj = root.options;
    let parents = [obj];

    for (let i = 0; i < keys.length - 1; ++i) {
      if (!obj[keys[i]] || typeof obj[keys[i]] !== "object") {
        obj[keys[i]] = {};
      }
      obj = obj[keys[i]];
      parents.push(obj);
    }

    let convertedValue = value;
    if (typeof value === "string") {
      let trimmed = value.trim();
      if (trimmed === "true" || trimmed === "false" || !isNaN(Number(trimmed))) {
        try {
          convertedValue = JSON.parse(trimmed);
        } catch (e) {
          convertedValue = value;
        }
      }
    }

    obj[keys[keys.length - 1]] = convertedValue;
  }

  Timer {
    id: fileReloadTimer
    interval: root.readWriteDelay
    repeat: false
    onTriggered: {
      configFileView.reload()
    }
  }

  Timer {
    id: fileWriteTimer
    interval: root.readWriteDelay
    repeat: false
    onTriggered: {
      configFileView.writeAdapter()
    }
  }

  FileView {
    id: configFileView
    path: root.filePath
    watchChanges: true
    blockWrites: root.blockWrites
    onFileChanged: fileReloadTimer.restart()
    onAdapterUpdated: fileWriteTimer.restart()
    onLoaded: root.ready = true
    onLoadFailed: error => {
        if (error == FileViewError.FileNotFound) {
            writeAdapter();
        }
    }

    JsonAdapter {
      id: configOptionsJsonAdapter

      property JsonObject bar: JsonObject {
        property int barHeight: 45
        property int maxCharLength: 20
        property bool calendarVisible: false  // false| Only clock true| Clock and calendar
        property bool allUpdatesVisible: true // false| pacman  true| pacman, aur and flatpak
        property bool barGroupBackground: true

        property JsonObject workspaces: JsonObject {

        }

        property JsonObject power: JsonObject {
          property bool togglePowerOptions: false
        }
      }

      property JsonObject time: JsonObject {
        property string format: "  hh:mm" 
        property string dateFormat: "dd/MM" 
      }

      property JsonObject update: JsonObject {
        property string format: "󰮯  "
      }


      property JsonObject music: JsonObject {
        property JsonObject services: JsonObject {
          property string spotify: "qs::service::mpris::MprisPlayer(0x7f5f63d03800)"
        }
      }
    }
  }
}

