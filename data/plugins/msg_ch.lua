local function trigger_anti_spam(msg, chat_id, user_id)  --merbot baw
if db:hget('settings:spam',msg.chat_id_) == 'ban' then
     chat_del_user(chat_id, user_id)
	 db:sadd('banuser:'..msg.chat_id_,user_id)
	 deleteMessages(msg.chat_id_, {[0] = msg.id_,msg.id_ - 1})
	 sendText(msg.chat_id_, msg.id_, 0, 1, nil, get_info(user_id)..' is flooding. Banned', 1, 'md')
	 elseif db:hget('settings:spam',msg.chat_id_) == 'kick' then
	 chat_del_user(chat_id, user_id)
	 deleteMessages(msg.chat_id_, {[0] = msg.id_,msg.id_ - 1})
	 sendText(msg.chat_id_, msg.id_, 0, 1, nil, get_info(user_id)..' is flooding. kicked', 1, 'md')
	 end
	 msg = nil
  end
function msg_check(msg)
if is_banuser(msg) then
chat_del_user(msg.chat_id_, msg.sender_user_id_)
return deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
if db:hget('settings:spam',msg.chat_id_) == 'off' then
else
local post_count = 'floodc:' .. msg.sender_user_id_ .. ':' .. msg.chat_id_
db:incr(post_count)
local post_count = 'user:' .. msg.sender_user_id_ .. ':floodc'
local msgs = tonumber(db:get(post_count) or 0)
if msgs > 3 then
trigger_anti_spam(msg, msg.chat_id_, msg.sender_user_id_)
end
db:setex(post_count, 10, msgs+1)
end 
if is_muteuser(msg) then
return deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
local link = db:hget('settings:link',msg.chat_id_)
if link == 'del' then 
if text_msg:find('https://telegram.me/joinchat') or text_msg:match('https://') or text_msg:match('http://') or text_msg:match('telegram.me/') then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
local english = db:hget('settings:english',msg.chat_id_)
if english == 'del' then 
if text_msg:match("[qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM]") then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
local arabic = db:hget('settings:arabic',msg.chat_id_)
if arabic == 'del' then 
if text_msg:match("[\216-\219][\128-\191]") then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
local fwd = db:hget('settings:fwd',msg.chat_id_)
if fwd == 'del' then
if type(msg.forward_info_) ~= 'boolean' and msg.forward_info_.ID then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
vardump(msg)
local reply = db:hget('settings:reply',msg.chat_id_)
if reply == 'del' then
if msg.reply_to_message_id_ ~= 0 then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
local username = db:hget('settings:username',msg.chat_id_)
if username == 'del' then 
if text_msg:match("[@]") then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
local tag = db:hget('settings:tag',msg.chat_id_)
if tag == 'del' then 
if text_msg:match("[#]") then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
local tag = db:hget('settings:emoji',msg.chat_id_)
if tag == 'del' then 
if text_msg:match("[😀😬😁😂😃😄😅😆😇😉😊🙂🙃☺️😋😌😍😘😗😙😚😜😝😛🤑🤓😎🤗😏😶😐😑😒🙄🤔😳😞😟😠😡😔😕🙁☹️😣😖😫😩😤😮😱😨😰😯😦😧😢😥😪😓😭😵😲🤐😷🤒🤕😴💤💩😈👿👹👺💀👻👽🤖😺😸😹😻😼😽🙀😿😾🙌👏👋👍👎👊✊✌️👌✋👐💪🙏☝️👆👇👈👉🖕🖐🤘🖖✍💅👄👅👂👃👁👀👤👥🗣👶👦👧👨👩👱👴👵👲👳👮👷💂🕵🎅👼👸👰🚶🏃💃👯👫👬👭🙇💁🙅🙆🙋🙎🙍💇💆💑👩‍❤️‍👩👨‍❤️‍👨💏👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👪👨‍👩‍👧👨‍👩‍👧‍👦👨‍👩‍👦‍👦👨‍👩‍👧‍👧👩‍👩‍👦👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👨‍👨‍👧‍👧👚👕👖👔👗👙👘💄💋👣👠👡👢👞👟👒🎩🎓👑⛑🎒👝👛👜💼👓🕶💍🌂❤️💛💚💙💖💗💓💞💕❣💔💜💘💝]") then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
local tag = db:hget('settings:muteall',msg.chat_id_)
if tag == 'del' then 
if text_msg:match("[\216-\219][\128-\191]") or text_msg:match("[qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM]") or text_msg:match("[😀😬😁😂😃😄😅😆😇😉😊🙂🙃☺️😋😌😍😘😗😙😚😜😝😛🤑🤓😎🤗😏😶😐😑😒🙄🤔😳😞😟😠😡😔😕🙁☹️😣😖😫😩😤😮😱😨😰😯😦😧😢😥😪😓😭😵😲🤐😷🤒🤕😴💤💩😈👿👹👺💀👻👽🤖😺😸😹😻😼😽🙀😿😾🙌👏👋👍👎👊✊✌️👌✋👐💪🙏☝️👆👇👈👉🖕🖐🤘🖖✍💅👄👅👂👃👁👀👤👥🗣👶👦👧👨👩👱👴👵👲👳👮👷💂🕵🎅👼👸👰🚶🏃💃👯👫👬👭🙇💁🙅🙆🙋🙎🙍💇💆💑👩‍❤️‍👩👨‍❤️‍👨💏👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👪👨‍👩‍👧👨‍👩‍👧‍👦👨‍👩‍👦‍👦👨‍👩‍👧‍👧👩‍👩‍👦👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👨‍👨‍👧‍👧👚👕👖👔👗👙👘💄💋👣👠👡👢👞👟👒🎩🎓👑⛑🎒👝👛👜💼👓🕶💍🌂❤️💛💚💙💖💗💓💞💕❣💔💜💘💝]") or text_msg:match("[!@$%^&*(#-_+><}{.,`~]") then
deleteMessages(msg.chat_id_, {[0] = msg.id_})
end
end
end
function on_edit(msg)
local text_msg = msg.new_content_.text_:lower() or nil
local edit = db:hget('settings:edit',msg.chat_id_)
if text_msg:find('https://telegram.me/joinchat') then
deleteMessages(msg.chat_id_, {[0] = msg.message_id_})
end
if edit == 'del' then
deleteMessages(msg.chat_id_, {[0] = msg.message_id_})
end
end