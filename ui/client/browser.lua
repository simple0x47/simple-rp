local screenWidth, screenHeight = guiGetScreenSize()
local browserStack = {}

function pushBrowser(url)
    local browser = createBrowser(screenWidth, screenHeight, true, true)

    addEventHandler("onClientBrowserCreated", browser, 
        function()
            outputChatBox("Loading url: " .. url)
            loadBrowserURL(source, url)
        end)

    if #browserStack == 1 then
        outputChatBox("Adding render handler")
        addEventHandler("onClientRender", root, renderWebBrowsers)
    end

    browserStack[#browserStack + 1] = browser
    return true
end

function popBrowser()
    if #browserStack == 0 then
        return false
    end

    local browser = browserStack[#browserStack]
    browserStack[#browserStack] = nil
    destroyElement(browser)

    if #browserStack == 0 then
        outputChatBox("Removing render handler")
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
    for i = 1, #browserStack do
        local browser = browserStack[i]
        outputChatBox("Rendering browser: " .. tostring(browser))
        dxDrawImage(0, 0, screenWidth, screenHeight, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
    end
end