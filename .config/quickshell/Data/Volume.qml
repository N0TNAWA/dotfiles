pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import qs.Data
import qs.Widgets

Singleton {
  id: audio

  // Current default devices (PwNode or null)
  property var defaultOutput: Pipewire.defaultAudioSink
  property var defaultInput:  Pipewire.defaultAudioSource

  // Bind nodes so audio.volume / audio.muted become valid & writable
  PwObjectTracker {
    id: tracker
    objects: [ audio.defaultOutput, audio.defaultInput ]
  }

  // Read-only convenience bindings (fall back safely)
  readonly property real sinkVolume:
    defaultOutput && defaultOutput.audio ? defaultOutput.audio.volume : 0.0
  readonly property real sourceVolume:
    defaultInput  && defaultInput.audio  ? defaultInput.audio.volume  : 0.0

  readonly property bool sinkMuted:
    defaultOutput && defaultOutput.audio ? defaultOutput.audio.muted : false
  readonly property bool sourceMuted:
    defaultInput  && defaultInput.audio  ? defaultInput.audio.muted  : false

  // Helpers to mutate state
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

  // Optional: steer which node should be the default
  function setPreferredDefaultSink(node) { Pipewire.preferredDefaultAudioSink = node }
  function setPreferredDefaultSource(node){ Pipewire.preferredDefaultAudioSource = node }
}
