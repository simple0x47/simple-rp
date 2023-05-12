local width, height = guiGetScreenSize()
local browser = createBrowser(width, height, true, false)

addEventHandler("onClientBrowserCreated", browser, function()
    loadBrowserURL(source, "http://mta/local/client/index.html")
    outputChatBox("Loaded URL")
end)

function webBrowserRender()
    --Render the browser on the full size of the screen.
    dxDrawImage(0, 0, width, height, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

--The event onClientBrowserCreated will be triggered, after the browser has been initialized.
--After this event has been triggered, we will be able to load our URL and start drawing.
addEventHandler("onClientBrowserCreated", browser,
    function()
        --After the browser has been initialized, we can load our file.
        loadBrowserURL(browser, "http://mta/local/html/site.html")
        --Now we can start to render the browser.
        addEventHandler("onClientRender", root, webBrowserRender)
    end
)
