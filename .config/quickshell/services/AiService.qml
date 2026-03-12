import qs.modules.common
import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: aiService


    property var chatMessages: []
    property string latestMessage
    property string chatName

    Process {
        id: postProcess
        running: false
        command:["python3", "/home/nawa/.config/quickshell/backends/ai_backend/model/model.py", Config.options.ai.activeConversation, latestMessage]

        stdout: StdioCollector {
            onTextChanged: {
                console.log("PYTHON STDOUT:", text)
            }

        onStreamFinished: {
                console.log("Process finished")
                loadChat()
            }
        }

        stderr: StdioCollector {
            onTextChanged: {
                console.log("PYTHON STDERR:", text)
            }
        }
    
    }

    Process {
        id: addChatProcess
        running: false
        command:["python3", "/home/nawa/.config/quickshell/backends/ai_backend/model/addChat.py", chatName]

        stdout: StdioCollector {
            onTextChanged: {
                console.log("PYTHON STDOUT:", text)
            }

        onStreamFinished: {
                console.log("Created new chat")
                getConversations()
            }
        }

        stderr: StdioCollector {
            onTextChanged: {
                console.log("PYTHON STDERR:", text)
            }
        }
    
    }

    function postFunction(message) {
        latestMessage = message
        postProcess.running = true
    }

    function addChat(name) {
        chatName = name
        addChatProcess.running = true
    }

    FolderListModel {
        id: logsFolder
        folder: Config.options.ai.logsPath
        showDirs: false
        nameFilters: ["*"]

        onStatusChanged: {
            if (status === FolderListModel.Ready) {
                getConversations()
            }
        }
    }

    function getConversations() {
        let newList = []

        for (let i = 0; i < logsFolder.count; i++) {
            newList.push(logsFolder.get(i, "filePath"))
        }

        Config.options.ai.conversations = newList

        console.log("Chats:", Config.options.ai.conversations)
    }

    function openChat(index) {
        Config.options.ai.activeConversation = Config.options.ai.conversations[index].split("/").pop()
        console.log("Switched chat to: ", `${Config.options.ai.activeConversation}`)

        loadChat()
    }

    function loadChat() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", `file:///home/nawa/.config/quickshell/tmp/logs/${Config.options.ai.activeConversation}`)

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    let data = JSON.parse(xhr.responseText)
                    console.log(data)
                    chatMessages = data || []
                } else {
                    chatMessages = []
                }
            }
        }

        xhr.send()
    }
}