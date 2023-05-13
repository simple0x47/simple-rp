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