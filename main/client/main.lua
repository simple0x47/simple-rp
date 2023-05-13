function readHtml()
    local file = fileOpen("client/files/index.html")

    if not file then
        outputDebugString("[MAIN] could not open index.html file", 2)
        return
    end

    local size = fileGetSize(file)
    local data = fileRead(file, size)
    fileClose(file)

    return data
end 

function onClientResourceStart()
    local browser = exports.ui:getWebBrowser()

    if not exports.ui:isWebBrowserDocumentReady() then
        addEventHandler("onClientBrowserDocumentReady", browser, function()
            outputDebugString("[MAIN] injecting html into browser on document ready")
            injectHtmlIntoBrowser()
        end)
        
        return
    end

    outputDebugString("[MAIN] injecting html into browser on resource start")
    injectHtmlIntoBrowser()
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function injectHtmlIntoBrowser()
    local html = readHtml()
    outputDebugString("[MAIN] html: " .. html)

    exports.ui:createLayer("main", 1, html, resourceRoot)
end