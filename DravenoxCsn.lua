
logToConsole("`9Script Under Maintenance.")
AddHook("OnTextPacket",".", function(_, str)
    if str:find("/s") then
      logToConsole("hello world!")
      return true 
    end
  end)
