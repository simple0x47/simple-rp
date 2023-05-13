local screenWidth, screenHeight = guiGetScreenSize()
local browser = createBrowser(screenWidth, screenHeight, true, true)
local isDocumentReady = false

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

--[[
    - layerName: string - unique identifier of the layer
    - layerZIndex: int - layer z-index
    - html: string - html content to be rendered within the layer
    - resource: resource - element of the resource creating the layer
]]
function createLayer(layerName, layerZIndex, html, resource)
    if not isWebBrowserDocumentReady() then
        return
    end

    executeBrowserJavascript(browser, "document.getElementById('body').innerHTML='<div id=\"" .. layerName .. "\" class=\"layer\" style=\"z-index: " .. layerZIndex .. "\"></div>';")
    executeBrowserJavascript(browser, "document.getElementById('" .. layerName .. "').innerHTML=`" .. html .. "`;")

    outputDebugString("[UI] createLayer: " .. layerName)
    -- delete layer when the creator resource is stopped
    addEventHandler("onClientResourceStop", resource,
        function()
            deleteLayer(layerName)
        end)
end

--[[
    - layerName: string - unique identifier of the layer
]]
function deleteLayer(layerName)
    if not isWebBrowserDocumentReady() then
        return
    end

    outputDebugString("[UI] deleteLayer: " .. layerName)
    executeBrowserJavascript(browser, "document.getElementById('" .. layerName .. "').remove();")
end