import "./modules/bar"
import "./modules/common"
import "./ii"

import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import Quickshell

ShellRoot {
  property bool enableBar: true

  LazyLoader { active: enableBar; component: Bar {} }
}
