local _t = { current = 0, target = 0, booth = { 47, 53 } }
local const = { 0, nil }

function int(__)
	const[1] = os.time() + (__ / (200 + 800))
	coroutine.yield()
end 

function createthread(_t)
	const[2] = coroutine.create(function()
		_t()
		const[2] = nil 
	end )
	coroutine.resume(const[2])
end 

AddHook('OnRender', 'drvnx', function() if const[2] and coroutine.status(const[2]) == 'suspended' then if os.time() >= const[1] then local __, ____ = coroutine.resume(const[2]) if not __ then const[2] = nil end end end end )

function log(str)
  logToConsole('`^[`9dravenox.site``]`` '.. str)
  sendVariant({ [0] = 'OnTextOverlay', [1] = str })
end 

function secretlolfuckbitcheweilovedindanurachmadyanti()
	for _, tile in pairs(getTile()) do 
		if tile.fg == 1926 then
			if tile.getFlags.enabled then
				sendPacketRaw(true, {
					type = 3,
					value = 0,
					punchx = tile.pos.x,
					punchy = tile.pos.y,
					x = getLocal().pos.x,
					y = getLocal().pos.y
				})
			else
				sendPacketRaw(true, {
					type = 3,
					value = 6276,
					punchx = tile.pos.x,
					punchy = tile.pos.y,
					x = getLocal().pos.x,
					y = getLocal().pos.y
				})
			end
			for i = 18, 20 do
				sendPacketRaw(true, {
					type = 3,
					value = 2826,
					punchx = i,
					punchy = 23,
					x = getLocal().pos.x,
					y = getLocal().pos.y
				})
			end
		end 
	end
end

function getpoint(a, b)
  sendPacketRaw(false, { x = a * 32, y = b * 32, punchx = -1, punchy = -1, netid = getLocal().netId })
  sendPacketRaw(false, { type = 3, value = 32, punchx = a, punchy = b, x = a * 32, y = b * 32 })
end 

function buyticket(amount)
	amount = tonumber(amount)
	local item = ''
	if (amount >= 1 and amount <= 4) or (amount >= 6 and amount <= 9) then
		item = '242'
	else
		item = '1796'
	end
	sendPacket(
		2,
		'action|dialog_return\ndialog_name|carnival_booth\ntilex|47|\ntiley|53|\nitemID|'.. item ..'|\ncount|'.. amount ..'\n'
	)
end


AddHook('OnTextPacket', 'dravenoxScript', function(_, str)
    if str:find('/target (%d+)') then
      local number = tonumber(str:match('/target (%d+)'))
        _t.target = number
        log('`5Target Point Set To: `#'.. _t.target)
        return true
    end
    
    if str:find('/check') then
        getpoint(_t.booth[1], _t.booth[2])
        return true
    end

    if str:find('/secret') then
        createthread(function()
		int(3)
		secretlolfuckbitcheweilovedindanurachmadyanti()
		int(3)
		log('`4Removing `5Mirror Maze `2!')			
	end )
	return true		
    end 
		
    if str:find('/ticket (%d+)') then
    	local amount = str:match('/ticket (%d+)')
    	createthread(function()
    		sendPacketRaw(false, { x = _t.booth[1] * 32, y = _t.booth[2] * 32, punchx = -1, punchy = -1, netid = getLocal().netId })
    		int(3)
    		buyticket(amount)
    		log('`5Purchasing Ticket: `9'.. amount)
    	end )
    	return true
    end 
  	
    return false
end)

AddHook('OnVarList', 'dravenoxScript', function(var)
	  if var[0] == 'OnConsoleMessage' then
	  	local content = (var[1]:gsub('`.', ''):gsub('``', ''))
	  	if content:find('Received: %d+ Points!') then
	  		_t.current = _t.current + (tonumber(content:match('Received: (%d+) Points!')))
	  		log('`^Total Point Gained: `#+'.. (tonumber(content:match('Received: (%d+) Points!'))) ..' `4'.. _t.current ..' `^/ `2'.. _t.target)
	  		if _t.current >= _t.target then 
	  			log('`^(party) Boom! Target reached. You nailed it.')
	  		end 
	  	end
		end
		
		if var[0] == 'OnDialogRequest' and var[1]:find('carnival_booth') then
			_t.current = tonumber(var[1]:match('got `w(%d+)`` points!'))
			log('`^Current Point: `9[ `c'.. _t.current..' `9]')
			return true 
		end 
		
		return false
end )
if getWorld().name == 'CARNIVAL' then
  getpoint(_t.booth[1], _t.booth[2])
else
  log('`5Please Run In CARNIVAL')
end 
