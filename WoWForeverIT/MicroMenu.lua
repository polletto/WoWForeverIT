-- Micro menu tooltip text only; icon behavior and keybindings remain intact.
local titles={
 ['Friend Requests']='Richieste di amicizia',['Friend Request']='Richiesta di amicizia',
 ['Friends List']='Lista amici',['Recent Players']='Giocatori recenti',
 ['Blocked Players']='Giocatori bloccati',['Add Friend']='Aggiungi un amico',

 Professions='Professioni',Legacy='Retaggio',['Guild & Communities']='Gilda e comunità',
 ['The shop is currently unavailable.']='Il negozio non è attualmente disponibile.',
 ['Character Info']='Informazioni personaggio',Character='Personaggio',
 ['Spellbook & Abilities']='Grimorio e abilità',['Spellbook & Powers']='Grimorio e poteri',
 Spellbook='Grimorio',Talents='Talenti',['Talents & Specialization']='Talenti e specializzazione',
 ['Quest Log']='Registro missioni',['Map & Quest Log']='Mappa e registro missioni',
 ['World Map']='Mappa del mondo',Social='Sociale',Friends='Amici',Guild='Gilda',
 ['Looking For Group']='Ricerca gruppo',['Group Finder']='Ricerca gruppo',
 ['Dungeon Finder']='Ricerca spedizioni',Collections='Collezioni',
 Achievements='Imprese',['Game Menu']='Menu di gioco',Help='Aiuto',
 ['Customer Support']='Assistenza clienti',Shop='Negozio',['Adventure Guide']='Guida alle avventure',
}
local owners={FriendsFrame=true,SocialFrame=true,BattleNetFriendsFrame=true,CharacterMicroButton=true,SpellbookMicroButton=true,TalentMicroButton=true,
 ProfessionMicroButton=true,ProfessionsMicroButton=true,LegacyMicroButton=true,
 QuestLogMicroButton=true,SocialsMicroButton=true,FriendsMicroButton=true,GuildMicroButton=true,
 LFDMicroButton=true,LFGMicroButton=true,CollectionsMicroButton=true,AchievementMicroButton=true,
 MainMenuMicroButton=true,HelpMicroButton=true,StoreMicroButton=true,EJMicroButton=true,WorldMapMicroButton=true}
local saved=setmetatable({}, {__mode='k'})
local installed,busy=false,false
local function safe(s) return type(s)=='string' and not (type(issecretvalue)=='function' and issecretvalue(s)) end
local function allowed(r)
 if not r or type(r.GetText)~='function' or type(r.SetText)~='function' then return false end
 for _,m in ipairs({'IsForbidden','IsProtected'}) do if type(r[m])=='function' then local ok,v=pcall(r[m],r);if not ok or v then return false end end end
 return true
end
local function belongs(tip)
 if not tip or type(tip.GetOwner)~='function' then return false end
 local owner=tip:GetOwner()
 for _=1,8 do
  if not owner then return false end
  for name in pairs(owners) do if owner==_G[name] then return true end end
  if type(owner.GetName)=='function' then local ok,name=pcall(owner.GetName,owner);if ok and safe(name) and owners[name] then return true end end
  if type(owner.GetParent)~='function' then return false end
  local ok,parent=pcall(owner.GetParent,owner);if not ok then return false end;owner=parent
 end
 return false
end
function WoWForeverIT_TranslateMicroMenuLine(raw)
 if not safe(raw) then return nil end
 local plain=raw:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r','')
 local it=titles[plain]
 local level=plain:match("^This feature becomes available at level (%d+)%.?$")
 if level then it="Questa funzione diventa disponibile al livello "..level.."." end
 if not it then local title,binding=plain:match('^(.-) %(([^%)]+)%)$');if title and titles[title] then it=titles[title]..' ('..binding..')' end end
 if not it then return nil end
 local color=raw:match('^(|c%x%x%x%x%x%x%x%x)');return color and color..it..'|r' or it
end
local function translate()
 if busy or not WoWForeverIT_GetOption('enabled') or not WoWForeverIT_GetOption('interface') or not belongs(GameTooltip) then return end
 if type(GameTooltip.GetName)~='function' or type(GameTooltip.NumLines)~='function' then return end
 local name=GameTooltip:GetName();if not safe(name) then return end
 busy=true
 pcall(function()
  for i=1,math.min(GameTooltip:NumLines(),15) do
   local line=_G[name..'TextLeft'..i]
   if allowed(line) then local en=line:GetText();local it=WoWForeverIT_TranslateMicroMenuLine(en);if it then saved[line]={en=en,it=it};line:SetText(it) end end
  end
  if type(GameTooltip.Show)=='function' then GameTooltip:Show() end
 end)
 busy=false
end
function WoWForeverIT_RefreshMicroMenu()
 if not installed and GameTooltip and type(hooksecurefunc)=='function' then installed=pcall(hooksecurefunc,GameTooltip,'Show',function() pcall(translate) end) end
 if not WoWForeverIT_GetOption('enabled') or not WoWForeverIT_GetOption('interface') then
  for line,v in pairs(saved) do if allowed(line) and line:GetText()==v.it then line:SetText(v.en) end end
 else pcall(translate) end
end
local event=CreateFrame('Frame');event:RegisterEvent('ADDON_LOADED');event:SetScript('OnEvent',WoWForeverIT_RefreshMicroMenu)
WoWForeverIT_RefreshMicroMenu()
