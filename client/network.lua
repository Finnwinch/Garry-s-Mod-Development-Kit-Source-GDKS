local netData = {name=nil,data={}}
function netData:write(data)
    local package = "@"
    local serialisation = function(tableToSerial, parentKey)
        for key, value in pairs(tableToSerial) do
            local fullKey = parentKey and (parentKey .. "." .. key) or key
            if type(value) == "table" then
                serialisation(value, fullKey)
            else
                package = package .. fullKey .. "$" .. tostring(value) .. "@"
            end
        end
    end
    serialisation(data or {})
    package = util.Compress(package)
    local size = #package
    net.Start(self.name)
        net.WriteUInt(size,16)
        net.WriteData(package,size)
    net.SendToServer()
end
function netData:read(callback)
    net.Receive(self.name,function(len,ply)
        local data,args = util.Decompress(net.ReadData(net.ReadUInt(16))), {}
        for _, data in ipairs(string.Split(data,"@")) do
            if (#data == 0) then continue end
            local decompile = string.Split(data,"$")
            args[decompile[1]] = decompile[2]
        end
        self.data = args
        callback(len,ply)
    end)
end
function netData:get(datakey)
    return self.data[datakey]
end
local netMeta = {
    __call = function(self,name)
        local instance = setmetatable({},{__index = self})
        instance.name = name
        return instance
    end
}
GDKS.NET = setmetatable(netData,netMeta)
if (GDKS.DEV) then
    MsgC(
    Color(255,196,0),
    "\n[GDKS]",
    Color(255,0,0),
    " load network",
    Color(255,196,0),
    " CLIENT\n\n"
)
end