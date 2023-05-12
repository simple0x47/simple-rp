function onStart()
    local width, height = guiGetScreenSize()
    local browser = createBrowser(width, height, true, false)

    addEventHandler("onClientBrowserCreated", browser, function()
        loadBrowserURL(source, "http://mta/local/client/index.html")
        outputChatBox("Loaded URL")
    end)

    outputChatBox("Browser created")
end

addEventHandler("onClientResourceStart", root, onStart)
