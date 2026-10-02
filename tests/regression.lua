
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
C_Timer={After=function(_,fn) fn() end,NewTicker=function(_,fn) pulse=fn end}
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
QuestObjectiveTracker={usedBlocks={[369]={id=369,HeaderText=header}}}

for line in io.lines("WoWForeverIT/WoWForeverIT.toc") do
 if line:match("%.lua$") then
  local chunk = assert(loadfile("WoWForeverIT/" .. line))
  chunk("WoWForeverIT")
 end
end

assert(WoWForeverIT_TranslateField(369,'title','A New Plague')=='Una nuova piaga')
assert(WoWForeverIT_TranslateField(369,'title','A Changed Quest')==nil)
assert(WoWForeverIT_TranslateField(369,'text',GetQuestText())==nil)
local count=0;for _ in pairs(WoWForeverIT_QuestIT.DataIT) do count=count+1 end;assert(count==2458)
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
