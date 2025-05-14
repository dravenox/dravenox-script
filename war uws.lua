local satantersakiti = ''
sendPacket(
  2, 
  'action|buy\nitem|bigitems\n'
)

function log(zz)sendVariant({[0]='OnTextOverlay',[1]=zz})
end

AddHook('OnVarList', 'satan kenapa :(', function(var_c)if var_c[0] == 'OnStoreRequest' then for tired in var_c[1]:gmatch('add_button|[^|]+|`oUltra World Spray``|[^\n]+') do local quit = tired:match('add_button|([^|]+)|')if quit and quit ~= satantersakiti then satantersakiti = quit log('`5Packet Found: `2'.. quit) sendPacket(2'action|buy\nitem|'.. quit ..'\n')else log('`4Canceled Purchase, Bcz Same Packet.')end    end end 
end )
