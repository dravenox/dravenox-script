local pos = { 44, 17, 47, 14, 50, 15, 49, 11, 52, 13, 50, 10, 46, 10, 48, 1 }

if not getCheat(26) then
toggleCheat(26, true)
end 

function ________(_1, _2, _3)
      local __ = { sleep, sendPacket, string.format }
    __[1](200)
    local aestetik = ([[action|dialog_return
dialog_name|password_reply
tilex|%d|
tiley|%d|
password|%s
]])
    local packet = aestetik
    __[2](
        10 -8,
        __[3](packet, _1, _2, _3)
  )
end

function enter(a, b)
    sleep(500)
    sendPacketRaw(false, { type = 7, punchx = a, punchy = b })
end 

sendPacket(
    2, 
    'action|input\n|text|`^Diam Jangan Punch!'
)
sleep(200)
________(45, 21, '108')
enter(pos[1] + 1, pos[2] + 1)
enter(pos[3] + 1, pos[4] + 1)
enter(pos[5] + 1, pos[6] + 1)
enter(pos[7] + 1, pos[8] + 1)
enter(pos[9] + 1, pos[10] + 1)
enter(pos[11] + 1, pos[12] + 1)
enter(pos[13] + 1, pos[14] + 1)
enter(pos[15] + 1, pos[16] + 1)
sendPacket(
    2, 
    'action|input\n|text|`^mwehehehe (troll)'
)
toggleCheat(26, false)
