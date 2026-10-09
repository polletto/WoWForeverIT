-- Display-only creature tooltip and nameplate localization; unit APIs stay unchanged.
local saved=setmetatable({}, {__mode='k'})
local installed=false
local function safe(v) return type(v)=='string' and not (type(issecretvalue)=='function' and issecretvalue(v)) end
local function allowed(r)
 if not r or type(r.GetText)~='function' or type(r.SetText)~='function' then return false end
 if type(InCombatLockdown)=='function' and InCombatLockdown() then return false end
 for _,method in ipairs({'IsForbidden','IsProtected'}) do
  if type(r[method])=='function' then local ok,v=pcall(r[method],r);if not ok or v then return false end end
 end
 return true
end
function WoWForeverIT_TranslateCreatureName(guid,name)
 if not safe(guid) or not safe(name) then return nil end
 local kind,id=guid:match('^(%a+)%-[^%-]+%-[^%-]+%-[^%-]+%-[^%-]+%-(%d+)%-')
 if kind~='Creature' and kind~='Vehicle' then return nil end
 local entry=WoWForeverIT_Creatures[tonumber(id)]
 if entry and name==entry.en then return entry.it end
end
local function translate(tip,data)
 if not WoWForeverIT_GetOption('enabled') or not WoWForeverIT_GetOption('creatures') then return end
 if not tip or type(tip.GetName)~='function' or type(tip.GetUnit)~='function' then return end
 local ok,_,unit=pcall(tip.GetUnit,tip)
 if not ok or not safe(unit) then return end
 if type(UnitGUID)~='function' or type(UnitName)~='function' then return end
 local good,guid=pcall(UnitGUID,unit);if not good or not safe(guid) then return end
 local kind=guid:match('^(%a+)%-');if kind~='Creature' and kind~='Vehicle' then return end
 local got,name=pcall(UnitName,unit);if not got or not safe(name) then return end
 local tipName=tip:GetName();if not safe(tipName) then return end
 local labels={Beast='Bestia',Corpse='Cadavere',['Press F6 to submit an issue for this Creature']='Premi F6 per segnalare un problema con questa creatura'}
 local n=type(tip.NumLines)=='function' and tip:NumLines() or 0
 for i=2,math.min(n,20) do
  local r=_G[tipName..'TextLeft'..i]
  if allowed(r) then
   local text=r:GetText()
   if safe(text) then
    local raw=text:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r','')
    local it=labels[raw];local level=raw:match('^Level (%d+)$')
    if level then it='Livello '..level end
    if it then local color=text:match('^(|c%x%x%x%x%x%x%x%x)');local out=color and color..it..'|r' or it;saved[r]={en=text,it=out};r:SetText(out) end
   end
  end
 end
 local line=_G[tipName..'TextLeft1'];if not allowed(line) then return end
 local shown=line:GetText();if not safe(shown) then return end
 local plain=shown:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r','')
 if plain~=name then return end
 local it=WoWForeverIT_TranslateCreatureName(guid,name);if not it then return end
 local color=shown:match('^(|c%x%x%x%x%x%x%x%x)');local output=color and color..it..'|r' or it
 saved[line]={en=shown,it=output};line:SetText(output)
end
function WoWForeverIT_RefreshCreatures()
 if not installed and TooltipDataProcessor and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Unit then
  installed=pcall(TooltipDataProcessor.AddTooltipPostCall,Enum.TooltipDataType.Unit,translate)
 end
 if not WoWForeverIT_GetOption('enabled') or not WoWForeverIT_GetOption('creatures') then
  for line,v in pairs(saved) do if allowed(line) and line:GetText()==v.it then line:SetText(v.en) end end
 elseif GameTooltip and type(GameTooltip.IsShown)=='function' and GameTooltip:IsShown() then
  pcall(translate,GameTooltip)
 end
end
local events=CreateFrame('Frame')
for _,event in ipairs({'ADDON_LOADED','PLAYER_REGEN_ENABLED'}) do events:RegisterEvent(event) end
events:SetScript('OnEvent',WoWForeverIT_RefreshCreatures)
WoWForeverIT_RefreshCreatures()

-- Nameplate FontStrings: refresh from current unit identity on every rewrite.
local plates=setmetatable({}, {__mode='k'})
local plateHooks=setmetatable({}, {__mode='k'})
local plateBusy=setmetatable({}, {__mode='k'})
local function plateAllowed(label)
 if not label or type(label.SetText)~='function' or type(label.GetText)~='function' then return false end
 for _,method in ipairs({'IsForbidden','IsProtected'}) do
  if type(label[method])=='function' then local ok,v=pcall(label[method],label);if not ok or v then return false end end
 end
 return true
end
local function updatePlate(label)
 if plateBusy[label] or not plateAllowed(label) then return end
 local unit=plates[label];if not safe(unit) then return end
 if type(UnitIsPlayer)=='function' then local ok,player=pcall(UnitIsPlayer,unit);if not ok or (type(issecretvalue)=='function' and issecretvalue(player)) or player then return end end
 if type(UnitGUID)~='function' or type(UnitName)~='function' then return end
 local ok,guid=pcall(UnitGUID,unit);if not ok or not safe(guid) then return end
 local good,name=pcall(UnitName,unit);if not good or not safe(name) then return end
 local en=label:GetText();if not safe(en) then return end
 local old=saved[label]
 if not WoWForeverIT_GetOption('enabled') or not WoWForeverIT_GetOption('creatures') then
  if old and en==old.it then plateBusy[label]=true;label:SetText(old.en);plateBusy[label]=nil end
  return
 end
 local it=WoWForeverIT_TranslateCreatureName(guid,name)
 local plain=en:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r','')
 if not it or plain~=name then return end
 local color=en:match('^(|c%x%x%x%x%x%x%x%x)');local output=color and color..it..'|r' or it
 saved[label]={en=en,it=output};plateBusy[label]=true;label:SetText(output);plateBusy[label]=nil
end
local function attachPlate(unit)
 if not safe(unit) or not C_NamePlate or type(C_NamePlate.GetNamePlateForUnit)~='function' then return end
 local ok,plate=pcall(C_NamePlate.GetNamePlateForUnit,unit);if not ok or not plate then return end
 local frame=plate.UnitFrame
 if not frame then return end
 local label=frame.name or frame.Name
 if not plateAllowed(label) then return end
 plates[label]=unit
 if not plateHooks[label] and type(hooksecurefunc)=='function' then
  local hooked=pcall(hooksecurefunc,label,'SetText',function(self) pcall(updatePlate,self) end)
  if hooked then plateHooks[label]=true end
 end
 pcall(updatePlate,label)
end
local refreshTooltip=WoWForeverIT_RefreshCreatures
function WoWForeverIT_RefreshCreatures()
 refreshTooltip()
 for label in pairs(plates) do pcall(updatePlate,label) end
end
local plateEvents=CreateFrame('Frame')
for _,event in ipairs({'NAME_PLATE_UNIT_ADDED','NAME_PLATE_UNIT_REMOVED','UNIT_NAME_UPDATE','PLAYER_REGEN_ENABLED'}) do plateEvents:RegisterEvent(event) end
plateEvents:SetScript('OnEvent',function(_,event,unit)
 if event=='NAME_PLATE_UNIT_REMOVED' then
  for label,token in pairs(plates) do if token==unit then plates[label]=nil;saved[label]=nil end end
 elseif event=='PLAYER_REGEN_ENABLED' then WoWForeverIT_RefreshCreatures()
 else attachPlate(unit) end
end)

-- Target name uses the same identity guards as creature nameplates.
local function attachTarget()
 local label=TargetFrame and (TargetFrame.name or (TargetFrame.TargetFrameContent and TargetFrame.TargetFrameContent.TargetFrameContentMain and TargetFrame.TargetFrameContent.TargetFrameContentMain.Name)) or TargetFrameName
 if not plateAllowed(label) then return end
 plates[label]='target'
 if not plateHooks[label] and type(hooksecurefunc)=='function' then
  local ok=pcall(hooksecurefunc,label,'SetText',function(self) pcall(updatePlate,self) end)
  if ok then plateHooks[label]=true end
 end
 pcall(updatePlate,label)
end
local refreshPlates=WoWForeverIT_RefreshCreatures
function WoWForeverIT_RefreshCreatures()
 refreshPlates();pcall(attachTarget)
end
local targetEvents=CreateFrame('Frame')
for _,event in ipairs({'PLAYER_TARGET_CHANGED','UNIT_NAME_UPDATE','PLAYER_REGEN_ENABLED','ADDON_LOADED'}) do targetEvents:RegisterEvent(event) end
targetEvents:SetScript('OnEvent',function() pcall(attachTarget) end)
pcall(attachTarget)
