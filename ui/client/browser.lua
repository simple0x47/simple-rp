function onStart()
    local browser = createBrowser(640, 480, true, false)

    addEventHandler("onClientBrowserCreated", browser, function()
        loadBrowserURL(browser, "http://mta/local/client/index.html")
    end)

    outputChatBox("Browser created")
end

addEventHandler("onClientResourceStart", root, onStart)
