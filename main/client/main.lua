addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local browser = exports.ui:pushBrowser("http://mta/local/client/files/main/index.html")
    end)