addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local browser = exports.ui:pushBrowser("http://mta/main/client/files/main/index.html")

        showCursor(true)
    end)