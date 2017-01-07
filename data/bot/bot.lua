require("./data/bot/tdcli")
redis = require 'redis'
JSON = require('dkjson')
clr = require 'term.colors'
serpent = require('serpent')
HTTP = require('socket.http')
HTTPS = require('ssl.https')
URL = require('socket.url') 
clr = require 'term.colors'
db = redis.connect('127.0.0.1', 6379)
 sudo_users = {
[111334847] = 'ToOfan',

}

local plugins
function is_sudo(msg)
  local var = false
  for k,v in pairs(sudo_users)do 
    if k == msg.sender_user_id_  then
      var = true
    end
	end
  return var
end
function is_admin(msg)
  local var = false
  for k,v in pairs(config.admin_users)do 
    if k == msg.sender_user_id_  then
      var = true
    end
	end
  return var
end
function is_owner(msg)
local var = false
if db:sismember('owners'..msg.chat_id_,msg.sender_user_id_) then
var = true
end
return var
end
function is_mod(msg)
local var = false
if db:sismember('mod'..msg.chat_id_,msg.sender_user_id_) then
var = true
end
return var
end
function is_muteuser(msg)
local var = false
if db:sismember('muteuser:'..msg.chat_id_,msg.sender_user_id_) then
var = true
end
return var
end
function is_banuser(msg)
local var = false
if db:sismember('banuser:'..msg.chat_id_,msg.sender_user_id_) then
var = true
end
return var
end
function dl_cb(arg, data)
   vardump(data)
end
function get_info(user_id)
if db:hget('bot:username',user_id) then
text = '@'..db:hget('bot:username',user_id)..'['..user_id..']'
else
text = '['..user_id..'] '
end
get_user(user_id)
return text
end
function get_user(user_id)
function dl_username(arg, data)
username = data.username
vardump(data)
db:hset('bot:username',data.id_,data.username_)
end
 tdcli_function ({
    ID = "GetUser",
    user_id_ = user_id
  }, dl_username, nil)
end
function serialize_to_file(data, file, uglify)
  file = io.open(file, 'w+')
  local serialized
  if not uglify then
    serialized = serpent.block(data, {
      comment = false,
      name = '_'
    })
  else
    serialized = serpent.dump(data)
  end
  file:write(serialized)
  file:close()
end
function vardump(value)
  print(serpent.block(value, {comment=false}))
end
function load_plugins()
config = dofile('./data/bot/config.lua')
local plug_up = '\n'
  for k, v in pairs(config.plugins) do
    print(clr.blue.."loaded"..clr.reset, v)
	plug_up = plug_up..'*loaded* : *'..v..'*\n'
    local ok, err =  pcall(function()
      local t = loadfile("data/plugins/"..v..'.lua')()
      plugins[v] = t
    end)
    if not ok then
	plug_up = plug_up..'PLUG IS FALSE\n`'..io.popen("lua plugins/"..v..".lua"):read('*all')..'\n'..err..'\n`'
      print('\27[31mError loading plugin '..v..'\27[39m')
	  print(tostring(io.popen("lua plugins/"..v..".lua"):read('*all')))
      print('\27[31m'..err..'\27[39m')
    end
  end
  return plug_up
end

function save_data(filename, data)

	local s = JSON.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()

end
plugins = {}
function load_data(filename)

	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON.decode(s)

	return data

end
load_plugins() 
function msg_vaild(msg,time)
if not bot then
get_bot_info()
end
if msg.sender_user_id_ == bot.id then
print(clr.red..'msg from us')
return false
end
if time and msg.date_ < os.time() - 10 then
print('\27[36mNot valid: old msg\27[39m')
vardump(msg)
return false
end
if not db:sismember('active:group',msg.chat_id_) and not is_sudo(msg) then
print('\27[36mGroup is NOT added\27[39m')
return false
end
return true
end
function save_config( )
  serialize_to_file(config, './data/config.lua')
  print ('saved config into ./data/config.lua')
end
function get_bot_info()
bot = {}
local function dl_info(arg,data)
bot.id = data.id_
bot.name = data.first_name_
print(clr.green..'Bot Runing at '..clr.reset..'\n'..os.date()..clr.yellow..'\nBot ID : '..bot.id)
end
tdcli_function ({ID = "GetMe",}, dl_info, nil)
end

function group_type(msg)
  local var = 'find'
  if type(msg.chat_id_) == 'string' then
  if msg.chat_id_:match('$-100') then
  var = 'cahnnel'
  elseif msg.chat_id_:match('$-10') then
  var = 'chat'
  end
  elseif type(msg.chat_id_) == 'number' then
  var = 'user'
  end  
  return var
  end
print(clr.green.."██████████████    ██████████████  ██████████████████    ██████          ██████  ██████████████  ████████  ████████")
print(clr.green.."██          ██    ██          ██  ██              ██    ██  ██████████  ██  ██  ██          ██  ██    ██  ██    ██")
print(clr.green.."██  ██████  ██    ██  ██████  ██  ████████  ████████    ██          ██  ██  ██  ██  ██████████  ████  ██  ██  ████")
print(clr.green.."██  ██  ██  ██    ██  ██  ██  ██        ██  ██          ██  ██████  ██  ██  ██  ██  ██            ██    ██    ██  ") 
print(clr.white.."██  ██████  ████  ██  ██  ██  ██        ██  ██          ██  ██  ██  ██  ██  ██  ██  ██████████    ████      ████  ")
print(clr.white.."██            ██  ██  ██  ██  ██        ██  ██          ██  ██  ██  ██  ██  ██  ██          ██      ██      ██    ") 
print(clr.white.."██  ████████  ██  ██  ██  ██  ██        ██  ██          ██  ██  ██  ██  ██  ██  ██  ██████████    ████      ████  ") 
print(clr.white.."██  ██    ██  ██  ██  ██  ██  ██        ██  ██          ██  ██  ██  ██████  ██  ██  ██            ██    ██    ██  ") 
print(clr.red.."██  ████████  ██  ██  ██████  ██        ██  ██          ██  ██  ██          ██  ██  ██████████  ████  ██  ██  ████") 
print(clr.red.."██            ██  ██          ██        ██  ██          ██  ██  ██████████  ██  ██          ██  ██    ██  ██    ██") 
print(clr.red.."████████████████  ██████████████        ██████          ██████          ██████  ██████████████  ████████  ████████") 
function tdcli_update_callback(data)
  if (data.ID == "UpdateNewMessage") then
    local msg = data.message_
    if msg.content_.ID == "MessageText" then
	text_msg = msg.content_.text_:lower() or nil
if is_sudo(msg) and msg_vaild(msg)  then
to_sudo(msg)
elseif is_admin(msg) and msg_vaild(msg) then
to_admin(msg)
elseif is_owner(msg) and msg_vaild(msg) then
to_owner(msg)
elseif is_mod(msg) and msg_vaild(msg) then
to_mod(msg)
elseif msg_vaild(msg,true) then
msg_check(msg)
end
    end
	elseif (data.ID == "UpdateMessageContent") then
	on_edit(data)
  elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
    tdcli_function ({
      ID="GetChats",
      offset_order_="9223372036854775807",
      offset_chat_id_=0,
      limit_=20
    }, dl_cb, nil)
  end
end
