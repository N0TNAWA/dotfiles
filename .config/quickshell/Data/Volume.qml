pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import qs.Data
import qs.Widgets

Singleton {
  id: audio

  property var defaultOutput: Pipewire.defaultAudioSink
  property var defaultInput:  Pipewire.defaultAudioSource

  PwObjectTracker {
    id: tracker
    objects: [ audio.defaultOutput, audio.defaultInput ]
  }

  readonly property real sinkVolume:
    defaultOutput && defaultOutput.audio ? defaultOutput.audio.volume : 0.0
  readonly property real sourceVolume:
    defaultInput  && defaultInput.audio  ? defaultInput.audio.volume  : 0.0

  readonly property bool sinkMuted:
    defaultOutput && defaultOutput.audio ? defaultOutput.audio.muted : false
  readonly property bool sourceMuted:
    defaultInput  && defaultInput.audio  ? defaultInput.audio.muted  : false

  function setSinkVolume(v) {
    if (defaultOutput && defaultOutput.audio)
      defaultOutput.audio.volume = Math.max(0, Math.min(1, v));
  }
  function setSourceVolume(v) {
    if (defaultInput && defaultInput.audio)
      defaultInput.audio.volume = Math.max(0, Math.min(1, v));
  }
  function toggleSinkMute() {
    if (defaultOutput && defaultOutput.audio)
      defaultOutput.audio.muted = !defaultOutput.audio.muted;
  }
  function toggleSourceMute() {
    if (defaultInput && defaultInput.audio)
      defaultInput.audio.muted = !defaultInput.audio.muted;
  }

  function setPreferredDefaultSink(node) { Pipewire.preferredDefaultAudioSink = node }
  function setPreferredDefaultSource(node){ Pipewire.preferredDefaultAudioSource = node }
}
