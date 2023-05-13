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
            injectHtmlIntoBrowser(source)
        end)
        
        return
    end

    outputDebugString("[MAIN] injecting html into browser on resource start")
    injectHtmlIntoBrowser(browser)
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function injectHtmlIntoBrowser(browser)
    local html = readHtml()
    outputDebugString("[MAIN] html: " .. html)

    exports.ui:createLayer("main", browser, html, resourceRoot)
end