addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local browser = exports.ui:getWebBrowser()

        executeBrowserJavascript(browser, "document.getElementById('body').innerHTML='<div class=\"layer\" style=\"z-index: 1\"><h1 class=\"white\">1</h1></div><div class=\"layer\" style=\"z-index: 2\"><h1 class=\"grey\">2</h1></div>';")
    end)