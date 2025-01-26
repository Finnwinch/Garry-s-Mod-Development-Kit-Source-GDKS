if ( SERVER or CLIENT ) then
	GDKS = {}
	GDKS.DEV = true
end

if ( SERVER ) then
	include("server/network.lua")
	AddCSLuaFile("client/network.lua")
	include("shared/util.lua")
	AddCSLuaFile("shared/util.lua")
end
if ( CLIENT ) then
	include("client/network.lua")
	include("shared/util.lua")
end