-- Static Group Finder controls only. Never traverse result/applicant rows,
-- active-listing descriptions or edit boxes containing player-authored text.
local words={
 ['Quests & Zones']='Missioni e zone',['List Self']='Pubblica',
 ['List Party']='Pubblica gruppo',['Unlist']='Rimuovi annuncio',['Update']='Aggiorna',
 ['Role Check']='Verifica ruoli',['Send Message']='Invia messaggio',
 ['Ignore Suggested Levels']='Ignora i livelli consigliati',
 ['Looking For Group']='Cerca gruppo',['Looking for Group']='Cerca gruppo',
 ['Group Finder']='Cerca gruppo',['Dungeon Finder']='Ricerca spedizioni',
 ['Premade Groups']='Gruppi organizzati',['Find a Group']='Trova un gruppo',
 ['Find Group']='Trova gruppo',['Browse Groups']='Sfoglia i gruppi',
 ['Start a Group']='Crea un gruppo',['Create Group']='Crea gruppo',
 ['List Group']='Pubblica gruppo',['List Yourself']='Pubblica disponibilità',
 ['Create Listing']='Crea annuncio',['Edit Listing']='Modifica annuncio',
 ['Update Listing']='Aggiorna annuncio',['Remove Listing']='Rimuovi annuncio',
 ['Delist']='Rimuovi annuncio',['Search']='Cerca',['Refresh']='Aggiorna',
 ['Sign Up']='Candidati',['Cancel Sign Up']='Annulla candidatura',
 ['Cancel Application']='Annulla candidatura',['Apply']='Candidati',
 ['Join Group']='Unisciti al gruppo',['Leave Group']='Lascia gruppo',
 ['Invite']='Invita',['Invite to Group']='Invita nel gruppo',
 ['Accept']='Accetta',['Decline']='Rifiuta',['Cancel']='Annulla',
 ['Back']='Indietro',['Done']='Fine',['Close']='Chiudi',
 ['Filter']='Filtro',['Filters']='Filtri',['Reset Filters']='Azzera filtri',
 ['Select Activity']='Seleziona attività',['Activity']='Attività',
 ['Category']='Categoria',['Categories']='Categorie',['Dungeons']='Spedizioni',
 ['Quests']='Missioni',['Raids']='Incursioni',['Other']='Altro',
 ['Custom']='Personalizzato',['Recommended']='Consigliato',
 ['Tank']='Difensore',['Healer']='Guaritore',['Damage']='Assaltatore',
 ['Damage Dealer']='Assaltatore',['Choose your Role']='Scegli il tuo ruolo',
 ['Select Role']='Seleziona ruolo',['Your Role']='Il tuo ruolo',
 ['Available Roles:']='Ruoli disponibili:',['Any Level']='Qualsiasi livello',
 ['Minimum Level']='Livello minimo',['Maximum Level']='Livello massimo',
 ['Min. Item Level']='Livello oggetto minimo',['Language']='Lingua',
 ['Playstyle']='Stile di gioco',['Casual']='Informale',
 ['Competitive']='Competitivo',['New Players Welcome']='Nuovi giocatori benvenuti',
 ['Auto Accept']='Accettazione automatica',['Group Name']='Nome del gruppo',
 ['Title']='Titolo',['Description']='Descrizione',['Comment']='Commento',
 ['Applicants']='Candidati',['No applicants']='Nessun candidato',
 ['No Results Found']='Nessun risultato trovato',['No groups found.']='Nessun gruppo trovato.',
 ['Search failed. Please try again later.']='Ricerca non riuscita. Riprova più tardi.',
 ['Only the group leader can create a listing for your group.']='Solo il capogruppo può pubblicare un annuncio per il gruppo.',
 ["Only the group leader can modify your group's listing."]='Solo il capogruppo può modificare l’annuncio del gruppo.',
 ['You must enter a title for your group.']='Devi inserire un titolo per il gruppo.',
 ['Make a selection.']='Effettua una scelta.',
}
local roots={'PVEFrame','LFGListFrame','LFGParentFrame','LFDParentFrame','LookingForGroupFrame','LFGListingFrame','LFGBrowseFrame'}
local panels={'CategorySelection','SearchPanel','EntryCreation','ApplicationViewer','RoleSelection'}
local controls={'TitleText','TitleLabel','Header','Label','NameLabel','DescriptionLabel','CommentLabel',
 'PostButton','SendMessageButton','GroupInviteButton','NoResultsFound','VoiceChatLabel','RolePollButton',
 'CategoryDropdown','ActivityDropdown','PlayStyleDropdown','VoiceChatDropdown',
 'FindGroupButton','StartGroupButton','ListGroupButton','CreateGroupButton','SearchButton','RefreshButton',
 'SignUpButton','BackButton','CancelButton','DoneButton','CloseButton','InviteButton','DeclineButton',
 'EditButton','RemoveEntryButton','DelistButton','SubmitButton','FilterButton','FiltersButton','ResetButton',
 'CategoryLabel','ActivityLabel','PlaystyleLabel','RoleLabel','MinLevelLabel','MaxLevelLabel',
 'TankButton','HealerButton','DamagerButton','AutoAcceptButton','ErrorText','NoResultsText'}
local saved=setmetatable({}, {__mode='k'})
local hooks=setmetatable({}, {__mode='k'})
local busy=false
local categoryHookInstalled=false
local function safe(object)
 if not object then return false end
 for _,method in ipairs({'IsForbidden','IsProtected'}) do
  if type(object[method])=='function' then local ok,v=pcall(object[method],object);if not ok or v then return false end end
 end
 return not (type(object.IsObjectType)=='function' and object:IsObjectType('EditBox'))
end
local function enabled() return WoWForeverIT_GetOption('enabled') and WoWForeverIT_GetOption('interface') end
local function translate(region)
 if busy or not safe(region) or type(region.GetText)~='function' or type(region.SetText)~='function' then return end
 local text=region:GetText()
 if type(text)~='string' or (type(issecretvalue)=='function' and issecretvalue(text)) then return end
 local previous=saved[region]
 local original=previous and text==previous.it and previous.en or text
 local plain=original:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r','')
 local it=words[plain]
 if not it then saved[region]=nil;return end
 local color=original:match('^(|c%x%x%x%x%x%x%x%x)');if color then it=color..it..'|r' end
 saved[region]={en=original,it=it}
 if not hooks[region] and type(hooksecurefunc)=='function' then
  hooks[region]=true;hooksecurefunc(region,'SetText',function() translate(region) end)
 end
 local target=enabled() and it or original
 if text~=target then busy=true;region:SetText(target);busy=false end
end
local function control(widget)
 if not safe(widget) then return end
 translate(widget)
 if type(widget.GetRegions)=='function' then
  for _,region in ipairs({widget:GetRegions()}) do translate(region) end
 end
 if widget.Text then translate(widget.Text) end
end
local function panel(widget)
 if not safe(widget) then return end
 for _,key in ipairs(controls) do control(widget[key]) end
 if not hooks[widget] and type(widget.HookScript)=='function' then
  hooks[widget]=true;widget:HookScript('OnShow',function() WoWForeverIT_RefreshGroupFinder() end)
 end
end
function WoWForeverIT_RefreshGroupFinder()
 for region in pairs(saved) do translate(region) end
 for _,name in ipairs(roots) do
  local widget=_G[name]
  if safe(widget) then
   panel(widget)
   if widget.TitleContainer then control(widget.TitleContainer.TitleText) end
   for _,key in ipairs(panels) do panel(widget[key]) end
   -- Forever's VanillaStyle panel uses separate listing/browsing frames.
   -- CategoryButtons contain Blizzard categories, never player listings.
   if widget.CategoryView then
    panel(widget.CategoryView)
    for _,button in ipairs(widget.CategoryView.CategoryButtons or {}) do control(button) end
   end
   if widget.ActivityView then
    panel(widget.ActivityView)
    if widget.ActivityView.LevelRangesCheckbox then control(widget.ActivityView.LevelRangesCheckbox.Text) end
   end
   if widget.GroupRoleButtons then panel(widget.GroupRoleButtons) end
   if widget.SearchingSpinner then control(widget.SearchingSpinner.Label) end

  end
 end
 for i=1,3 do control(_G['PVEFrameTab'..i]);control(_G['LFGParentFrameTab'..i]) end
 if not categoryHookInstalled and type(LFGListingCategorySelection_UpdateCategoryButtons)=='function' and type(hooksecurefunc)=='function' then
  categoryHookInstalled=true
  hooksecurefunc('LFGListingCategorySelection_UpdateCategoryButtons',function(view)
   if not safe(view) then return end
   for _,button in ipairs(view.CategoryButtons or {}) do control(button) end
  end)
 end
end
local events=CreateFrame('Frame')
for _,event in ipairs({'ADDON_LOADED','PLAYER_ENTERING_WORLD','PLAYER_REGEN_ENABLED','LFG_LIST_SEARCH_RESULTS_RECEIVED','LFG_LIST_ACTIVE_ENTRY_UPDATE','LFG_LIST_APPLICATION_STATUS_UPDATED'}) do events:RegisterEvent(event) end
events:SetScript('OnEvent',function() WoWForeverIT_RefreshGroupFinder() end)
WoWForeverIT_RefreshGroupFinder()
