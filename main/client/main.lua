addEvent("onClientClickTheButton", false)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local browser = exports.ui:pushBrowser("http://mta/local/client/files/main/index.html")

        addEventHandler("onClientClickTheButton", browser, function()
            outputChatBox("You clicked the button!")
        end)

        showCursor(true)
    end)