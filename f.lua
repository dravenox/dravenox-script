local vnx = {}

vnx.warp = function(name, optional)
		runThread(function()
				sendPacket(3, 'action|join_request\nname|'.. name ..'\ninvitedWorld|0')
				sleep(optional or 3000)
		end)
end 

vnx.log = function(str)
		logToConsole('`^[`9dravenox-script``]`` '.. str)
end 

vnx.genreadable = function(length)
		if length > 24 then
			return '`4max 24 chars!``'
		end
		math.random(os.time())
    local vow = {'A', 'U', 'I', 'O', 'E'}
    local cons = {'B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'X', 'Y', 'Z'}
    local rslt = {}
    local uv = true
    for i = 1, length do
        if uv then
            rslt[i] = vow[math.random(#vow)]
        else
            rslt[i] = cons[math.random(#cons)]
        end
        uv = not uv
    end
    return table.concat(rslt)
end

vnx.boolean = function(boolean)
		return (boolean and '`4Disabled``' or '`2Enabled``')
end 

vnx.call = function(varlist)
		sendVariant({ [0] = 'OnDialogRequest', [1] = varlist }, -1, 150)
end

vnx.changepath = function(aa, bb)
		sendPacket(2,
		'action|dialog_return\ndialog_name|sign_edit\ntilex|'.. aa ..'|\ntiley|'.. bb ..'|\nsign_text|dravenox\n'
	  )
end
