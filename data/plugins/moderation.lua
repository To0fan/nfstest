function to_sudo(msg)
if text_msg == 'add' then
if db:sismember('active:group',msg.chat_id_) then
db:sadd('active:group',msg.chat_id_)
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, '*SuperGroup is already added\nAdder already :* `'..msg.sender_user_id_..'`', 1, 'md')
else
db:sadd('active:group',msg.chat_id_)
db:hset('settings:link',msg.chat_id_,'off')
db:hset('settings:spam',msg.chat_id_,'off')
db:hset('settings:english',msg.chat_id_,'off')
db:hset('settings:arabic',msg.chat_id_,'off')
db:hset('settings:fwd',msg.chat_id_,'off')
db:hset('settings:reply',msg.chat_id_,'off') 
db:hset('settings:edit',msg.chat_id_,'off')
db:hset('settings:username',msg.chat_id_,'off')
db:hset('settings:tag',msg.chat_id_,'off')
db:hset('settings:emoji',msg.chat_id_,'off')
db:hset('settings:spamtime',msg.chat_id_,'20')
db:hset('settings:spammsg',msg.chat_id_,'4')
db:hset('settings:spamchare',msg.chat_id_,'500')
db:hset('settings:public',msg.chat_id_,'off')
db:hset('settings:muteall',msg.chat_id_,'off')
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, '*SuperGroup has been added\nAdder :* `'..msg.sender_user_id_..'`', 1, 'md')
end
elseif text_msg == 'rem' then
if db:sismember('active:group',msg.chat_id_) then
db:srem('active:group',msg.chat_id_)
db:hdel('settings:link',msg.chat_id_)
db:hdel('settings:spam',msg.chat_id_)
db:hdel('settings:english',msg.chat_id_)
db:hdel('settings:arabic',msg.chat_id_)
db:hdel('settings:fwd',msg.chat_id_)
db:hdel('settings:reply',msg.chat_id_)
db:hdel('settings:edit',msg.chat_id_)
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, '*SuperGroup is removed\nRemover :* `'..msg.sender_user_id_..'`', 1, 'md')
else
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, '*SuperGroup is not added\nRemover :* `'..msg.sender_user_id_..'`', 1, 'md')
end
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
elseif text_msg == 'reload' then
local plug_up = load_plugins() 
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, '*Bot reloaded*\n'..plug_up, 1, 'md')
elseif text_msg:match('^edited (.*)') and msg.reply_to_message_id_  then
for i=1 ,100 do
sendText(msg.chat_id_, msg.id_, 0, 1, nil, i..'%', 1, 'md') 
end 
elseif text_msg == 'active' then
local function dl_cb_active(arg, data,extype) 
vardump(data)
print(arg)
print(extype)
end
tdcli_function ({ID = "GetActiveSessions",}, dl_cb_active, 'behrad')
else
to_owner(msg)
end
end

function settings_edit(msg,action,lock)
db:hset('settings:'..lock,msg.chat_id_,action)
sendText(msg.chat_id_, msg.id_, 0, 1, nil, lock..' Has been changed to '..action, 1, 'md')
return 
end
function to_owner(msg)
if text_msg == "settings" then
local text = '*Settings :*\n'
..'*🚀Link* : `'..db:hget('settings:link',msg.chat_id_)..'`\n'
..'*🚀English* : `'..db:hget('settings:english',msg.chat_id_)..'`\n'
..'*🚀Arabic* : `'..db:hget('settings:arabic',msg.chat_id_)..'`\n'
..'*🚀Forward* : `'..db:hget('settings:fwd',msg.chat_id_)..'`\n'
..'*🚀Reply* : `'..db:hget('settings:reply',msg.chat_id_)..'`\n'
..'*🚀Edit* : `'..db:hget('settings:edit',msg.chat_id_)..'`\n'
..'*🚀Username* : `'..db:hget('settings:username',msg.chat_id_)..'`\n'
..'*🚀Tag* : `'..db:hget('settings:tag',msg.chat_id_)..'`\n'
..'*🚀Emoji* : `'..db:hget('settings:emoji',msg.chat_id_)..'`\n'
..'*------------------------------*\n*🚀Spam * : `'..db:hget('settings:spam',msg.chat_id_)..'`\n'
..'*🚀Spam Time* : `'..db:hget('settings:spamtime',msg.chat_id_)..'s`\n'
..'*🚀Spam msg* : `'..db:hget('settings:spammsg',msg.chat_id_)..'`\n'
..'*🚀Spam chare* : `'..db:hget('settings:spamchare',msg.chat_id_)..'`\n'
..'*------------------------------*\n*🚀Mute all* : `'..db:hget('settings:muteall',msg.chat_id_)..'`\n'
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
elseif text_msg == "id" then
local function dl_photo(arg,data)
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'> Supergroup id : '..msg.chat_id_.."\n> Your id : "..msg.sender_user_id_)
end
  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1}, dl_photo, nil)
return 
end
if text_msg:match('^edit') or text_msg:match('^link') or text_msg:match('^english') or text_msg:match('^fwd') or text_msg:match('^reply') or text_msg:match('^arabic') or text_msg:match('^username') or text_msg:match('^tag') or text_msg:match('^muteall') or text_msg:match('^emoji') then
if text_msg:match('^link (.*)') then
action = text_msg:match('^link (.*)')
lock_type = 'link'
elseif text_msg:match('^edit (.*)') then
action = text_msg:match('^edit (.*)')
lock_type = 'edit'
elseif text_msg:match('^english (.*)') then
action = text_msg:match('^english (.*)')
lock_type = 'english'
elseif text_msg:match('^fwd (.*)') then  
action = text_msg:match('^fwd (.*)')
lock_type = 'fwd' 
elseif text_msg:match('^reply (.*)') then
action = text_msg:match('^reply (.*)')
lock_type = 'reply'
elseif text_msg:match('^arabic (.*)') then
action = text_msg:match('^arabic (.*)')
lock_type = 'arabic'
elseif text_msg:match('^username (.*)') then
action = text_msg:match('^username (.*)')
lock_type = 'username'
elseif text_msg:match('^tag (.*)') then
action = text_msg:match('^tag (.*)')
lock_type = 'tag'
elseif text_msg:match('^muteall (.*)') then
action = text_msg:match('^muteall (.*)')
lock_type = 'muteall'
elseif text_msg:match('^emoji (.*)') then
action = text_msg:match('^emoji (.*)')
lock_type = 'emoji'
end
if action == 'del' or action == 'kick' or action == 'off' then
return settings_edit(msg,action,lock_type)
else
return
end
elseif text_msg:match('^(spam) (.*)') then
local table = {text_msg:match('^(spam) (.*)')}
if table[2] == 'kick' or table[2] == 'off' then
settings_edit(msg,table[2],'spam')
end
sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, nil) 
return tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 200}, dl_cb_clean_bots, nil)
elseif text_msg == "setowner" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_owner(arg, data)
local userid = data.sender_user_id_
    if db:sismember('owners'..msg.chat_id_,userid) then
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is already a group owner.', 1, nil)
	else
	  db:sadd('owners'..msg.chat_id_,userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is now a owner.', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_add_owner, nil)
end
return 
elseif text_msg == "remowner" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_rem_owner(arg, data)
local userid = data.sender_user_id_
    if not db:sismember('owners'..msg.chat_id_,userid) then
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is not a group owner.', 1, nil)
	else
	  db:srem('owners'..msg.chat_id_,userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Removed fromowner list.', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_owner, nil)
end
return 
elseif text_msg == "ownerlist" then 
local owner = db:smembers('owners'..msg.chat_id_)
local text = '*List owners*\n'
for k,v in pairs(owner) do
text = text..'`'..k..'`--* '..get_info(v)..'*\n'
end
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, nil) 
elseif text_msg == "pin" and msg.reply_to_message_id_ then
pinChannelMessage(msg.chat_id_, msg.reply_to_message_id_, 0)
elseif text_msg == "unpin" then
unpinChannelMessage(msg.chat_id_)
elseif text_msg == "del" and msg.reply_to_message_id_ then
deleteMessages(msg.chat_id_, {[0] = msg.id_,msg.reply_to_message_id_})
elseif text_msg:match('^rms (.*)') then
local num = text_msg:match('^rms (.*)')
print(num)
for i=1,tonumber(num) do
deleteMessages(msg.chat_id_, {[0] = msg.id_ - i}) 
end
elseif text_msg == "promote" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_mod(arg, data)
local userid = data.sender_user_id_
    if db:sismember('Mod'..msg.chat_id_,userid) then
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' is already a group mod.', 1, nil)
	else
	  db:sadd('mod'..msg.chat_id_,userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is now a mod.', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_add_mod, nil)
end
return 
elseif text_msg == "demote" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_rem_mod(arg, data)
local userid = data.sender_user_id_
    if not db:sismember('mod'..msg.chat_id_,userid) then
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is not a group mod.', 1, nil)
	else
	  db:srem('mod'..msg.chat_id_,userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Removed frommod list.', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_mod, nil)
end
return 
elseif text_msg == "modlist" then 
local mod = db:smembers('mod'..msg.chat_id_)
local text = '*🚀List mods :*\n'
for k,v in pairs(mod) do
text = text..'`'..k..'`--* '..get_info(v)..'*🚀\n'
end
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, nil) 
else
to_mod(msg)
end
end

function to_mod(msg)
if text_msg == "modlist" then 
local mod = db:smembers('mod'..msg.chat_id_)
local text = '*List of mods*\n'
for k,v in pairs(mod) do
text = text..'`'..k..'`--* '..get_info(v)..'*\n'
end
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, nil) 
elseif text_msg == "promote" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_muteuser(arg, data)
local userid = data.sender_user_id_
    if db:sismember('muteuser:'..msg.chat_id_,userid) then
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is already a in muteuser list.', 1, nil)
	else
	  db:sadd('muteuser:'..msg.chat_id_,userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is now in muteuser list.', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_add_muteuser, nil)
end
return 
elseif text_msg == "unmute" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_rem_muteuser(arg, data)
local userid = data.sender_user_id_
    if not db:sismember('muteuser:'..msg.chat_id_,userid) then
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is not in muteuser list.', 1, nil)
	else
	  db:srem('muteuser:'..msg.chat_id_,userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Removed from muteuser list..', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_muteuser, nil)
end
return 
elseif text_msg == "mutelist" then 
local mod = db:smembers('muteuser:'..msg.chat_id_)
local text = '*List mute :*\n'
for k,v in pairs(mod) do
text = text..'`'..k..'`--* '..get_info(v)..'*\n'
end
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, nil) 
elseif text_msg == "ban" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_banuser(arg, data)
local userid = data.sender_user_id_
    if db:sismember('banuser:'..msg.chat_id_,userid) then
	chat_del_user(msg.chat_id_, userid)
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is already a in banuser list.', 1, nil)
	else
	  db:sadd('banuser:'..msg.chat_id_,userid)
	  chat_del_user(msg.chat_id_, userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is now in banuser list.', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_add_banuser, nil)
end
return 
elseif text_msg == "unban" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_rem_banuser(arg, data)
local userid = data.sender_user_id_
    if not db:sismember('banuser:'..msg.chat_id_,userid) then
	sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Is not in banuser list.', 1, nil)
	else
	  db:srem('banuser:'..msg.chat_id_,userid)
	  sendText(msg.chat_id_, data.id_, 0, 1, nil, get_info(userid)..' Removed from banuser list..', 1, nil) 
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_banuser, nil)
end
return 
elseif text_msg == "clean banlist" then 
local hash = 'banuser:'..msg.chat_id_
local text = '<b>Ban list has been Cleaned</b>'
db:del(hash)
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'html')
elseif text_msg == "banlist" then 
local mod = db:smembers('banuser:'..msg.chat_id_)
local text = '*Ban list :*\n'
for k,v in pairs(mod) do
text = text..'`'..k..'`--* '..get_info(v)..'*\n'
end
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, nil) 
end
end