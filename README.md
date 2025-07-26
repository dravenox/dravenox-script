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

### Structure 
## TankPacketStruct
```lua
local tank = {
 int: type
 int: padding1
 int: padding2
 int: padding3
 int: netid
 int: secid
 int: state
 float: padding4
 int: value
 float: x
 float: y
 float: speedx
 float: speedy
 int: punchx
 int: punchy
 int: padding5
}
```
