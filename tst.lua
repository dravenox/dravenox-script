local drvnx = {}

drvnx.hook = AddHook
drvnx.getExtra = getExtraTile
drvnx.getTiles = getTile
drvnx.getTile = checkTile
drvnx.getItem = getItemByID
drvnx.getObjects = getWorldObject

drvnx.log = function(str)
		logToConsole(str)
end 

drvnx.warp = function(name)
		sendPacket(
			3, 'action|join_request\nname|'.. name ..'\ninvitedWorld|0'
		)
end 

drvnx.write = function(str_f, data)
		local x = io.open('/storage/emulated/0/Android/media/GENTAHAX/'.. str_f ..'.txt', 'a')
		x:write(data ..'\n')
		x:close()
end

return drvnx
