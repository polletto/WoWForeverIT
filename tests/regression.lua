
local function field(text, kind, name)
 local f={text=text,kind=kind or 'FontString',name=name}
 function f:GetText() return self.text end
 function f:SetText(s) self.text=s end
 function f:IsObjectType(k) return self.kind==k end
 function f:GetName() return self.name end
 function f:GetParent() return self.parent end
 return f
end
local function frame(...)
 local f={regions={...},visible=true}
 function f:IsForbidden() return false end
 function f:IsShown() return self.visible end
 function f:GetRegions() return (unpack or table.unpack)(self.regions) end
 function f:GetChildren() return end
 function f:HookScript(k,fn) self[k]=fn end
 function f:RegisterEvent() end
 function f:SetScript(k,fn) self[k]=fn end
 return f
end
UnitName=function() return 'Averdan Test' end
UnitClass=function() return 'Priest','PRIEST' end
UnitRace=function() return 'Undead','Scourge' end
UnitSex=function() return 2 end
local eventFrame
CreateFrame=function() local created=frame();eventFrame=eventFrame or created;return created end
SlashCmdList={}
local pending = {}
C_Timer={After=function(_,fn) pending[#pending+1]=fn end,NewTicker=function(_,fn) pulse=fn end}
local function drain()
 local callbacks=pending;pending={}
 for _,fn in ipairs(callbacks) do fn() end
end
local hookCount=0
hooksecurefunc=function(target, method, callback)
 if type(target)=='string' then callback=method;method=target;target=_G end
 local original=assert(target[method]);hookCount=hookCount+1
 target[method]=function(...)
  original(...)
  callback(...)
 end
end
QuestInfo_ShowTitle=function() QuestInfoTitleHeader:SetText(GetTitleText()) end
QuestInfo_ShowDescriptionText=function() QuestInfoDescriptionText:SetText(GetQuestText()) end
QuestInfo_ShowObjectivesText=function() QuestInfoObjectivesText:SetText(GetObjectiveText()) end
local id=369
GetQuestID=function() return id end
GetTitleText=function() return 'A New Plague' end
GetQuestText=function() return 'A new, changed beta description.' end
GetObjectiveText=function() return 'An objective changed in beta.' end
GetProgressText=function() return 'Changed progress.' end
GetRewardText=function() return 'Changed reward.' end
GetQuestLogQuestText=function() return GetQuestText(),GetObjectiveText() end
C_QuestLog={GetSelectedQuest=function() return id end,GetTitleForQuestID=function(q) return q==369 and 'A New Plague' or 'Unknown quest' end,
 GetNumQuestLogEntries=function() return 1 end,GetInfo=function() return {questID=id,title=GetTitleText()} end}
QuestInfoFrame={questLog=false}
QuestFrame=frame()
QuestInfoTitleHeader=field('A New Plague')
QuestInfoDescriptionText=field(GetQuestText())
QuestInfoObjectivesText=field(GetObjectiveText())
QuestProgressText=field(GetProgressText())
QuestInfoRewardText=field(GetRewardText())
local menu=field('Options','Button')
GameMenuFrame=frame(menu)
local graphic=field('Graphics')
local search=field('Save','EditBox')
SettingsPanel=frame(graphic,search)
local macro=field('Save','Button','MacroButton1')
local macroName=field('Save');macroName.parent=macro
local saveButton=field('Save','Button','MacroSaveButton')
MacroFrame=frame(macro,macroName,saveButton)
local counter=field('Quests: |cffffffff3/25|r')
WorldMapFrame=frame(counter)
local header=field('A New Plague')
QuestObjectiveTracker={usedBlocks={[369]={id=369,HeaderText=header}},
 Update=function() header:SetText('A New Plague') end}
QuestMapFrame_UpdateAll=function()
 counter:SetText('Quests: |cffffffff3/25|r')
 QuestInfoTitleHeader:SetText(GetTitleText())
end

local tooltipTitle=field('A New Plague')
local tooltipObjective=field('0/6 Windsong Crawler Meat')
local tooltipHelp=field('Press F6 to submit an issue for this Quest')
GameTooltipTextLeft1=tooltipTitle;GameTooltipTextLeft2=tooltipObjective;GameTooltipTextLeft3=tooltipHelp
GameTooltip={}
function GameTooltip:GetName() return 'GameTooltip' end
function GameTooltip:GetOwner() return self.owner end
function GameTooltip:NumLines() return 3 end
function GameTooltip:Show() end
function GameTooltip:AddLine(text) tooltipHelp:SetText(text) end
QuestMapLogTitleButton_OnEnter=function(owner)
 GameTooltip.owner=owner
 tooltipTitle:SetText('A New Plague')
 tooltipObjective:SetText('0/6 Windsong Crawler Meat')
 tooltipHelp:SetText('Press F6 to submit an issue for this Quest')
 GameTooltip:Show()
end
QuestPinMixin={OnMouseEnter=QuestMapLogTitleButton_OnEnter}
QuestLogQuests_Update=function() counter:SetText('Quests: |cffffffff3/25|r') end

for line in io.lines("WoWForeverIT/WoWForeverIT.toc") do
 if line:match("%.lua$") then
  local chunk = assert(loadfile("WoWForeverIT/" .. line))
  chunk("WoWForeverIT")
 end
end

assert(WoWForeverIT_TranslateField(369,'title','A New Plague')=='Una nuova piaga')
assert(WoWForeverIT_TranslateField(369,'title','A Changed Quest')==nil)
assert(WoWForeverIT_TranslateField(369,'text',GetQuestText())==nil)
local count=0;for _ in pairs(WoWForeverIT_QuestIT.DataIT) do count=count+1 end;assert(count==2464)
assert(WoWForeverIT_TranslateField(92698,'title','What Is My Purpose?')=='Qual è il mio scopo?')
assert(WoWForeverIT_TranslateField(92682,'title','Make Yourself Useful')=='Renditi utile')
assert(WoWForeverIT_TranslateField(92682,'text','Unknown description')==nil)
assert(WoWForeverIT_TranslateField(92682,'progress',"These bandits are more likely to double cross and steal from each other than they are to steal from normal folks. I bet if Ferauu knew some of his people went rogue and came here early to tamper with the harvest, he'd kill them himself.")~=nil)
assert(WoWForeverIT_TranslateObjectiveLine('0/6 Windsong Crawler Meat')=='0/6 Carne di Granchio di Cantovento')
assert(WoWForeverIT_TranslateObjectiveLine('- 3/7 Lowlands Galestrider Tenderloin')=='- 3/7 Filetto di Calcavento delle Pianure')
assert(WoWForeverIT_TranslateObjectiveLine('9/10 Unknown Item')==nil)
assert(QuestIT==nil,'must not collide with installed QuestIT')
assert(WoWForeverIT_QuestIT.Core.RenderItalian('Ciao $N $L, $Geroe:eroina;!',{first='Averdan',last='Test',sex=3})=='Ciao Averdan Test, eroina!')
eventFrame:OnEvent('ADDON_LOADED','WoWForeverIT')
eventFrame:OnEvent('QUEST_DETAIL')
pulse()
assert(QuestInfoTitleHeader.text=='Una nuova piaga')
assert(QuestInfoDescriptionText.text==GetQuestText(),'changed fields stay English')
assert(header.text=='Una nuova piaga')
assert(counter.text=='Missioni: |cffffffff3/25|r')
assert(menu.text=='Opzioni' and graphic.text=='Grafica')
assert(search.text=='Save' and macro.text=='Save' and macroName.text=='Save')
assert(saveButton.text=='Salva')
graphic.text='Audio';pulse();assert(graphic.text=='Audio')
graphic.text='Controls';pulse();assert(graphic.text=='Comandi')
id=999999
QuestInfoTitleHeader.text='Unknown quest';eventFrame:OnEvent('QUEST_DETAIL')
assert(QuestInfoTitleHeader.text==GetTitleText(),'untranslated quest uses live title')
SlashCmdList.WOWFOREVERIT('toggle')
assert(menu.text=='Options' and graphic.text=='Controls' and header.text=='A New Plague')
assert(counter.text=='Quests: |cffffffff3/25|r')
print('PASS: database count, fingerprints, placeholders, tracker, counter, menu redraw, editable text, toggle and quest changes')

assert(WoWForeverIT_TranslateObjectiveLine("0/1 Obtain Crystallized lightning\nfrom the Shrieking Cave") == "0/1 Recupera il Fulmine Cristallizzato nella Grotta Stridente")
assert(WoWForeverIT_TranslateObjectiveLine("- 0/1 Obtain  CRYSTALLIZED lightning from the Shrieking Cave") == "- 0/1 Recupera il Fulmine Cristallizzato nella Grotta Stridente")

-- Redraw callbacks must translate before a timer or safety pulse runs.
SlashCmdList.WOWFOREVERIT('toggle') -- back to Italian
id=369
QuestInfoFrame.questLog=true;QuestFrame.visible=false
drain()
QuestMapFrame_UpdateAll()
assert(counter.text=='Missioni: |cffffffff3/25|r')
assert(QuestInfoTitleHeader.text=='Una nuova piaga')
QuestObjectiveTracker:Update()
assert(header.text=='Una nuova piaga')
WorldMapFrame.OnShow(WorldMapFrame)
assert(counter.text=='Missioni: |cffffffff3/25|r')
-- Functions loaded after login get hooks exactly once.
QuestMapFrame_UpdateQuests=function() counter:SetText('Quests: |cffffffff4/25|r') end
eventFrame:OnEvent('ADDON_LOADED','Blizzard_QuestMap')
local installed=hookCount
eventFrame:OnEvent('QUEST_LOG_UPDATE');eventFrame:OnEvent('QUEST_LOG_UPDATE')
assert(hookCount==installed,'redraw hooks must not accumulate')
assert(#pending==1,'event retries must coalesce')
QuestMapFrame_UpdateQuests()
assert(counter.text=='Missioni: |cffffffff4/25|r')
SlashCmdList.WOWFOREVERIT('toggle')
QuestMapFrame_UpdateAll();QuestObjectiveTracker:Update()
assert(counter.text=='Quests: |cffffffff3/25|r' and header.text=='A New Plague')
assert(WoWForeverIT_TranslateObjectiveLine("3/10 Al'Aketh Windstone Charm")=="3/10 Amuleto di Pietra del Vento degli Al'Aketh")
assert(WoWForeverIT_TranslateField(92871,'title','In Service of Zephras')=='Al servizio di Zephras')
assert(WoWForeverIT_TranslateField(93746,'title','A Firm Response')=='Una risposta decisa')
assert(WoWForeverIT_TranslateField(93461,'text','Changed source')==nil)
print('PASS: immediate redraws, lazy hooks, coalesced timers, toggle and added quest records')

assert(WoWForeverIT_TranslateField(87,'title','Goldtooth')=='Dentedoro')
assert(WoWForeverIT_TranslateField(3904,'title',"Milly's Harvest")=="Il raccolto di Milly")
assert(WoWForeverIT_TranslateField(3905,'title','Grape Manifest')=="Elenco dell'uva")
assert(WoWForeverIT_TranslateField(398,'title','Wanted: Maggot Eye')=='Ricercato: Maggot Eye')
assert(WoWForeverIT_TranslateField(87,'title','Changed beta title')==nil)
local title87=WoWForeverIT_QuestIT.DataIT[87].title
local translated87=title87.it
title87.it='Traduzione locale da conservare'
dofile('WoWForeverIT/Locales/Reused-Titles.lua')
assert(title87.it=='Traduzione locale da conservare','reuse must not overwrite existing Italian titles')
title87.it=translated87
print('PASS: reused titles retain fingerprints and preserve existing Italian fields')

WoWForeverIT_SetTooltipLanguage(true)
local owner={info={questID=369}}
QuestMapLogTitleButton_OnEnter(owner)
assert(tooltipTitle.text=='Una nuova piaga')
assert(tooltipObjective.text=='0/6 Carne di Granchio di Cantovento')
assert(tooltipHelp.text=='Premi F6 per segnalare un problema con questa missione')
GameTooltip:AddLine('Press F6 to submit an issue for this Quest')
assert(tooltipHelp.text=='Premi F6 per segnalare un problema con questa missione')
WoWForeverIT_SetTooltipLanguage(false)
assert(tooltipTitle.text=='A New Plague')
assert(tooltipObjective.text=='0/6 Windsong Crawler Meat')
WoWForeverIT_SetTooltipLanguage(true)
GameTooltip.owner={itemID=123}
tooltipTitle:SetText('A New Plague');tooltipObjective:SetText('0/6 Windsong Crawler Meat')
GameTooltip:Show()
assert(tooltipTitle.text=='A New Plague' and tooltipObjective.text=='0/6 Windsong Crawler Meat')
local pin={questID=369}
QuestPinMixin.OnMouseEnter(pin)
assert(tooltipTitle.text=='Una nuova piaga')
QuestMapLogTitleButton_OnEnter({questID=999999})
assert(tooltipTitle.text=='A New Plague')
-- Hover-triggered log rebuilds do not wait for a timer.
SlashCmdList.WOWFOREVERIT('toggle') -- Italian
QuestLogQuests_Update()
assert(counter.text=='Missioni: |cffffffff3/25|r')
print('PASS: quest tooltips, late lines, unknown titles, unrelated tooltips, language toggle and hover redraws')

-- The beta wraps tooltip titles and F6 instructions in inline color codes.
QuestMapLogTitleButton_OnEnter({questID=93736})
tooltipTitle:SetText('|cffffff00[9] Unwelcome Spirits|r')
tooltipHelp:SetText('|cff00aaffPress F6 to submit an issue for this Quest|r')
GameTooltip:Show()
assert(tooltipTitle.text=='|cffffff00[9] Spiriti indesiderati|r')
assert(tooltipHelp.text=='|cff00aaffPremi F6 per segnalare un problema con questa missione|r')
WoWForeverIT_SetTooltipLanguage(false)
assert(tooltipTitle.text=='|cffffff00[9] Unwelcome Spirits|r')
WoWForeverIT_SetTooltipLanguage(true)
tooltipTitle:SetText('|cffffff00[9]|r |cffffff00Unwelcome Spirits|r')
GameTooltip:Show()
assert(tooltipTitle.text=='|cffffff00[9]|r |cffffff00Spiriti indesiderati|r')
print('PASS: colored tooltip titles, split level colors, colored F6 instruction and exact restoration')

-- Forever can populate a pin tooltip through another handler, without the mixin hook.
C_QuestLog.GetTitleForQuestID=function(q) return q==94897 and 'The Fate of a Loved One' or 'A New Plague' end
C_QuestLog.GetInfo=function() return {questID=94897,title='The Fate of a Loved One'} end
local unhookedPin={GetParent=function() return WorldMapFrame end}
GameTooltip.owner=unhookedPin
tooltipTitle:SetText('|cffffff00[11] The Fate of a Loved One|r')
tooltipHelp:SetText('|cff00aaffPress |r|cff00aaffF6 to submit an issue for this Quest|r')
GameTooltip:Show()
assert(tooltipTitle.text=='|cffffff00[11] Il destino di una persona amata|r')
assert(tooltipHelp.text=='|cff00aaffPremi F6 per segnalare un problema con questa missione|r')
GameTooltip.owner={GetParent=function() return nil end}
tooltipTitle:SetText('|cffffff00[11] The Fate of a Loved One|r')
GameTooltip:Show()
assert(tooltipTitle.text=='|cffffff00[11] The Fate of a Loved One|r')
print('PASS: unhooked map pins resolve from exact live quest titles; foreign owners remain untouched')

-- Panels loaded after login: labels translate on show and after a redraw,
-- while user-entered search text and unknown spell names remain intact.
local strength=field('Strength')
local typed=field('Strength','EditBox')
CharacterFrame=frame(strength,typed)
local profession=field('Alchemy')
local createAll=field('Create All','Button')
local recipe=field('Unmapped beta recipe')
TradeSkillFrame=frame(profession,createAll,recipe)
PaperDollFrame_UpdateStats=function() strength:SetText('Strength') end
TradeSkillFrame_Update=function() createAll:SetText('Create All') end
-- Put the shared UI toggle in a known state.
SlashCmdList.WOWFOREVERIT('toggle')
SlashCmdList.WOWFOREVERIT('toggle')
pulse()
assert(strength:GetText()=='Forza' and typed:GetText()=='Strength')
assert(profession:GetText()=='Alchimia' and createAll:GetText()=='Crea tutto')
assert(recipe:GetText()=='Unmapped beta recipe')
PaperDollFrame_UpdateStats()
TradeSkillFrame_Update()
assert(strength:GetText()=='Forza' and createAll:GetText()=='Crea tutto')
SlashCmdList.WOWFOREVERIT('toggle')
assert(strength:GetText()=='Strength' and createAll:GetText()=='Create All')
SlashCmdList.WOWFOREVERIT('toggle')
CharacterFrame.OnShow()
assert(strength:GetText()=='Forza')
print('PASS: late character/profession panels, immediate redraws, editable text and language restoration')
local statColon=field('|cffffff00Strength:|r')
local levelLabel=field('Level 2 Mage')
local weaponsLabel=field('Weapons')
local speedLabel=field('Movement Speed:')
CharacterFrame.regions={statColon,levelLabel,weaponsLabel,speedLabel}
CharacterFrame.OnShow()
assert(statColon:GetText()=='|cffffff00Forza:|r')
assert(levelLabel:GetText()=='Livello 2 Mago')
assert(weaponsLabel:GetText()=='Armi' and speedLabel:GetText()=='Velocità di movimento:')
print('PASS: beta character labels with colons, inline colors and level/class heading')
levelLabel:SetText('Level 2 |cff3fc7ebMage|r')
CharacterFrame.OnShow()
assert(levelLabel:GetText()=='Livello 2 |cff3fc7ebMago|r')
local tooltipTab={GetParent=function() return CharacterFrame end}
GameTooltip.owner=tooltipTab
pulse() -- installs the scoped character tooltip hook
GameTooltipTextLeft1:SetText('Character Stats')
GameTooltipTextLeft2:SetText("|cffff0000You don't have any titles.|r")
GameTooltip:Show()
assert(GameTooltipTextLeft1:GetText()=='Statistiche personaggio')
assert(GameTooltipTextLeft2:GetText()=='|cffff0000Non hai ancora titoli.|r')
GameTooltip.owner={GetParent=function() return nil end}
GameTooltipTextLeft1:SetText('Character Stats')
GameTooltip:Show()
assert(GameTooltipTextLeft1:GetText()=='Character Stats')
print('PASS: class color spans and scoped character tab tooltips')
local rankLabel=field('Rank 1')
local pageLabel=field('Page 1/1')
local racialLabel=field('Racial Passive')
local spellName=field('Fireball')
SpellBookFrame=frame(rankLabel,pageLabel,racialLabel,spellName)
pulse()
assert(rankLabel:GetText()=='Grado 1' and pageLabel:GetText()=='Pagina 1/1')
assert(racialLabel:GetText()=='Passiva razziale' and spellName:GetText()=='Fireball')
print('PASS: spellbook page/rank labels preserve unknown spell names')
local hidePassive=field('Hide Passives','Button')
local sourceFilter=field('Boss Drop','Button')
local customName=field('Unmapped custom filter','Button')
DropDownList1=frame(hidePassive,sourceFilter,customName)
pulse()
DropDownList1.OnShow()
assert(hidePassive:GetText()=='Nascondi abilità passive' and sourceFilter:GetText()=='Bottino dei boss')
assert(customName:GetText()=='Unmapped custom filter')
print('PASS: detached filter dropdowns translate exact labels only')
local beta98389=[[Greetings, mage. Yes, I am a paladin. Not even death can stop the Light.

This is something my kind have in common with all Forsaken--we have overcome what the living view as their end. However, some even among our own fear us; they suspect we will smite them as some monstrosity.

In truth, our relationship with undeath is complex, but I am not here to hurt our own. Help me show the others this. Venture to Night's Web Hollow to the northwest and free the freshly raised fools trapped by the spiders there.]]
local translated=WoWForeverIT_TranslateField(98389,'text',beta98389)
assert(translated and translated:find('Nemmeno la morte',1,true))
assert(not WoWForeverIT_TranslateField(98389,'text',beta98389..' A changed beta ending.'))
print('PASS: quest 98389 screenshot variant translates; changed content stays guarded')
WoWForeverIT_SetOption('interface',false)
assert(levelLabel:GetText()=='Level 2 |cff3fc7ebMage|r')
assert(not WoWForeverIT_GetOption('interface'))
WoWForeverIT_SetOption('quests',false)
assert(WoWForeverIT_GetOption('enabled') and not WoWForeverIT_GetOption('quests'))
WoWForeverIT_SetOption('interface',true)
assert(levelLabel:GetText()=='Livello 2 |cff3fc7ebMago|r')
assert(not WoWForeverIT_GetOption('quests'))
WoWForeverIT_SetOption('debug',true)
assert(WoWForeverIT_Settings.debug==true)
WoWForeverIT_SetOption('quests',true)
WoWForeverIT_SetOption('debug',false)
print('PASS: saved independent interface/quest preferences and debug setting')
