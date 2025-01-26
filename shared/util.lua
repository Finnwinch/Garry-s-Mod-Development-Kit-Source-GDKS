GDKS.FORMAT = function(message) --GDKS.FORMAT("hello {varOfMyName}") -- hello Finnwinch
    local env = {}
    local i = 1
    while true do
        local name, value = debug.getlocal(2, i)
        if not name then break end
        env[name] = value
        i = i + 1
    end
    
    message = message:gsub("{(.-)}", function(key)
        return tostring(env[key] or _G[key] or "{" .. key .. "}")
    end)
    
    return message
end