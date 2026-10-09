-- Scoped display-only spell translation. No game API or global string replacement.
local names=WoWForeverIT_Spells
local bookLabels={Arms='Armi',Fury='Furia',Protection='Protezione'}
local saved=setmetatable({}, {__mode='k'})
local hooked=setmetatable({}, {__mode='k'})
local busy=false
local nameHooks=setmetatable({}, {__mode='k'})
local nameBusy=setmetatable({}, {__mode='k'})
local castRegions=setmetatable({}, {__mode='k'})
local function safe(s)
 return type(s)=='string' and not (type(issecretvalue)=='function' and issecretvalue(s))
end
local function enabled()
 return WoWForeverIT_GetOption('enabled') and WoWForeverIT_GetOption('spells')
end
local function allowed(region)
 if not region then return false end
 -- Nonprotected player cast labels may update in combat; other spell UI stays guarded.
 if type(InCombatLockdown)=='function' and InCombatLockdown() and not castRegions[region] then return false end
 for _,method in ipairs({'IsForbidden','IsProtected'}) do
  if type(region[method])=='function' then
   local ok,value=pcall(region[method],region)
   if not ok or value then return false end
  end
 end
 return type(region.SetText)=='function' and type(region.GetText)=='function'
end
local function plain(s) return s:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r','') end
local function write(region,english,italian)
 if not allowed(region) or not safe(english) then return end
 local prefix=english:match('^(|c%x%x%x%x%x%x%x%x)')
 local output=prefix and (prefix..italian..'|r') or italian
 saved[region]={english=english,italian=output}
 region:SetText(output)
end
function WoWForeverIT_TranslateSpellBody(name,text)
 if not safe(text) then return nil end
 -- Tooltip layout can introduce line breaks, repeated spaces and curly quotes.
 text=plain(text):gsub('’',"'"):gsub('%s+',' '):match('^%s*(.-)%s*$')
 local exact=WoWForeverIT_SpellExactBodies and WoWForeverIT_SpellExactBodies[name]
 if exact and exact[text] then return exact[text] end
 for _,rule in ipairs(WoWForeverIT_SpellBodies[name] or {}) do
  local values={text:match(rule[1])}
  if #values>0 then return string.format(rule[2],(unpack or table.unpack)(values)) end
 end
end
local function tooltipLabel(text)
 if not safe(text) then return nil end
 local labels={Instant='Istantaneo', Magic='Magia', ['Press F6 to submit an issue for this Spell']='Premi F6 per segnalare un problema con questa abilità'}
 labels['Melee Range']='Portata da mischia'
 labels['Requires Battle Stance']='Richiede Postura da Battaglia'
 labels['Requires Battle Stance, Defensive Stance']='Richiede Postura da Battaglia o Postura Difensiva'
 if labels[text] then return labels[text] end
 local minimum,maximum=text:match('^([%d%.,]+)%-([%d%.,]+) yd range$')
 if minimum then return 'Portata: '..minimum..'–'..maximum..' m' end
 local rage=text:match('^([%d%.,]+) Rage$')
 if rage then return rage..' Rabbia' end
 local value=text:match('^([%d%.,]+) yd range$')
 if value then return 'Portata: '..value..' m' end
 value=text:match('^([%d%.,]+) sec cooldown$')
 if value then return 'Tempo di recupero: '..value..' s' end
 value=text:match('^([%d%.,]+) min cooldown$')
 if value then return 'Tempo di recupero: '..value..' min' end
 value=text:match('^([%d%.,]+) sec cast$')
 if value then return 'Lancio: '..value..' s' end
 value=text:match('^([%d%.,]+) seconds remaining$')
 if value then return value..' s rimanenti' end
 value=text:match('^([%d%.,]+) minutes remaining$')
 if value then return value..' min rimanenti' end
end
local translateName
translateName=function(region)
 if not allowed(region) then return end
 local s=region:GetText()
 if safe(s) then
  local translated=names[plain(s)] or bookLabels[plain(s)]
  if translated then write(region,s,translated) end
 end
 if not nameHooks[region] and type(hooksecurefunc)=='function' then
  local ok=pcall(hooksecurefunc,region,'SetText',function(self)
   if nameBusy[self] or not enabled() then return end
   nameBusy[self]=true
   pcall(translateName,self)
   nameBusy[self]=nil
  end)
  if ok then nameHooks[region]=true end
 end
end
local function visit(root,budget,casting)
 if not root or budget<=0 then return budget end
 if type(root.IsForbidden)=='function' then local ok,v=pcall(root.IsForbidden,root);if not ok or v then return budget end end
 if type(root.IsShown)=='function' and not root:IsShown() then return budget end
 budget=budget-1
 if type(root.GetRegions)=='function' then
  local ok,regions=pcall(function() return {root:GetRegions()} end)
  if ok then for _,r in ipairs(regions) do
   if type(r.IsObjectType)=='function' then local good,isFont=pcall(r.IsObjectType,r,'FontString');if good and isFont then if casting then castRegions[r]=true end; translateName(r) end end
  end end
 end
 if type(root.GetChildren)=='function' then
  local ok,children=pcall(function() return {root:GetChildren()} end)
  if ok then for _,child in ipairs(children) do budget=visit(child,budget,casting);if budget<=0 then break end end end
 end
 return budget
end
local function tooltip(tooltip,data,aura)
 if busy or not enabled() or type(data)~='table' then return end
 if type(issecretvalue)=='function' and issecretvalue(data.id) then return end
 if type(data.id)~='number' then return end
 if not tooltip or type(tooltip.GetName)~='function' then return end
 local tooltipName=tooltip:GetName();if not safe(tooltipName) then return end
 local title=_G[tooltipName..'TextLeft1'];if not allowed(title) then return end
 local shown=title:GetText();if not safe(shown) then return end
 local source=plain(shown)
 -- Resolve spell ID from the client, and verify both ID and source name.
 local spellName
 if C_Spell and type(C_Spell.GetSpellName)=='function' then
  local ok,v=pcall(C_Spell.GetSpellName,data.id);if ok and safe(v) then spellName=v end
 elseif type(GetSpellInfo)=='function' then
  local ok,v=pcall(GetSpellInfo,data.id);if ok and safe(v) then spellName=v end
 end
 if not spellName or not names[spellName] or (source~=spellName and source~=names[spellName]) then return end
 busy=true
 pcall(function()
  if source==spellName then write(title,shown,names[spellName]) end
  for i=1,30 do
   for _,side in ipairs({'Left','Right'}) do
   local line=_G[tooltipName..'Text'..side..i]
   if not (i==1 and side=='Left') and allowed(line) then
    local text=line:GetText()
    if safe(text) then
     local translated
     if aura then
      for _,rule in ipairs((WoWForeverIT_AuraBodies or {})[spellName] or {}) do
       local values={plain(text):gsub('%s+',' '):match(rule[1])}
       if #values>0 then translated=string.format(rule[2],(unpack or table.unpack)(values));break end
      end
     else translated=WoWForeverIT_TranslateSpellBody(spellName,plain(text)) end
     translated=translated or WoWForeverIT_TranslateSpellBody(spellName,plain(text)) or tooltipLabel(plain(text))
     if translated then write(line,text,translated) end
    end
   end
   end
  end
  if type(tooltip.Show)=='function' then tooltip:Show() end
 end)
 busy=false
end
local installed=false
local auraInstalled=false
local function install()
 if not auraInstalled and TooltipDataProcessor and Enum and Enum.TooltipDataType and Enum.TooltipDataType.UnitAura then
  local ok=pcall(TooltipDataProcessor.AddTooltipPostCall,Enum.TooltipDataType.UnitAura,function(frame,data)
   if type(data)~='table' then return end
   local id=data.spellId or data.id
   tooltip(frame,{id=id},true)
  end)
  auraInstalled=ok
 end
 if not installed and TooltipDataProcessor and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Spell then
  local ok=pcall(TooltipDataProcessor.AddTooltipPostCall,Enum.TooltipDataType.Spell,tooltip)
  installed=ok
 end
 for _,name in ipairs({'SpellBookFrame','PlayerSpellsFrame','PlayerCastingBarFrame','CastingBarFrame'}) do
  local root=_G[name]
  if root and not hooked[root] and type(root.HookScript)=='function' then
   local ok=pcall(root.HookScript,root,'OnShow',function() WoWForeverIT_RefreshSpells() end)
   if ok then hooked[root]=true end
  end
 end
end
function WoWForeverIT_RefreshSpells()
 install()
 if not enabled() then
  for region,entry in pairs(saved) do
   if allowed(region) and region:GetText()==entry.italian then region:SetText(entry.english) end
  end
  return
 end
 for _,name in ipairs({'SpellBookFrame','PlayerSpellsFrame'}) do pcall(visit,_G[name],1000) end
 -- Player bar only: reuse scoped name hooks for casts and channels.
 for _,name in ipairs({'PlayerCastingBarFrame','CastingBarFrame'}) do
  local root=_G[name]
  if root then
   for _,key in ipairs({'Text','text','SpellName'}) do
    local region=root[key]
    if region and type(region.GetText)=='function' then castRegions[region]=true;pcall(translateName,region) end
   end
   pcall(visit,root,30,true)
  end
 end
end
local deferredCast=false
local events=CreateFrame('Frame')
for _,event in ipairs({'ADDON_LOADED','SPELLS_CHANGED','PLAYER_REGEN_ENABLED','UNIT_SPELLCAST_START','UNIT_SPELLCAST_DELAYED','UNIT_SPELLCAST_STOP','UNIT_SPELLCAST_CHANNEL_START','UNIT_SPELLCAST_CHANNEL_UPDATE'}) do events:RegisterEvent(event) end
events:SetScript('OnEvent',function(_,event,unit)
 if event:match('^UNIT_') and unit~='player' then return end
 WoWForeverIT_RefreshSpells()
 if event:match('^UNIT_') and not deferredCast and C_Timer and type(C_Timer.After)=='function' then
  deferredCast=true
  C_Timer.After(0,function() deferredCast=false;WoWForeverIT_RefreshSpells() end)
 end
end)
if type(hooksecurefunc)=='function' then
 for _,name in ipairs({'SpellBookFrame_Update','SpellBookFrame_UpdateSpells'}) do
  if type(_G[name])=='function' then pcall(hooksecurefunc,name,WoWForeverIT_RefreshSpells) end
 end
end
