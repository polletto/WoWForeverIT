-- Only known system/loot templates. Player chat events are never registered.
local installed={}
local function safe(v) return type(v)=='string' and not (type(issecretvalue)=='function' and issecretvalue(v)) end
local function itemLinks(text)
 if not WoWForeverIT_GetOption('items') then return text end
 return (text:gsub('(|Hitem:(%d+):[^|]*|h)%[([^%]]+)%](|h)',function(prefix,id,name,suffix)
  local entry=WoWForeverIT_Items and WoWForeverIT_Items[tonumber(id)]
  if entry and entry.en==name then return prefix..'['..entry.it..']'..suffix end
  return prefix..'['..name..']'..suffix
 end))
end
-- Title fingerprint -> Italian title, built once. Scanning every quest ID per
-- "Quest accepted" line hashed the same text thousands of times.
local titleIndex
local function buildTitleIndex(data)
 local index={}
 for _,entry in pairs(data) do
  for name,record in pairs(entry) do
   if type(name)=='string' and (name=='title' or name:sub(1,6)=='title#') and type(record)=='table' and safe(record.it) then
    local hashes=type(record.enHash)=='table' and record.enHash or {record.enHash}
    for _,hash in ipairs(hashes) do
     if type(hash)=='string' then
      local known=index[hash]
      -- Repeated English titles with different translations stay in English.
      if known==nil then index[hash]=record.it elseif known~=record.it then index[hash]=false end
     end
    end
   end
  end
 end
 return index
end
local function questTitle(title)
 if not WoWForeverIT_GetOption('quests') then return title end
 local db=WoWForeverIT_QuestIT
 if not db or not db.Core or not db.DataIT then return title end
 if not titleIndex or titleIndex.data~=db.DataIT then titleIndex={data=db.DataIT,map=buildTitleIndex(db.DataIT)} end
 local found=titleIndex.map[db.Core.EnglishHash(title)]
 if found==nil then found=titleIndex.map[db.Core.AttachedEnglishHash(title)] end
 return found or title
end
function WoWForeverIT_TranslateSystemMessage(event,text)
 if not safe(text) then return nil end
 if event=='CHAT_MSG_MONEY' then
  local money=text:match('^You loot (.+)$')
  if money then
   local known=money:gsub('(%d+) Gold','%1 Oro'):gsub('(%d+) Silver','%1 Argento'):gsub('(%d+) Copper','%1 Rame')
   if known~=money then return 'Raccogli '..known end
  end
 elseif event=='CHAT_MSG_LOOT' then
  local item=text:match('^You receive loot: (.+)$')
  if item then return 'Ricevi il bottino: '..itemLinks(item) end
  local linked=itemLinks(text);if linked~=text then return linked end
 elseif event=='CHAT_MSG_SYSTEM' then
  local accepted=text:match('^Quest accepted: (.+)$')
  if accepted then return 'Missione accettata: '..questTitle(accepted) end
  local skill,rank=text:match('^Your skill in (.-) has increased to (%d+)%.$')
  local skills={Maces='Mazze',Axes='Asce',Swords='Spade',Staves='Bastoni',Daggers='Pugnali',Defense='Difesa',Unarmed='Combattimento senz’armi',Herbalism='Erbalismo',Mining='Estrazione',Skinning='Scuoiatura'}
  if skill and skills[skill] then return 'La tua competenza in '..skills[skill]..' è aumentata a '..rank..'.' end
  local xp=text:match('^You gain (%d+) experience%.$')
  if xp then return 'Ottieni '..xp..' punti esperienza.' end
 end
end
local function filter(_,event,text,...)
 if not WoWForeverIT_GetOption('enabled') or not WoWForeverIT_GetOption('interface') then return false end
 local it=WoWForeverIT_TranslateSystemMessage(event,text)
 if it then return false,it,... end
 return false
end
local function install()
 if type(ChatFrame_AddMessageEventFilter)~='function' then return end
 for _,event in ipairs({'CHAT_MSG_MONEY','CHAT_MSG_LOOT','CHAT_MSG_SYSTEM'}) do
  if not installed[event] then installed[event]=pcall(ChatFrame_AddMessageEventFilter,event,filter) end
 end
end
local frame=CreateFrame('Frame');frame:RegisterEvent('ADDON_LOADED');frame:SetScript('OnEvent',install)
install()
