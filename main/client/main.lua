addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local browser = exports.ui:getWebBrowser()

        executeBrowserJavascript(browser, "document.getElementById('body').innerHtml='<h1>Hello</h1><button>Whatsup</button>';")
    end)