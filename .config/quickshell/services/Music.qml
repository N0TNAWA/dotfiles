pragma Singleton
pragma ComponentBehavior: Bound
import qs.modules.common
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick

Singleton {
  id: media

  property var currentPlayer: null
  property real currentPosition: 0
  property int selectedPlayerIndex: 0
  property bool isPlaying: currentPlayer ? currentPlayer.isPlaying: false
  property string currentTrack: currentPlayer ? (currentPlayer.trackTitle || "Unknown Song"): ""
  property string currentArtist: currentPlayer ? (currentPlayer.trackArtist || "Unknown Artist"): ""
  property string currentAlbum: currentPlayer ? (currentPlayer.trackAlbum || "No Album"): ""
  property string currentArtUrl: currentPlayer ? (currentPlayer.trackArtUrl || ""): ""
  property real trackLength: currentPlayer ? currentPlayer.length : 0
  property bool canPlay: currentPlayer ? currentPlayer.canPlay : false
  property bool canPause: currentPlayer ? currentPlayer.canPause : false
  property bool canGoNext: currentPlayer ? currentPlayer.canGoNext : false
  property bool canGoPrevious: currentPlayer ? currentPlayer.canGoPrevious : false
  property bool canSeek: currentPlayer ? currentPlayer.canSeek : false
  property bool hasPlayer: getAvailablePlayer().length > 0

  Item {
    Component.onCompleted: {
      updateCurrentPlayer()
    }
  }

    // Returns available MPRIS players
  function getAvailablePlayer() {
    if (!Mpris.players || !Mpris.players.values) {
      return []
    }
    
    let allPlayers = Mpris.players.values
    let controllablePlayers = []
    
    for (let i = 0; i < allPlayers.length; i++) {
      let player = allPlayers[i]
      if (player && player.canControl && player.identity.toLowerCase().includes("spotify")) {
        controllablePlayers.push(player)
      }
    }
    
    return controllablePlayers
  }

  // Returns active player or first available
  function findPlayer() {
    let availablePlayers = getAvailablePlayer()
    if (availablePlayers.length === 0) {
      return null
    }

    // Use selected player if valid, otherwise use first available
    if (selectedPlayerIndex < availablePlayers.length) {
      console.log(availablePlayers.length)
      return availablePlayers[selectedPlayerIndex]
    } else {
      selectedPlayerIndex = 0
      return availablePlayers[0]
    }
  }

  // Updates currentPlayer and currentPosition
  function updateCurrentPlayer() {
    let newPlayer = findPlayer()
    if (newPlayer !== currentPlayer) {
      currentPlayer = newPlayer
      currentPosition = currentPlayer ? currentPlayer.position : 0
    }
  }

  // Player control functions
  function playPause() {
    if (currentPlayer) {
      if (currentPlayer.isPlaying) {
        currentPlayer.pause()
      } else {
        currentPlayer.play()
      }
    }
  }

  function play() {
    if (currentPlayer && currentPlayer.canPlay) {
      currentPlayer.play()
    }
  }

  function pause() {
    if (currentPlayer && currentPlayer.canPause) {
      currentPlayer.pause()
    }
  }

  function next() {
    if (currentPlayer && currentPlayer.canGoNext) {
      currentPlayer.next()
    }
  }

  function previous() {
    if (currentPlayer && currentPlayer.canGoPrevious) {
      currentPlayer.previous()
    }
  }

  function seek(position) {
    if (currentPlayer && currentPlayer.canSeek) {
      currentPlayer.position = position
      currentPosition = position
    }
  }

  function seekByRatio(ratio) {
    if (currentPlayer && currentPlayer.canSeek && currentPlayer.length > 0) {
      let seekPosition = ratio * currentPlayer.length
      currentPlayer.position = seekPosition
      currentPosition = seekPosition
    }
  }

  // Updates progress bar every second
  Timer {
    id: positionTimer
    interval: 1000
    running: currentPlayer && currentPlayer.isPlaying && currentPlayer.length > 0
    repeat: true
    onTriggered: {
      if (currentPlayer && currentPlayer.isPlaying) {
        currentPosition = currentPlayer.position
      }
    }
  }

  // Reacts to player list changes
  Connections {
    target: Mpris.players
    function onValuesChanged() {
      updateCurrentPlayer()
    }
  }
}
