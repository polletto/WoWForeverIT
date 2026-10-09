-- Display-only item tooltip localization. Unknown effects remain unchanged.
local saved=setmetatable({}, {__mode='k'})
local active=setmetatable({}, {__mode='k'})
local installed,busy=false,false
local function safe(v) return type(v)=='string' and not (type(issecretvalue)=='function' and issecretvalue(v)) end
local function allowed(r)
 if not r or type(r.GetText)~='function' or type(r.SetText)~='function' then return false end
 if type(InCombatLockdown)=='function' and InCombatLockdown() then return false end
 for _,m in ipairs({'IsForbidden','IsProtected'}) do
  if type(r[m])=='function' then local ok,v=pcall(r[m],r);if not ok or v then return false end end
 end
 return true
end
local function plain(s) return s:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r','') end
function WoWForeverIT_TranslateItemLine(text)
 if not safe(text) then return nil end
 text=plain(text)
 local label=WoWForeverIT_ItemLabels[text];if label then return label end
 local price=text:match('^Sell Price: (.+)$')
 if price then return 'Prezzo di vendita: '..price end
 local value=text:match('^Requires Level (%d+)$');if value then return 'Richiede il livello '..value end
 value=text:match('^Item Level (%d+)$');if value then return 'Livello oggetto '..value end
 value=text:match('^([%d%.,]+) Armor$');if value then return value..' Armatura' end
 local stats={Strength='Forza',Agility='Agilità',Stamina='Tempra',Intellect='Intelletto',Spirit='Spirito'}
 local amount,stat=text:match('^([%+%-][%d%.,]+) (%a+)$')
 if amount and stats[stat] then return amount..' '..stats[stat] end
 local low,high=text:match('^([%d%.,]+) %- ([%d%.,]+) Damage$')
 if low then return low..' - '..high..' Danni' end
 value=text:match('^Speed ([%d%.,]+)$');if value then return 'Velocità '..value end
 value=text:match('^%(([%d%.,]+) damage per second%)$');if value then return '('..value..' danni al secondo)' end
 local blocked=text:match('^([%d%.,]+) Block$');if blocked then return blocked..' Blocco' end
 local schools={Fire='fuoco',Frost='gelo',Nature='natura',Shadow='ombra',Holy='sacro',Arcane='arcano'}
 local lower,upper,school=text:match('^([%d%.,]+) %- ([%d%.,]+) (%a+) Damage$')
 if lower and schools[school] then return lower..' - '..upper..' Danni da '..schools[school] end
 local skill,rank=text:match('^Requires (.-) %((%d+)%)$')
 local skills={Alchemy='Alchimia',Blacksmithing='Forgiatura',Cooking='Cucina',Enchanting='Incantamento',Engineering='Ingegneria',Fishing='Pesca',Herbalism='Erbalismo',Leatherworking='Lavorazione delle Pelli',Mining='Estrazione',Skinning='Scuoiatura',Tailoring='Sartoria',['First Aid']='Primo Soccorso'}
 if skill and skills[skill] then return 'Richiede '..skills[skill]..' ('..rank..')' end
 local current,total=text:match('^Durability (%d+) / (%d+)$')
 if current then return 'Integrità '..current..' / '..total end
end
local function write(r,it)
 local en=r:GetText();if not safe(en) then return end
 local color=en:match('^(|c%x%x%x%x%x%x%x%x)')
 local out=color and color..it..'|r' or it
 saved[r]={en=en,it=out};r:SetText(out)
end
local function enabled() return WoWForeverIT_GetOption('enabled') and WoWForeverIT_GetOption('items') end
local function translate(tip,data)
 if busy or not enabled() or not tip or type(data)~='table' then return end
 if type(issecretvalue)=='function' and issecretvalue(data.id) then return end
 if type(data.id)~='number' or type(tip.GetName)~='function' then return end
 local name=tip:GetName();if not safe(name) then return end
 local title=_G[name..'TextLeft1'];if not allowed(title) then return end
 active[tip]=data
 busy=true
 pcall(function()
  local entry=WoWForeverIT_Items[data.id]
  local shown=title:GetText()
  local original=saved[title]
  if original and shown==original.it then shown=original.en end
  local description=WoWForeverIT_ItemDescriptions and WoWForeverIT_ItemDescriptions[data.id]
  local descriptionAllowed=description and safe(shown) and plain(shown)==description.enName
  if entry and safe(shown) and plain(shown)==entry.en then write(title,entry.it) end
  local n=type(tip.NumLines)=='function' and tip:NumLines() or 0
  for i=2,math.min(n,40) do
   for _,side in ipairs({'Left','Right'}) do
    local r=_G[name..'Text'..side..i]
    if allowed(r) then
     local text=r:GetText()
     local it=WoWForeverIT_TranslateItemLine(text)
     if not it and data.id==247841 and safe(shown) and plain(shown)=='Wild Harvest' and safe(text) then
      if plain(text)=='Use: Increases your Herbalism skill by 2. Cannot raise Herbalism skill over 15. You will learn Herbalism if it is not already trained and you do not already know two other professions.' then
       it='Usa: aumenta la competenza in Erbalismo di 2, fino a un massimo di 15. Imparerai Erbalismo se non lo conosci già e non hai già appreso altre due professioni.'
      end
     end
     if not it and descriptionAllowed and safe(text) then
      local source=plain(text)
      if source==description.en then it=description.it
      elseif source=='"'..description.en..'"' then it='"'..description.it..'"' end
     end
     if it then write(r,it) end
    end
   end
  end
 end)
 busy=false
end
function WoWForeverIT_RefreshItems()
 if not installed and TooltipDataProcessor and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Item then
  installed=pcall(TooltipDataProcessor.AddTooltipPostCall,Enum.TooltipDataType.Item,translate)
 end
 if not enabled() then
  for r,v in pairs(saved) do if allowed(r) and r:GetText()==v.it then r:SetText(v.en) end end
 else
  for tip,data in pairs(active) do
   if type(tip.IsShown)=='function' and tip:IsShown() and type(tip.GetTooltipData)=='function' then
    local ok,current=pcall(tip.GetTooltipData,tip)
    if ok and type(current)=='table' and not (type(issecretvalue)=='function' and issecretvalue(current.id)) and type(current.id)=='number' and current.id==data.id then translate(tip,current) end
   end
  end
 end
end
local events=CreateFrame('Frame')
for _,event in ipairs({'ADDON_LOADED','PLAYER_REGEN_ENABLED'}) do events:RegisterEvent(event) end
events:SetScript('OnEvent',WoWForeverIT_RefreshItems)
WoWForeverIT_RefreshItems()
