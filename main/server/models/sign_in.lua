--[[
    - username: string
    - password: string
    - rememberMe: boolean
]]
addEvent("main:onTrySignIn", true)

function onTrySignIn(username, password, rememberMe)
    triggerClientEvent(source, "main:onSignInResult", source, false, { error = "Not implemented" })
end
addEventHandler("main:onTrySignIn", root, onTrySignIn)
