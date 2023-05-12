local screenWidth, screenHeight = guiGetScreenSize()
local browser = createBrowser(screenWidth, screenHeight, true, true)

addEventHandler("onClientBrowserCreated", browser, 
        function()
            loadBrowserURL(source, "http://mta/local/client/files/index.html")
            focusBrowser(source)
            addEventHandler("onClientRender", root, renderWebBrowser)
        end)

function getWebBrowser()
    return browser
end

function renderWebBrowser()
    for i = 1, #browserStack do
        dxDrawImage(0, 0, screenWidth, screenHeight, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
    end
end