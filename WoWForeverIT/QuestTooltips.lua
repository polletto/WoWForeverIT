-- Only tooltips populated by quest log rows and quest map pins are translated.
local enabled = true
local hooks = setmetatable({}, {__mode='k'})
local globals = {}
local lastError
local activeOwner, activeID
local originals = setmetatable({}, {__mode='k'})
local labels = {
    ['<Click to view Quest Details>'] = '<Clicca per vedere i dettagli della missione>',
    ['Click to view quest details'] = 'Clicca per vedere i dettagli della missione',
    ['Click to view quest details.'] = 'Clicca per vedere i dettagli della missione.',
    ['Press F6 to submit an issue for this Quest'] = 'Premi F6 per segnalare un problema con questa missione',
    ['Ready for turn-in'] = 'Pronta per la consegna',
    ['Quest Complete'] = 'Missione completata',
    ['Quest Failed'] = 'Missione fallita',
}
local function visible(text)
    return text:gsub('|c%x%x%x%x%x%x%x%x',''):gsub('|r',''):gsub('\194\160',' ')
end
local function mapOwner(owner)
    local current=owner
    for _=1,12 do
        if not current then return false end
        if current==WorldMapFrame or current==QuestMapFrame or current==QuestScrollFrame then return true end
        if type(current.GetParent)~='function' then return false end
        current=current:GetParent()
    end
    return false
end
local function captureMapTooltip()
    if not GameTooltip or type(GameTooltip.GetOwner)~='function' then return end
    local owner=GameTooltip:GetOwner()
    if not mapOwner(owner) then return end
    local name=GameTooltip:GetName() or 'GameTooltip'
    local line=_G[name..'TextLeft1']
    local text=line and line:GetText()
    if type(text)~='string' then return end
    text=visible(text):match('^%s*(.-)%s*$')
    local title=text:match('^%[%d+%]%s*(.+)$') or text
    local matched
    for id,t in pairs(WoWForeverIT_VisibleQuestTranslations()) do
        local source=t.sourceTitle or (C_QuestLog and C_QuestLog.GetTitleForQuestID and C_QuestLog.GetTitleForQuestID(id))
        if title==source then
            if matched and matched~=id then return end -- Do not guess narrative fields for repeated titles.
            matched=id
        end
    end
    if matched then activeOwner,activeID=owner,matched end
end
local function translate()
    if not enabled or not GameTooltip then return end
    if WoWForeverIT_GetOption and (not WoWForeverIT_GetOption('quests') or not WoWForeverIT_GetOption('questTooltips')) then return end
    captureMapTooltip()
    if not activeID then return end
    if type(GameTooltip.GetOwner) ~= 'function' or GameTooltip:GetOwner() ~= activeOwner then return end
    if type(GameTooltip.NumLines) ~= 'function' then return end
    local own = WoWForeverIT_Quests and WoWForeverIT_Quests[activeID]
    local name = GameTooltip:GetName() or 'GameTooltip'
    for i=1,GameTooltip:NumLines() do
        local line = _G[name..'TextLeft'..i]
        if line and type(line.GetText)=='function' then
            local raw=line:GetText()
            if type(raw)=='string' then
                -- Tooltip titles and beta instructions may contain inline colors.
                -- Match visible text, then replace only its literal span in the raw
                -- string so level prefixes and existing colors stay intact.
                local english=visible(raw)
                local prefix, title=english:match('^(%[%d+%]%s*)(.+)$')
                local italian = own and own.title and (english==own.sourceTitle and own.title or
                    (title==own.sourceTitle and prefix..own.title))
                italian = italian or WoWForeverIT_TranslateField(activeID,'title',english)
                if not italian and title then
                    local translated=WoWForeverIT_TranslateField(activeID,'title',title)
                    if translated then italian=prefix..translated end
                end
                italian=italian or labels[english] or WoWForeverIT_TranslateObjectiveLine(english)
                if not italian then
                    for _,field in ipairs({'objectives','text','progress','reward'}) do
                        italian=WoWForeverIT_TranslateField(activeID,field,english)
                        if italian then break end
                    end
                end
                if italian and italian~=english then
                    local source, replacement=english,italian
                    if title and prefix and italian:sub(1,#prefix)==prefix then
                        source,replacement=title,italian:sub(#prefix+1)
                    end
                    local first,last=raw:find(source,1,true)
                    local rendered
                    if first then rendered=raw:sub(1,first-1)..replacement..raw:sub(last+1)
                    else
                        -- Color spans may split words (for example the F6 key).
                        local color=raw:match('^(|c%x%x%x%x%x%x%x%x)') or ''
                        rendered=color..italian..(color~='' and '|r' or '')
                    end
                    originals[line]={english=raw,italian=rendered,owner=activeOwner}
                    line:SetText(rendered)
                end
            end
        end
    end
end
local function hover(owner)
    activeOwner,activeID=nil,nil
    if not owner then return end
    local id=owner.questID or (owner.info and owner.info.questID)
    if not id and type(owner.GetQuestID)=='function' then id=owner:GetQuestID() end
    if type(id)~='number' or id<=0 then return end
    activeOwner,activeID=owner,id
    translate()
end
local function hook(target,method,callback)
    local key=target or globals
    local object=target or _G
    if type(object[method])~='function' then return end
    hooks[key]=hooks[key] or {}
    if hooks[key][method] then return end
    local fn=function(...)
        local ok,err=pcall(callback,...)
        if not ok then lastError=tostring(err) end
    end
    local ok
    if target then ok=pcall(hooksecurefunc,target,method,fn)
    else ok=pcall(hooksecurefunc,method,fn) end
    if ok then hooks[key][method]=true end
end
local function install()
    if type(hooksecurefunc)~='function' then return end
    hook(nil,'QuestMapLogTitleButton_OnEnter',hover)
    hook(nil,'QuestLogTitleButton_OnEnter',hover)
    if QuestPinMixin then hook(QuestPinMixin,'OnMouseEnter',hover) end
    if GameTooltip then
        -- Later quest tooltip updates (including beta issue instructions) stay Italian.
        hook(GameTooltip,'Show',translate)
        hook(GameTooltip,'AddLine',translate)
    end
end
function WoWForeverIT_SetTooltipLanguage(value)
    enabled=value
    if enabled then pcall(translate)
    elseif GameTooltip and GameTooltip.GetOwner then
        local owner=GameTooltip:GetOwner()
        for line,entry in pairs(originals) do
            if entry.owner==owner and line:GetText()==entry.italian then line:SetText(entry.english) end
        end
    end
end
local frame=CreateFrame('Frame')
frame:RegisterEvent('ADDON_LOADED')
frame:SetScript('OnEvent',install)
install()

-- Explicit, delayed snapshot: lets the player open a map-pin tooltip after typing.
SLASH_WOWFOREVERITTOOLTIP1='/wfittooltip'
SlashCmdList.WOWFOREVERITTOOLTIP=function()
    print('WoWForeverIT: passa sul tooltip della missione entro 5 secondi e rimani lì.')
    C_Timer.After(5,function()
        print('WoWForeverIT tooltip: ID='..tostring(activeID)..' errore='..tostring(lastError))
        for _,name in ipairs({'GameTooltip','WorldMapTooltip','QuestMapTooltip'}) do
            local tip=_G[name]
            if tip then
                local ok,err=pcall(function()
                    local owner=tip.GetOwner and tip:GetOwner()
                    print(name..' visibile='..tostring(tip.IsShown and tip:IsShown())..' owner='..tostring(owner and owner.GetName and owner:GetName()))
                    local current=owner
                    for i=1,6 do
                        if not current then break end
                        print(' parent '..i..': '..tostring(current.GetName and current:GetName())..' questID='..tostring(current.questID))
                        current=current.GetParent and current:GetParent()
                    end
                    for i=1,math.min(tip.NumLines and tip:NumLines() or 0,6) do
                        local line=_G[name..'TextLeft'..i]
                        print(' riga '..i..': '..tostring(line and line:GetText()))
                    end
                end)
                if not ok then print(name..': '..tostring(err)) end
            end
        end
    end)
end
