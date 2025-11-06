#!/bin/bash

WAL_COLORS="$HOME/.cache/wal/colors.json"
QML_COLORS="$HOME/.config/quickshell/modules/common/Colors.qml"  # Match your import

mkdir -p "$(dirname "$QML_COLORS")"

{
    echo "pragma Singleton"
    echo "pragma ComponentBehavior: Bound"
    echo "import Quickshell"
    echo "import QtQuick"
    echo ""
    echo "Singleton {"
    echo "  id: root"
    echo "  property QtObject colors"
    echo ""
    echo "  colors: QtObject {"
    jq -r '.colors | to_entries[] | "     property color \(.key): \"\(.value)\""' "$WAL_COLORS"
    echo "  }"
    echo "}"
} > "$QML_COLORS"
