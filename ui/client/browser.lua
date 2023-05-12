local screenWidth, screenHeight = guiGetScreenSize()
local browser = createBrowser(screenWidth, screenHeight, true, true)

addEventHandler("onClientBrowserCreated", browser, 
        function()
            loadBrowserURL(source, "http://mta/local/client/files/index.html")
            outputDebugString("[UI] browser created")
            focusBrowser(source)

            addEventHandler("onClientBrowserDocumentReady", source,
                function()
                    executeBrowserJavascript(source, "document.getElementById('container').innerHTML='<h1>Hello</h1><button>Whatsup</button>';")
                end)

            addEventHandler("onClientRender", root, renderWebBrowser)
        end)

function getWebBrowser()
    return browser
end

function renderWebBrowser()
    dxDrawImage(0, 0, screenWidth, screenHeight, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
end