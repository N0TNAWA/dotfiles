pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  
  property var notificationData: []

  function fetchNotifications() {
    const rawPath = Settings.settings.notifData;
    
    let filePath;
    if (rawPath.startsWith("file://")) {
      filePath = rawPath; 
    } else if (rawPath.startsWith("/")) {
      filePath = "file://" + rawPath; 
    } else {
      filePath = Qt.resolvedUrl(rawPath);
    }
    
    const xhr = new XMLHttpRequest();
    xhr.open("GET", filePath);
    xhr.onreadystatechange = function() {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        
        if (xhr.status === 200 || xhr.status === 0) { 
          if (xhr.responseText.trim() === "") {
            console.log("Empty response received");
            return;
          }
          
          try {
            const parsed = JSON.parse(xhr.responseText);
            console.log("Successfully parsed JSON");              
            notificationData = parsed;
          } catch(e) {
            console.log("Failed to parse JSON from notification file:", e);
          }
        } else {
          console.log("Failed to load notification file. Status:", xhr.status);
          console.log("Status text:", xhr.statusText);
        }
      }
    }
    xhr.send();
  }

  function deleteNotifications(item) {
    const rawPath = Settings.settings.notifData;
    console.log("Raw path from settings:", rawPath);
    
    let filePath;
    if (rawPath.startsWith("file://")) {
      filePath = rawPath; 
    } else if (rawPath.startsWith("/")) {
      filePath = "file://" + rawPath; 
    } else {
      filePath = Qt.resolvedUrl(rawPath);
    }

    const xhr = new XMLHttpRequest();
    xhr.open("GET", filePath);
    xhr.onreadystatechange = function() {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        
        if (xhr.status === 200 || xhr.status === 0) { 
          if (xhr.responseText.trim() === "") {
            console.log("Empty response received");
            return;
          }
 
          try {
            const parsed = JSON.parse(xhr.responseText);            
            notificationData = parsed;
          } catch(e) {
            console.log("Failed to parse JSON from notification file:", e);
          }
        } else {
          console.log("Failed to load notification file. Status:", xhr.status);
          console.log("Status text:", xhr.statusText);
        }
      }
    }
    xhr.send()
  } 

}
