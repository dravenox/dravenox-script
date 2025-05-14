local _t = { 
     booth = { 47, 53 },
     drvnx = false,
     sxtxn = false 
    }

function log(str)
    sendVariant({ [0] = 'OnTextOverlay', [1] = str })
end 

function warp(name)
    sendPacket(
        3, 
        'action|join_request\nname|' .. name
    )
end

function move(x, y)
    findPath(x, y)
    while getLocal().pos.x // 32 ~= x or getLocal().pos.y // 32 ~= y do
        sleep(100)
    end
end

function convert()
    sendPacket(2, string.format([[action|dialog_return
dialog_name|carnival_booth
tilex|%d|
tiley|%d|
buttonClicked|buy_16566
]], _t.booth[1], _t.booth[2]))
end

function getItemCount(id)
    for _, item in pairs(getInventory()) do
        if item.id == id then
            return item.amount
        end
    end
    return 0
end

function consume(id)
    sendPacketRaw(false, {
        type = 3,
        value = id,
        punchx = getLocal().pos.x // 32,
        punchy = getLocal().pos.y // 32,
        x = getLocal().pos.x,
        y = getLocal().pos.y
    })
end

log('`2Started Script, `5Warping To `9CARNIVAL')
warp('CARNIVAL')
sleep(3000)
move(_t.booth[1], _t.booth[2])
sleep(10)
_t.drvnx = true

while true do
    if _t.drvnx and not _t.sxtxn then
        log('`^Started: `5Convert Pts To `9Coupon 100K Gems.')
        if getItemCount(16566) < 190 then
            convert()
            sleep(10)
        else
            _t.sxtxn = true
        end
    elseif _t.sxtxn then
        log('`^Started: `5Consume Coupon 100K Gems.')
        if getItemCount(16566) > 0 then
            consume(16566)
            sleep(10)
        else
            _t.sxtxn = false
        end
    end
    sleep(200)
end
