-- Run from repository root. No game client required.
local function field(text,kind)
 local f={text=text,kind=kind or 'FontString'}
 function f:GetText() return self.text end
 function f:SetText(v) self.text=v end
 function f:IsObjectType(k) return self.kind==k end
 return f
end
local function frame()
 local f={}
 function f:RegisterEvent() end
 function f:SetScript(k,v) self[k]=v end
 function f:HookScript(k,v) self[k]=v end
 return f
end
local events
CreateFrame=function() events=frame();return events end
local settings={enabled=true,interface=true}
WoWForeverIT_GetOption=function(key) return settings[key] end
hooksecurefunc=function(o,k,cb) local old=o[k];o[k]=function(...) old(...);cb(...) end end
LFGListFrame=frame()
LFGListFrame.SearchPanel=frame()
local panel=LFGListFrame.SearchPanel
panel.SearchButton=field('Search','Button')
panel.SignUpButton=field('|cffffffffSign Up|r','Button')
panel.SearchBox=field('Search','EditBox')
panel.Results={field('Search'),field('PlayerName'),field('My custom description')}
LFGListFrame.EntryCreation=frame()
LFGListFrame.EntryCreation.Name=field('Create Group','EditBox')
LFGListFrame.EntryCreation.Description=field('My listing','EditBox')
LFGListFrame.ApplicationViewer=frame()
LFGListFrame.ApplicationViewer.ListingTitle=field('Search')
local protected=field('Invite','Button');protected.IsProtected=function() return true end
panel.InviteButton=protected
PVEFrame=frame();PVEFrame.TitleText=field('Group Finder')
-- Actual Forever VanillaStyle hierarchy, including screenshot labels.
LFGListingFrame=frame()
LFGListingFrame.TitleContainer={TitleText=field('Looking For Group')}
LFGListingFrame.PostButton=field('List Self','Button')
LFGListingFrame.BackButton=field('Back','Button')
LFGListingFrame.CategoryView=frame()
LFGListingFrame.CategoryView.CategoryButtons={field('Quests & Zones','Button'),field('Custom','Button')}
LFGListingFrame.ActivityView=frame()
LFGListingFrame.ActivityView.Comment={EditBox=field('Custom','EditBox')}
LFGBrowseFrame=frame()
LFGBrowseFrame.ScrollBox={playerComment=field('Custom')}
dofile('WoWForeverIT/GroupFinder.lua')
assert(LFGListingFrame.TitleContainer.TitleText.text=='Cerca gruppo')
assert(LFGListingFrame.CategoryView.CategoryButtons[1].text=='Missioni e zone')
assert(LFGListingFrame.CategoryView.CategoryButtons[2].text=='Personalizzato')
assert(LFGListingFrame.PostButton.text=='Pubblica')
assert(LFGListingFrame.BackButton.text=='Indietro')
assert(LFGListingFrame.ActivityView.Comment.EditBox.text=='Custom')
assert(LFGBrowseFrame.ScrollBox.playerComment.text=='Custom')
LFGListingFrame.CategoryView.CategoryButtons[1]:SetText('Quests & Zones')
assert(LFGListingFrame.CategoryView.CategoryButtons[1].text=='Missioni e zone')

assert(PVEFrame.TitleText.text=='Cerca gruppo')
assert(panel.SearchButton.text=='Cerca')
assert(panel.SignUpButton.text=='|cffffffffCandidati|r')
assert(panel.SearchBox.text=='Search' and panel.Results[1].text=='Search')
assert(LFGListFrame.ApplicationViewer.ListingTitle.text=='Search')
assert(LFGListFrame.EntryCreation.Name.text=='Create Group')
assert(protected.text=='Invite')
panel.SearchButton:SetText('Refresh');assert(panel.SearchButton.text=='Aggiorna')
panel.SearchButton:SetText('Unknown beta label');assert(panel.SearchButton.text=='Unknown beta label')
panel.SearchButton:SetText('Search');assert(panel.SearchButton.text=='Cerca')
settings.interface=false;WoWForeverIT_RefreshGroupFinder()
assert(panel.SearchButton.text=='Search' and panel.SignUpButton.text=='|cffffffffSign Up|r')
assert(LFGListingFrame.CategoryView.CategoryButtons[1].text=='Quests & Zones')
assert(LFGListingFrame.PostButton.text=='List Self')
settings.interface=true;WoWForeverIT_RefreshGroupFinder()
assert(panel.SearchButton.text=='Cerca')
-- Lazy creation of the listing panel and its controls.
LFGListFrame.EntryCreation.ListGroupButton=field('List Group','Button')
events.OnEvent()
assert(LFGListFrame.EntryCreation.ListGroupButton.text=='Pubblica gruppo')
settings.enabled=false;WoWForeverIT_RefreshGroupFinder()
assert(LFGListFrame.EntryCreation.ListGroupButton.text=='List Group')
print('PASS: Group Finder static labels, redraws, lazy controls, colors, toggles, protected controls and player-content exclusions')

-- The screenshot tooltips are owned by descendants of the VanillaStyle frames.
settings.enabled=true;settings.interface=true
local tooltipOwner={GetParent=function() return LFGListingFrame end}
GameTooltip=frame()
GameTooltip.GetOwner=function() return tooltipOwner end
GameTooltip.GetName=function() return 'LFGTooltipTest' end
GameTooltip.NumLines=function() return 2 end
GameTooltip.Show=function() end
LFGTooltipTestTextLeft1=field('Who List')
LFGTooltipTestTextLeft2=field('Unknown player name')
dofile('WoWForeverIT/MicroMenu.lua')
LFGTooltipTestTextLeft1:SetText("Who List");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Elenco giocatori")
LFGTooltipTestTextLeft1:SetText("Group Browser");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Ricerca gruppi")
LFGTooltipTestTextLeft1:SetText("Create Listing");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Crea annuncio")
LFGTooltipTestTextLeft1:SetText("Indicates that you are willing to protect allies from harm by ensuring that enemies are attacking you instead of them.");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Indica che sei disposto a proteggere gli alleati facendo in modo che i nemici attacchino te invece di loro.")
LFGTooltipTestTextLeft1:SetText("Indicates that you are willing to heal your allies when they take damage.");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Indica che sei disposto a curare gli alleati quando subiscono danni.")
LFGTooltipTestTextLeft1:SetText("This role is not recommended for your current character's class.");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Questo ruolo non è consigliato per la classe del tuo personaggio.")
LFGTooltipTestTextLeft1:SetText("Indicates that you are willing to take on the role of dealing damage to enemies.");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Indica che sei disposto a infliggere danni ai nemici.")
LFGTooltipTestTextLeft1:SetText("Indicates that you welcome new players into your group and are willing to act as a guide for them.");GameTooltip:Show();assert(LFGTooltipTestTextLeft1.text=="Indica che accogli nuovi giocatori nel gruppo e sei disposto a guidarli.")

local warning="This role is not recommended for your current character's class."
LFGTooltipTestTextLeft2:SetText('|cffff0000'..warning..'|r')
GameTooltip:Show()
assert(LFGTooltipTestTextLeft2.text=='|cffff0000Questo ruolo non è consigliato per la classe del tuo personaggio.|r')
settings.interface=false;WoWForeverIT_RefreshMicroMenu()
assert(LFGTooltipTestTextLeft2.text=='|cffff0000'..warning..'|r')
settings.interface=true;tooltipOwner={}
LFGTooltipTestTextLeft1:SetText('Who List');GameTooltip:Show()
assert(LFGTooltipTestTextLeft1.text=='Who List')
print('PASS: all eight screenshot tooltip texts, ancestor ownership, warning color, restore and unrelated-tooltip exclusion')
