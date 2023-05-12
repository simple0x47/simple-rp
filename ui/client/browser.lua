local screenWidth, screenHeight = guiGetScreenSize()
local browser = createBrowser(screenWidth, screenHeight, true, true)
local isDocumentReady = false

addEventHandler("onClientBrowserCreated", browser, 
        function()
            loadBrowserURL(source, "http://mta/local/client/files/index.html")
            outputDebugString("[UI] browser created")
            focusBrowser(source)

            addEventHandler("onClientBrowserDocumentReady", source,
                function()
                    outputDebugString("[UI] browser document ready")
                    isDocumentReady = true
                end)

            addEventHandler("onClientRender", root, renderWebBrowser)
        end)

function getWebBrowser()
    return browser
end

function isWebBrowserDocumentReady()
    return isDocumentReady
end

function renderWebBrowser()
    dxDrawImage(0, 0, screenWidth, screenHeight, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
end