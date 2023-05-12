local width, height = guiGetScreenSize()
local browser = createBrowser(width, height, true, true)

function webBrowserRender()
    dxDrawImage(0, 0, width, height, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

addEventHandler("onClientBrowserCreated", browser,
    function()
        loadBrowserURL(browser, "http://mta/local/client/index.html")
        addEventHandler("onClientRender", root, webBrowserRender)
    end
)
