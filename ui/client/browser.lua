local screenWidth, screenHeight = guiGetScreenSize()
local browserStack = {}

function pushBrowser()
    local browser = createBrowser(screenWidth, screenHeight, true, true)

    if #browserStack == 1 then
        addEventHandler("onClientRender", root, renderWebBrowsers)
    end

    browserStack[#browserStack + 1] = browser
    return browser
end

function popBrowser()
    if #browserStack == 0 then
        return nil
    end

    local browser = browserStack[#browserStack]
    browserStack[#browserStack] = nil

    if #browserStack == 0 then
        removeEventHandler("onClientRender", root, renderWebBrowsers)
    end

    return browser
end

function removeBrowser(browser)
    if browser == nil then
        return nil
    end

    for i = 1, #browserStack do
        if browserStack[i] == browser then
            browserStack[i] = browserStack[#browserStack]
            return popBrowser()
        end
    end

    return nil
end

function renderWebBrowsers()
    for i = 1, #browserStack do
        local browser = browserStack[i]
        dxDrawImage(0, 0, screenWidth, screenHeight, browser, 0, 0, 0, tocolor(255, 255, 255, 255), true)
    end
end