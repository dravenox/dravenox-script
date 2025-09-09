local withnumber, withreadable, withbutton, custom, length = false, false, false, '', 5 

function genReadableString(length)
    if length > 24 then return "max 24 chars!" end
    local vowels = {"A","I","U","E","O"}
    local consonants = {"B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Y","Z"}
    local result = ""
    for i = 1, length do
        if i % 2 == 1 then
            result = result .. vowels[math.random(#vowels)]
        else
            result = result .. consonants[math.random(#consonants)]
        end
    end
    return result
end

function genRandomString(length)
		if withreadable then
				return genReadableString(length)
		end
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    if withnumber then
        chars = chars .. "0123456789"
    end
    local result = ""
    for i = 1, length do
        local pos = math.random(#chars)
        result = result .. chars:sub(pos, pos)
    end
    return result
end

function boolean(bool)
		return (bool and '`4Disabled``' or '`2Enabled``')
end 

function warp(name)
		sendPacket(
				3,
					'action|join_request\nname|'.. name ..'\ninvitedWorld|1'
		)
end

function log(str)
		logToConsole('`^[`9Satan Script``]`` '.. str)
end 

function call(func)
		sendVariant({
				[0] = 'OnDialogRequest',
				[1] = func
		}, -1, 250)
end

function features()
		return [[
set_border_color|0, 255, 255, 255
set_bg_color|0, 0, 0, 128
add_label_with_icon|big|`^Hunting Features  ``|left|1796|
add_smalltext|`2Enjoy The Script Made By `4@monarchsatan|
add_spacer|small|
add_button|wnum|]] .. boolean(withnumber) ..[[ `9With Number``|noflags|0|0|
add_button|wread|]] .. boolean(withreadable) ..[[ `9With Readable``|noflags|0|0|
add_button|wbutt|]] .. boolean(withbutton) ..[[ `9Find World With `^Button Friend``|noflags|0|0|
add_spacer|small|
add_quick_exit|
end_dialog|feature|| Save Changes |
]]
end

AddHook('OnTextPacket', 'SatanScript', function(_, str)
		if str:find('/menu$') then
				call(features())
				return true 
		end 
		
		if str:find('/find$') or str:find('/f$') then
				local name = genRandomString(length)
				if name and #name > 0 and #name <= 24 then
						runThread(function()
								log('`2Entering To `5'.. name)
								sleep(math.random(500, 1000))
								warp(name)
						end )
				end 
				return true
		end
		
		if str:find('/set (%d+)$') then
				local number = tonumber(str:match('/set (%d+)'))
				if number and number > 0 and number <= 24 then
						length = number 
						log('`^Length Setted To : `5'.. length)
						return true 
						else 
								log('`4Max 24 Chars!')
								return true
				end 
		end
		
		if str:find('/door (%w+)') or str:find('/d (%w+)') then
				local door, current = str:match('/door (%w+)') or str:match('/d (%w+)'), getWorld().name 
				warp(current .. '|' .. door)
				log('`2Trying To `4Leaked Door`` With ID : `5'.. door ..'``')
				return true 
		end 
		
		if str:find('buttonClicked|wnum') then
				if not withnumber then
						withnumber = true 
						log('`9With Number is now `2Enabled!``')
						call(features())
						else 
						withnumber = false
						log('`9With Number is now `4Disabled!``')
						call(features())
				end 
		end 
		
		if str:find('buttonClicked|wread') then
				if not withreadable then
						withreadable = true 
						log('`9With Readable is now `2Enabled!``')
						call(features())
						else 
						withreadable = false
						log('`9With Readable is now `4Disabled!``')
						call(features())
				end 
		end 
		
		if str:find('buttonClicked|wbutt') then
				if not withbutton then
						withbutton = true 
						log('`9With Button is now `2Enabled!``')
						call(features())
						else 
						withbutton = false
						log('`9With Button is now `4Disabled!``')
						call(features())
				end 
		end
		
		if str:find('action|friend') then
				if withbutton then
						local name = genRandomString(length)
						if name and #name > 0 and #name <= 24 then
										log('`2Entering To `5'.. name)
										warp(name)
						end
						else
								log('Enter `2/menu`` For Enabling Find World `^With Button!``')
				end 
				return true 
		end
		return false 
end )


