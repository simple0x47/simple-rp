local screenWidth, screenHeight = guiGetScreenSize()
local browser = nil
local isDocumentReady = false

function onClientResourceStart()
    browser = createBrowser(screenWidth, screenHeight, true, true)
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function onClientBrowserCreated()
    loadBrowserURL(source, "http://mta/local/client/files/index.html")
    outputDebugString("[UI] browser created")
    focusBrowser(source)

    addEventHandler("onClientBrowserDocumentReady", source,
        function()
            outputDebugString("[UI] browser document ready")
            isDocumentReady = true
        end)

    addEventHandler("onClientRender", root, renderWebBrowser)
end
addEventHandler("onClientBrowserCreated", browser, onClientBrowserCreated)

function getWebBrowser()
    return browser
end

function isWebBrowserDocumentReady()
    return isDocumentReady
end

function renderWebBrowser()
    dxDrawImage(0, 0, screenWidth, screenHeight, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
end