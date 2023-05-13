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
end

function hideSignIn()
    exports.ui:deleteLayer(SIGN_IN_LAYER_NAME)
end