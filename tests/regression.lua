
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
CreateFrame=function() eventFrame=frame();return eventFrame end
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
