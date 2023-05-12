function onStart()
    local browser = createBrowser(640, 480, true, true)

    browser.loadURL("http://mta/local/client/index.html")
    outputChatBox("Browser created")
end

addEventHandler("onClientResourceStart", root, onStart)
