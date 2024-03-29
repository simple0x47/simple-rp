local SIGN_IN_LAYER_NAME = "main:sign_in"

--[[
    - username: string
    - password: string
    - rememberMe: boolean
]]
addEvent("main:onSignInSubmit", false)

addEvent("main:onSignInSwitchToSignUp", false)

--[[
    - success: boolean
    - data: table
]]
addEvent("main:onSignInResult", true)

local function readSignInViewHtml()
    local file = fileOpen("client/views/sign_in.html")

    if not file then
        outputDebugString("[MAIN] could not open sign_in.html file", 2)
        return nil
    end

    local size = fileGetSize(file)
    local data = fileRead(file, size)
    fileClose(file)

    return data
end

function showSignIn()
    local view = readSignInViewHtml()

    if not view then
        return
    end

    exports.ui:createLayer(SIGN_IN_LAYER_NAME, 5, view, resourceRoot)

    local browser = exports.ui:getWebBrowser()
    
    addEventHandler("main:onSignInSubmit", browser, onSignInSubmit)
    addEventHandler("main:onSignInSwitchToSignUp", browser, onSignInSwitchToSignUp)

    exports.ui:setInputMode(true)
end

function hideSignIn()
    exports.ui:deleteLayer(SIGN_IN_LAYER_NAME)

    local browser = exports.ui:getWebBrowser()
    
    removeEventHandler("main:onSignInSubmit", browser, onSignInSubmit)
    removeEventHandler("main:onSignInSwitchToSignUp", browser, onSignInSwitchToSignUp)

    exports.ui:setInputMode(false)
end

function onSignInSubmit(username, password, rememberMe)
    rememberMe = rememberMe == 1

    triggerServerEvent("main:onTrySignIn", getLocalPlayer(), username, password, rememberMe)

    addEventHandler("main:onSignInResult", root, onSignInResult)
end

function onSignInResult(success, data)
    removeEventHandler("main:onSignInResult", root, onSignInResult)

    local webBrowser = exports.ui:getWebBrowser()

    if not success then
        executeBrowserJavascript(webBrowser, "signInFailure();")
        return
    end

    executeBrowserJavascript(webBrowser, "signInSuccess();")
    hideSignIn()
end

function onSignInSwitchToSignUp()
end