function to_sudo(msg)
local lang_hash = 'group:'..msg.chat_id_..':lang'
local lang = db:get(lang_hash)
if text_msg == 'add' then
if db:sismember('active:group',msg.chat_id_) then
db:sadd('active:group',msg.chat_id_)
 if lang then
	  local textfa = '*سوپر گروه دوباره ادد شد\nکسی که دوباره اد کرده :* `'..msg.sender_user_id_..'`'
	  return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '*SuperGroup is already added\nAdder already :* `'..msg.sender_user_id_..'`'
      return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
	  end
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
if lang then
	  local textfa = '*سوپر گروه ادد شد\nاد کننده :* `'..msg.sender_user_id_..'`'
	  return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '*SuperGroup has been added\nAdder :* `'..msg.sender_user_id_..'`'
      return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
	  end
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
if lang then
	  local textfa = '*سوپر گروه از لیست سرور حذف شد\nکسی که حذف کرد :* `'..msg.sender_user_id_..'`'
	  return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '*SuperGroup has been removed\nRemover :* `'..msg.sender_user_id_..'`'
      return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '*سوپر گروه دوباره حذف شد\nکسی که دوباره حذف کرد :* `'..msg.sender_user_id_..'`'
	  return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '*SuperGroup is already removed\nRemover already :* `'..msg.sender_user_id_..'`'
      return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
	  end
end
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
elseif text_msg == "admin" then
local text = '*Admin list* _:_ \n'
local textfa = '*لیست ادمین ها* _:_ \n'
for k,v in pairs(config.admin_users) do 
text = text..'*'..k..'* - `('..get_info(v)..')`\n'
textfa = textfa..'*'..k..'* - `('..get_info(v)..')`\n'
end
if lang then
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
else
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
end
elseif text_msg == 'reload' then
local plug_up = load_plugins()  
if lang then
	  local textfa = '*ربات دوباره راه اندازی  شد*\n'..plug_up
	  return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '*Bot reloaded*\n'..plug_up
      return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
	  end
elseif text_msg == 'active' then
local function dl_cb_active(arg, data,extype) 
vardump(data)
print(arg)
print(extype)
end
tdcli_function ({ID = "GetActiveSessions",}, dl_cb_active, 'behrad')
else
to_admin(msg)
end
end
function to_admin(msg)
local lang_hash = 'group:'..msg.chat_id_..':lang'
local lang = db:get(lang_hash)
if text_msg == "setowner" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_owner(arg, data)
local userid = data.sender_user_id_
    if db:sismember('owners'..msg.chat_id_,userid) then
	if lang then
	  local textfa = '`('..get_info(userid)..')` *دوباره اونر شد*'
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is already a group owner*'
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *اونر شد*'
	  db:sadd('owners'..msg.chat_id_,userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *is now a owner*'
	  db:sadd('owners'..msg.chat_id_,userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
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
	if lang then
	  local textfa = '`('..get_info(userid)..')` *دوباره از لیست اونر ها پاک شد*'
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is not a group owner*'
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *از لیست اونر ها پاک شد*'
	  db:srem('owners'..msg.chat_id_,userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *removed from ownerlist*'
	  db:srem('owners'..msg.chat_id_,userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
	  end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_owner, nil)
end
return 
elseif text_msg == "clean owner" then 
local hash = 'owners'..msg.chat_id_
if lang then
 text = '*لیست اونرها پاک شد*'
else
 text = '*Ownerlist has been cleaned*'
 end
 db:del(hash)
 return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md') 
else
to_owner(msg)
end
end
function settings_edit(msg,action,lock)
local lang_hash = 'group:'..msg.chat_id_..':lang'
local lang = db:get(lang_hash)
db:hset('settings:'..lock,msg.chat_id_,action)
if lang then
	  local textfa = '`'..lock..'` *تغییر کرد به* `'..action..'`'
	  return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`'..lock..'` *has been changed to* `'..action..'`'
      return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
	  end
return 
end
function to_owner(msg)
local lang_hash = 'group:'..msg.chat_id_..':lang'
local lang = db:get(lang_hash)
if text_msg == 'setlang fa' then
db:set('group:'..msg.chat_id_..':lang', true)
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, '*زبان گروه هم اکنون فارسی می باشد*', 1, 'md')
end
if text_msg == 'setlang en' then
db:del('group:'..msg.chat_id_..':lang')
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, '*English lang has been set*', 1, 'md')
end
if text_msg == "settings" then
if lang then
local textfa = '*تنظیمات* _:_\n'
..'*🚀لینک* _:_ `'..db:hget('settings:link',msg.chat_id_)..'`\n'
..'*🚀انگلیسی* _:_ `'..db:hget('settings:english',msg.chat_id_)..'`\n'
..'*🚀عربی یا فارسی* _:_ `'..db:hget('settings:arabic',msg.chat_id_)..'`\n'
..'*🚀فوروارد* _:_ `'..db:hget('settings:fwd',msg.chat_id_)..'`\n'
..'*🚀ریپلی* _:_ `'..db:hget('settings:reply',msg.chat_id_)..'`\n'
..'*🚀ادیت* _:_ `'..db:hget('settings:edit',msg.chat_id_)..'`\n'
..'*🚀یوزرنیم* _:_ `'..db:hget('settings:username',msg.chat_id_)..'`\n'
..'*🚀تگ* _:_ `'..db:hget('settings:tag',msg.chat_id_)..'`\n'
..'*🚀اموجی* _:_ `'..db:hget('settings:emoji',msg.chat_id_)..'`\n'
..'*------------------------------*\n*🚀اسپم * _:_ `'..db:hget('settings:spam',msg.chat_id_)..'`\n'
..'*🚀زمان اسپم* _:_ `'..db:hget('settings:spamtime',msg.chat_id_)..'s`\n'
..'*🚀پیام اسپم* _:_ `'..db:hget('settings:spammsg',msg.chat_id_)..'`\n'
..'*🚀حساسیت کارکتر* _:_ `'..db:hget('settings:spamchare',msg.chat_id_)..'`\n'
..'*------------------------------*\n*🚀چت کردن* : `'..db:hget('settings:muteall',msg.chat_id_)..'`\n'
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
else
local text = '*Settings* _:_\n'
..'*🚀Link* _:_ `'..db:hget('settings:link',msg.chat_id_)..'`\n'
..'*🚀English* _:_ `'..db:hget('settings:english',msg.chat_id_)..'`\n'
..'*🚀Arabic* _:_ `'..db:hget('settings:arabic',msg.chat_id_)..'`\n'
..'*🚀Forward* _:_ `'..db:hget('settings:fwd',msg.chat_id_)..'`\n'
..'*🚀Reply* _:_ `'..db:hget('settings:reply',msg.chat_id_)..'`\n'
..'*🚀Edit* _:_ `'..db:hget('settings:edit',msg.chat_id_)..'`\n'
..'*🚀Username* _:_ `'..db:hget('settings:username',msg.chat_id_)..'`\n'
..'*🚀Tag* _:_ `'..db:hget('settings:tag',msg.chat_id_)..'`\n'
..'*🚀Emoji* _:_ `'..db:hget('settings:emoji',msg.chat_id_)..'`\n'
..'*------------------------------*\n*🚀Spam * _:_ `'..db:hget('settings:spam',msg.chat_id_)..'`\n'
..'*🚀Spam Time* _:_ `'..db:hget('settings:spamtime',msg.chat_id_)..'s`\n'
..'*🚀Spam msg* _:_ `'..db:hget('settings:spammsg',msg.chat_id_)..'`\n'
..'*🚀Spam chare* _:_ `'..db:hget('settings:spamchare',msg.chat_id_)..'`\n'
..'*------------------------------*\n*🚀Mute all* : `'..db:hget('settings:muteall',msg.chat_id_)..'`\n'
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
end
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
if action == 'del' or action == 'off' then
return settings_edit(msg,action,lock_type)
else
return
end
elseif text_msg:match('^(spam) (.*)') then
local table = {text_msg:match('^(spam) (.*)')}
if table[2] == 'kick' or table[2] == 'ban' or table[2] == 'off' then
settings_edit(msg,table[2],'spam')
end
sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, nil) 
return tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 200}, dl_cb_clean_bots, nil)
elseif text_msg == "owner" then 
if lang then
 text = '*لیست اونر ها* _:_ \n'
else
 text = '*List owners* _:_ \n'
end
 owner = db:smembers('owners'..msg.chat_id_)
for k,v in pairs(owner) do
text = text..'*'..k..'* - `('..get_info(v)..')`\n'
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md') 
end
elseif text_msg == "pin" and msg.reply_to_message_id_ then
pinChannelMessage(msg.chat_id_, msg.reply_to_message_id_, 0)
elseif text_msg == "unpin" then
unpinChannelMessage(msg.chat_id_)
elseif text_msg == "del" and msg.reply_to_message_id_ then
deleteMessages(msg.chat_id_, {[0] = msg.id_,msg.reply_to_message_id_})
elseif text_msg:match('^clean msg (.*)') then
local num = text_msg:match('^clean msg (.*)')
print(num)
for i=1,tonumber(num) do
deleteMessages(msg.chat_id_, {[0] = msg.id_ - i})
end
elseif text_msg == "ban" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_banuser(arg, data)
local userid = data.sender_user_id_
    if db:sismember('banuser:'..msg.chat_id_,userid) then
	if lang then
	  local textfa = '`('..get_info(userid)..')` *دوباره در بن لیست اضافه شد*'
	  chat_del_user(msg.chat_id_, userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is already a in banlist*'
	  chat_del_user(msg.chat_id_, userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *در لیست بن لیست اضافه شد*'
	   db:sadd('banuser:'..msg.chat_id_,userid)
	  chat_del_user(msg.chat_id_, userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *is now in banlist*'
	  	db:sadd('banuser:'..msg.chat_id_,userid)
	  chat_del_user(msg.chat_id_, userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_add_banuser, 'md')
end
return 
elseif text_msg == "unban" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_rem_banuser(arg, data)
local userid = data.sender_user_id_
    if not db:sismember('banuser:'..msg.chat_id_,userid) then
	if lang then
	  local textfa = '`('..get_info(userid)..')` *دوباره از لیست بن شده ها در آمد*'
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is not in banlist*'
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *از لیست بن شده ها پاک شد*'
	   db:srem('banuser:'..msg.chat_id_,userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *removed from banlist*'
	  	db:srem('banuser:'..msg.chat_id_,userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_banuser, 'md')
end
return 
elseif text_msg == "clean banlist" then 
local hash = 'banuser:'..msg.chat_id_
if lang then
 text = '*لیست بن شده ها پاک شد*'
else
 text = '*banlist has been cleaned*'
 end
 db:del(hash)
 return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md') 
elseif text_msg == "banlist" then 
local mod = db:smembers('banuser:'..msg.chat_id_)
local text = '*Banlist* _:_\n'
local textfa = '*لیست کسانی که دیگر نمیتوانند به گروه برگردند* _:_\n'
for k,v in pairs(mod) do
textfa = textfa..'*'..k..'* - `('..get_info(v)..')`\n'
end
if lang then
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
else
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
end
elseif text_msg == "setmod" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_mod(arg, data)
local userid = data.sender_user_id_
    if db:sismember('Mod'..msg.chat_id_,userid) then
	if lang then
	  local textfa = '`('..get_info(userid)..')` *دوباره مدیر شد*'
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is already a group mod*'
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *مدیر شد*'
	  db:sadd('mod'..msg.chat_id_,userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *is now a mod*'
	  db:sadd('mod'..msg.chat_id_,userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_add_mod, 'md')
end
return 
elseif text_msg == "remmod" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_rem_mod(arg, data)
local userid = data.sender_user_id_
    if not db:sismember('mod'..msg.chat_id_,userid) then
	if lang then
	  local textfa = '`('..get_info(userid)..')` *دوباره از لیست مدیر ها پاک شد*'
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is not a group mod*'
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *از لیست مدیر ها پاک شد*'
	  db:srem('mod'..msg.chat_id_,userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *removed from modlist*'
	  db:srem('mod'..msg.chat_id_,userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_mod, 'md')
end
return 
elseif text_msg == "clean mod" then 
local hash = 'mod'..msg.chat_id_
if lang then
 text = '*لیست مدیر ها پاک شد*'
else
 text = '*Ownerlist has been cleaned*'
 end
 db:del(hash)
 return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md') 
elseif text_msg == "mod" then 
local mod = db:smembers('mod'..msg.chat_id_)
local text = '*List mods* _:_\n'
local textfa = '*لیست مدیر ها* _:_\n'
for k,v in pairs(mod) do
text = text..'*'..k..'* - `('..get_info(v)..')`\n'
textfa = textfa..'*'..k..'* - `('..get_info(v)..')`\n'
end
if lang then
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
else
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
end
else
to_mod(msg)
end
end

function to_mod(msg)
local lang_hash = 'group:'..msg.chat_id_..':lang'
local lang = db:get(lang_hash)
if text_msg == "mod" then 
local mod = db:smembers('mod'..msg.chat_id_)
local text = '*List mods* _:_\n'
local textfa = '*لیست مدیر ها* _:_\n'
for k,v in pairs(mod) do
text = text..'*'..k..'* - `('..get_info(v)..')`\n'
textfa = textfa..'*'..k..'* - `('..get_info(v)..')`\n'
end
if lang then
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
else
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
end
elseif text_msg == "mute" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_add_muteuser(arg, data)
local userid = data.sender_user_id_
    if db:sismember('muteuser:'..msg.chat_id_,userid) then
	if lang then
	  local textfa = '`('..get_info(userid)..')` *دوباره توانایی چت کردن را از دست دادند*'
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is already a in muteuser list*'
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *توانایی چت کردن را از دست دادند*'
	   db:sadd('muteuser:'..msg.chat_id_,userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *is now in muteuser list*'
	  	db:sadd('muteuser:'..msg.chat_id_,userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_add_muteuser, 'md')
end
return 
elseif text_msg == "unmute" then
if not msg.reply_to_message_id_  then
else
local function dl_cb_rem_muteuser(arg, data)
local userid = data.sender_user_id_
    if not db:sismember('muteuser:'..msg.chat_id_,userid) then
	if lang then
	  local textfa = '`('..get_info(userid)..')` *ایشون در لیست موت ها نبود*'
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md')
	  else
	  local text = '`('..get_info(userid)..')` *is not in muteuser list*'
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md')
	  end
else
if lang then
	  local textfa = '`('..get_info(userid)..')` *از لیست موت ها در آمد*'
	   db:sadd('muteuser:'..msg.chat_id_,userid)
	  return sendText(msg.chat_id_, data.id_, 0, 1, nil, textfa, 1, 'md') 
	  else
	  local text = '`('..get_info(userid)..')` *removed from muteuser list*'
	  	db:sadd('muteuser:'..msg.chat_id_,userid)
      return sendText(msg.chat_id_, data.id_, 0, 1, nil, text, 1, 'md') 
	  end
    end
end
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_}, dl_cb_rem_muteuser, 'md')
end
return 
elseif text_msg == "mutelist" then 
local mod = db:smembers('muteuser:'..msg.chat_id_)
local text = '*List mute* _:_ \n'
local textfa = '*لیست کسانی که نمیتوانند چت کنند* _:_ \n'
for k,v in pairs(mod) do
text = text..'*'..k..'* - `('..get_info(v)..')`\n'
textfa = textfa..'*'..k..'* - `('..get_info(v)..')`\n'
end
if lang then
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
else
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
end
elseif text_msg == "clean mutelist" then 
local hash = 'muteuser:'..msg.chat_id_
if lang then
 text = '*لیست ممنوع کاران حذف شد*'
else
 text = '*Mutelist has been cleaned*'
 end
 db:del(hash)
 return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md') 
elseif text_msg == "id" then
if lang then
local textfa = "> *آیدی گروه* _:_ `["..msg.chat_id_.."]`\n> *آیدی شما* _:_ `["..msg.sender_user_id_.."]`"
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, textfa, 1, 'md')
else
local text = "> *Chat Id* _:_ `["..msg.chat_id_.."]`\n> *Your Id* _:_ `["..msg.sender_user_id_.."]`"
return sendText(msg.chat_id_, msg.id_, 0, 1, nil, text, 1, 'md')
end
end
end