## Genta Hax Function

**Function List**
* [sendPacket](#sendpacket)
* [sendPacketRaw](#sendpacketraw)
* [sendVariant](#sendvariant)
* [sleep](#sleep)
* [logToConsole](#logtoconsole)
* [doLog](#dolog)
* [doToast](#dotoast)
* [callToast](#calltoast)
* [getLocal](#getlocal)
* [getPlayerByNetID](#getplayerbynetid)
* [getInventory](#getinventory)
* [getWorld](#getworld)
* [checkTile](#checktile)
* [getTile](#gettile)
* [getExtraTile](#getextratile)
* [getWorldObject](#getworldobject)
* [getNpc](#getnpc)
* [getMac](#getmac)
* [getGid](#getgid)
* [setMac](#setmac)
* [setGid](#setgid)
* [randomMac](#randommac)
* [randomGid](#randomgid)
* [requestCollect](#requestcollect)
* [requestTileChange](#requesttilechange)
* [AddHook](#addhook)
* [RemoveHook](#removehook)
* [RemoveHooks](#removehooks)
* [runThread](#runthread)
* [sendWebhook](#sendwebhook)
* [makeRequest](#makerequest)
* [getItemByID](#getitembyid)
* [getItemByName](#getitembyname)
* [getCheat](#getcheat)
* [toggleCheat](#togglecheat)
* [findPath](#findpath)

**Structure**
* [TankPacketStruct](#tankpacketstruct)
* [Camera](#camera)
* [NetAvatar](#netavatar)
* [TileStruct](#tilestruct)
* [TileExtra](#tileextra)
* [TileFlag](#tileflag)
* [ItemInfo](#iteminfo)
* [World](#world)
* [WorldObject](#worldobject)
* [Inventory](#inventory)
* [NpcList](#npclist)
* [GentaHook](#gentahook)
* [CheatCode](#cheatcode)
* [ToastType](#toasttype)
* [GrowtopiaRaw](#growtopiaraw) 

**Webhook Structute**
* [...](#...)

-

## TankPacketStruct
```lua
local tankPacket = {
 int: type,
 int: padding1,
 int: padding2,
 int: padding3,
 int: netid,
 int: secid,
 int: state,
 float: padding4,
 int: value,
 float: x,
 float: y,
 float: speedx,
 float: speedy,
 int: punchx,
 int: punchy,
 int: padding5
}
```

## Camera
```lua
local camera = {
 float: scale,
 vector2f: pos,
 vector2f: center
}
```

## NetAvatar
```lua
local char = {
 vector2i: pos,
 string: name,
 string: country,
 int: userId,
 int: netId,
 int: status,
 boolean: facing,
 int: ping,
 int: punchId,
 int: gems,
 int: gemsCollected,
 int: backpackSlot,
 vector4i: skinColor,
 vector4i: quickSlot,
 uint32_t: selectedItem,
 uin32_t: hair,
 uin32_t: shirt,
 uint32_t: pants,
 uint32_t: feet,
 uint32_t: face,
 uint32_t: hand,
 uint32_t: back,
 uint32_t: mask,
 uint32_t: necklace
}
```

## TileStruct
```lua
local tile = {
 vector2i: pos,
 int: fg,
 int: bg,
 boolean: isCollideable,
 int: collisionType,
 int: flags,
 tilFlag: getFlags
}
```

## TileExtra
```lua
local extra = {
 boolean: valid,
 int: type,
 int: growth,
 int: flags,
 int: owner,
 std::list<uint32_t>: adminList,
 boolean: ready,
 string: label,
 string: padding1,
 int: volume,
 int: fruitCount,
 int: lastUpdate
}
```

## TileFlag
```lua
local tileFlag = {
 boolean: locked,
 boolean: area,
 boolean: flipped,
 boolean: enbaled,
 boolean: public,
 boolean: silenced,
 boolean: water,
 boolean: glue,
 boolean: burn,
 boolean: painted
}
```
