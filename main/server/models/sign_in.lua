--[[
    - username: string
    - password: string
    - rememberMe: boolean
]]
addEvent("main:onTrySignIn", true)

function onTrySignIn(username, password, rememberMe)
    triggerClientEvent(source, "main:onSignInResult", false, { error = "Not implemented" })
end
addEventHandler("main:onTrySignIn", root, onTrySignIn)
