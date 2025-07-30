local drvnx = { 
		log = logToConsole,
		getObjects = getWorldObject,
		getTiles = getTile,
		getExtra = getExtraTile,
		getPlayers = getPlayerlist
}

function drvnx.getInv()
    local converted = {}
    for i, item in ipairs(getInventory()) do
        table.insert(converted, {
            itemid = item.id,
            amount = item.amount
        })
    end
    return converted
end

local hookMapping = {
    ['OnPacket'] = 'OnTextPacket',
    ['OnVar'] = 'OnVarlist', 
    ['OnRaw'] = 'OnRawPacket',
    ['OnGame'] = 'OnGameUpdatePacket'
}

local function createVariantWrapper(originalVar)
    local wrapper = {}
    function wrapper:get(index)
        local value = originalVar[index]
        return {
            getString = function()
                return tostring(value)
            end
            value = value
        }
    end
    return wrapper
end

function drvnx.setHook(hookName, callback)
    if type(hookName) ~= "string" then
    end
    if type(callback) ~= "function" then
    end
    local gentaHookName = hookMapping[hookName]
    if not gentaHookName then
    end
    local label = 'drvnx_' .. hookName .. '_' .. os.time()
    local wrappedCallback = callback
    if hookName == 'OnVar' then
        wrappedCallback = function(var, netid)
            local wrappedVar = createVariantWrapper(var)
            callback(wrappedVar, netid)
        end
    end
    AddHook(gentaHookName, label, wrappedCallback)
    return label
end

return drvnx
