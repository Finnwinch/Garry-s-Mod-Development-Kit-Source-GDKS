if ( SERVER or CLIENT ) then
	GDKS = {}
	GDKS.DEV = true
end

if ( SERVER ) then
	include("server/network.lua")
	AddCSLuaFile("client/network.lua")
end
if ( CLIENT ) then
	include("client/network.lua")
end