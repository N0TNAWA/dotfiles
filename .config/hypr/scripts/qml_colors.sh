#!/bin/bash

WAL_COLORS="$HOME/.cache/wal/colors.json"
QML_COLORS="$HOME/.config/quickshell/Data/Wal.qml"  # Match your import

mkdir -p "$(dirname "$QML_COLORS")"

{
    echo "pragma Singleton"
    echo "import Quickshell"
    echo "import QtQuick 2.0"
    echo ""
    echo "QtObject {"
    jq -r '.colors | to_entries[] | "   readonly property color \(.key): \"\(.value)\""' "$WAL_COLORS"
    echo ""
    echo "  function withAlpha(color: color, alpha: real): color {"
    echo "    return Qt.rgba(color.r, color.g, color.b, alpha);"
    echo "  }"
    echo "}"
} > "$QML_COLORS"
