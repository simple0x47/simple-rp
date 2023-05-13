function readHtml()
    local file = fileOpen("files/index.html")
    if not file then
        outputDebugString("[MAIN] could not open index.html file", 2)
    end

    local size = fileGetSize(file)
    local data = fileRead(file, size)
    fileClose(file)

    return data
end 

function onClientResourceStart()
    local browser = exports.ui:getWebBrowser()

    if not isWebBrowserDocumentReady then
        addEventHandler("onClientBrowserDocumentReady", browser, function()
            injectHtmlIntoBrowser(source)
        end)
        
        return
    end

    injectHtmlIntoBrowser(browser)
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function injectHtmlIntoBrowser(browser)
    local html = readHtml()

    executeBrowserJavascript(browser, "document.getElementById('body').innerHTML='" .. html .. "';")
end