--[[
    - username: string
    - password: string
    - rememberMe: boolean
]]
addEvent("main:onSignInSubmit", false)

addEvent("main:onSignInSwitchToSignUp", false)

local SIGN_IN_LAYER_NAME = "main:sign_in"

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
    
    addEventHandler("main:onSignInRememberMe", browser, onSignInRememberMe)
    addEventHandler("main:onSignInSubmit", browser, onSignInSubmit)
    addEventHandler("main:onSignInSwitchToSignUp", browser, onSignInSwitchToSignUp)

    exports.ui:setInputMode(true)
end

function hideSignIn()
    exports.ui:deleteLayer(SIGN_IN_LAYER_NAME)

    local browser = exports.ui:getWebBrowser()
    removeEventHandler("main:onSignInRememberMe", browser, onSignInRememberMe)
    removeEventHandler("main:onSignInSubmit", browser, onSignInSubmit)
    removeEventHandler("main:onSignInSwitchToSignUp", browser, onSignInSwitchToSignUp)
end

function onSignInRememberMe(rememberMe)
    outputDebugString("Remember me: " .. rememberMe)
end

function onSignInSubmit(username, password)
    outputDebugString("Username: " .. username .. ", password: " .. password)
end

function onSignInSwitchToSignUp()
    outputDebugString("Switch to sign up")
end