local screenWidth, screenHeight = guiGetScreenSize()
local browserStack = {}

function pushBrowser(url)
    local guiBrowser = guiCreateBrowser(screenWidth, screenHeight, true, true, false, nil)
    local browser = guiGetBrowser(guiBrowser)

    addEventHandler("onClientBrowserCreated", browser, 
        function()
            outputDebugString("[UI] loading url: " .. url, 3)
            loadBrowserURL(source, url)
        end)

    browserStack[#browserStack + 1] = browser

    if #browserStack == 1 then
        outputDebugString("[UI] adding render handler", 3)
        addEventHandler("onClientRender", root, renderWebBrowsers)
    end

    focusBrowser(browser)

    return browser
end

local function popBrowser()
    if #browserStack == 0 then
        return false
    end

    local browser = browserStack[#browserStack]
    browserStack[#browserStack] = nil
    destroyElement(browser)

    if #browserStack == 0 then
        outputDebugString("[UI] removing render handler", 3)
        removeEventHandler("onClientRender", root, renderWebBrowsers)
    end

    return true
end

function removeBrowser(browser)
    if browser == nil then
        return false
    end

    for i = 1, #browserStack do
        if browserStack[i] == browser then
            browserStack[i] = browserStack[#browserStack]
            return popBrowser()
        end
    end

    return false
end

function renderWebBrowsers()
    
end