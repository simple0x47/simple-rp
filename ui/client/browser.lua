local SCRIPT_TAG_START = "<script>"
local SCRIPT_TAG_FINISH = "</script>"

local screenWidth, screenHeight = guiGetScreenSize()
local browser = createBrowser(screenWidth, screenHeight, true, true)
local isDocumentReady = false
local isInputEnabled = false

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

local function executeJavascriptFromHtml(html)
    local start = string.find(html, SCRIPT_TAG_START)
    local finish = string.find(html, SCRIPT_TAG_FINISH)

    if not start or not finish then
        outputDebugString("Invalid javascript within html: " .. html, 2)
        return
    end

    local script = string.sub(html, start + string.len(SCRIPT_TAG_START), finish - 1)
    
    outputDebugString("Detected javascript within html: " .. script)
    executeBrowserJavascript(browser, script)
end

local function injectHtml(layerName, layerZIndex, html)
    executeBrowserJavascript(browser, "document.getElementById('body').innerHTML='<div id=\"" .. layerName .. "\" class=\"layer hidden-layer\" style=\"z-index: " .. layerZIndex .. "\"></div>';")

    -- 
    if string.find(html, "<script>") then
        executeJavascriptFromHtml(html)
    end

    executeBrowserJavascript(browser, "document.getElementById('" .. layerName .. "').innerHTML=`" .. html .. "`;")
    executeBrowserJavascript(browser, "document.getElementById('" .. layerName .. "').classList.add('visible-layer');")
end

--[[
    - layerName: string - unique identifier of the layer
    - layerZIndex: int - layer z-index
    - html: string - html content to be rendered within the layer
    - resource: resource - element of the resource creating the layer
]]
function createLayer(layerName, layerZIndex, html, resource)
    outputDebugString("[UI] createLayer: " .. layerName)

    -- delete layer when the creator resource is stopped
    addEventHandler("onClientResourceStop", resource,
    function()
        deleteLayer(layerName)
    end)

    if not isWebBrowserDocumentReady() then
        addEventHandler("onClientBrowserDocumentReady", browser,
            function()
                injectHtml(layerName, layerZIndex, html)
            end)
        return
    end

    injectHtml(layerName, layerZIndex, html)
end

local function injectHtmlRemoval(layerName)
    executeBrowserJavascript(browser, "document.getElementById('" .. layerName .. "').classList.remove('visible-layer');")

    -- remove the layer after 500ms
    setTimer(
        function()
            outputDebugString("[UI] removing layer: " .. layerName)
            executeBrowserJavascript(browser, "document.getElementById('" .. layerName .. "').remove();")
        end, 500, 1)
end

--[[
    - layerName: string - unique identifier of the layer
]]
function deleteLayer(layerName)
    outputDebugString("[UI] deleteLayer: " .. layerName)

    if not isWebBrowserDocumentReady() then
        addEventHandler("onClientBrowserDocumentReady", browser,
            function()
                injectHtmlRemoval(layerName)
            end)
            
        return
    end

    injectHtmlRemoval(layerName)
end

--[[
    - enableInput: boolean - true to enable input, false to disable input
]]
function setInputMode(enableInput)
    if isInputEnabled == enableInput then
        return
    end

    if enableInput then
        showCursor(true)
        addEventHandler("onClientClick", root, onClientClick)
        addEventHandler("onClientCursorMove", root, onClientCursorMove)
        addEventHandler("onClientKey", root, onClientKey)
        focusBrowser(browser)
        isInputEnabled = true
        return
    end

    showCursor(false)
    removeEventHandler("onClientClick", root, onClientClick)
    removeEventHandler("onClientCursorMove", root, onClientCursorMove)
    removeEventHandler("onClientKey", root, onClientKey)
    isInputEnabled = false
end

function onClientClick(button, state)
    if state == "down" then
        injectBrowserMouseDown(browser, button)
    else
        injectBrowserMouseUp(browser, button)
    end
end

function onClientCursorMove(relativeX, relativeY, absoluteX, absoluteY)
    injectBrowserMouseMove(browser, absoluteX, absoluteY)
end

function onClientKey(button)
    if button == "mouse_wheel_down" then
		injectBrowserMouseWheel(browser, -40, 0)
	elseif button == "mouse_wheel_up" then
		injectBrowserMouseWheel(browser, 40, 0)
	end
end

addCommandHandler("devmode",
    function()
        setDevelopmentMode(true, true)
    end
)