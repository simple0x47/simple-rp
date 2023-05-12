function onStart()
    createBrowser(640, 480, true, true)
    outputChatBox("Browser created")
end

addEventHandler("onClientResourceStart", root, onStart)
