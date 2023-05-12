addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local browser = exports.ui:getWebBrowser()

        executeBrowserJavascript(browser, "document.getElementById('body').innerHTML='<button>ABCD</button>';")
    end)