addEventHandler("onClientResourceStart", resourceRoot,
    function()
        exports.ui:pushBrowser("http://mta/local/client/index.html")
    end)