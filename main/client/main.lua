addEvent("onClientClickTheButton", false)
addEventHandler("onClientClickTheButton", root,
    function()
        outputChatBox("You clicked the button!")
    end)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local browser = exports.ui:pushBrowser("http://mta/local/client/files/main/index.html")

        showCursor(true)
    end)