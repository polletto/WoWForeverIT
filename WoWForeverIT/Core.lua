local addonName = ...
local prefix = "|cff44ccff[WoWForeverIT]|r "
local debugEnabled = false
local italianEnabled = true
local currentID
local currentPhase
local hooksInstalled = false
local trackerHookInstalled = false
local legacyTrackerHookInstalled = false
local pulseInstalled = false
local redrawHooks = setmetatable({}, {__mode = "k"})
local showHooks = setmetatable({}, {__mode = "k"})
local globalHookTarget = {}
local deferredRefreshPending = false
local replaceTrackerText
local restoreEnglish
local originalLabels = setmetatable({}, { __mode = "k" })

local function readText(api)
    if type(api) ~= "function" then return nil end
    local ok, value = pcall(api)
    if ok and type(value) == "string" and value ~= "" then return value end
end

local function report(label, value)
    print(prefix .. label .. ": " .. tostring(value or "(non disponibile)"))
end

local function inQuestLog()
    return QuestInfoFrame and QuestInfoFrame.questLog and not (QuestFrame and QuestFrame:IsShown())
end

local function activeTranslation()
    if not italianEnabled then return nil end
    local id
    if inQuestLog() then
        if not C_QuestLog or type(C_QuestLog.GetSelectedQuest) ~= "function" then return nil end
        id = C_QuestLog.GetSelectedQuest()
    else
        if not QuestFrame or not QuestFrame:IsShown() or type(GetQuestID) ~= "function" then return nil end
        id = GetQuestID()
    end
    if type(id) ~= "number" or id <= 0 then return nil end
    return WoWForeverIT_ResolveQuest(id, inQuestLog())
end

local function setField(fontString, value)
    if fontString and type(fontString.SetText) == "function" and value then
        fontString:SetText(value)
        return true
    end
    return false
end

local function label(field, italian)
    if not field or type(field.GetText) ~= "function" or type(field.SetText) ~= "function" then return end
    local current = field:GetText()
    if type(current) == "string" and current ~= "" and current ~= italian
        and (originalLabels[field] == nil or current ~= originalLabels[field]) then
        originalLabels[field] = current
    end
    if italian and originalLabels[field] then field:SetText(italian) end
end

local function visitUI(root, callback)
    if not root then return end
    local allowed, forbidden = pcall(function() return root:IsForbidden() end)
    if allowed and forbidden then return end
    pcall(callback, root)
    if type(root.GetRegions) == "function" then
        local ok, regions = pcall(function() return {root:GetRegions()} end)
        if ok then
            for _, region in ipairs(regions) do pcall(callback, region) end
        end
    end
    if type(root.GetChildren) == "function" then
        local ok, children = pcall(function() return {root:GetChildren()} end)
        if ok then
            for _, child in ipairs(children) do visitUI(child, callback) end
        end
    end
end

local function restoreLabels()
    for field, original in pairs(originalLabels) do
        if field and type(field.SetText) == "function" then field:SetText(original) end
    end
end

local function replaceLabels()
    if not italianEnabled then return end
    local rewards = QuestInfoFrame and QuestInfoFrame.rewardsFrame
    label(QuestInfoDescriptionHeader, "Descrizione")
    label(QuestInfoObjectivesHeader, "Obiettivi")
    label(QuestInfoRewardsHeader, "Ricompense")
    label(QuestInfoRewardsFrame and QuestInfoRewardsFrame.Header, "Ricompense")
    label(MapQuestInfoRewardsFrame and MapQuestInfoRewardsFrame.Header, "Ricompense")
    if rewards then
        label(rewards.Header, "Ricompense")
        local choose = rewards.ItemChooseText
        if choose and choose:IsShown() then label(choose, "Scegli una ricompensa:") end
        local receive = rewards.ItemReceiveText
        if receive and receive:IsShown() then
            local english = originalLabels[receive] or receive:GetText() or ""
            label(receive, english:find("also", 1, true) and "Riceverai anche:" or "Riceverai:")
        end
    end
    if not inQuestLog() then
        label(QuestFrameAcceptButton, "Accetta")
        label(QuestFrameDeclineButton, "Rifiuta")
        label(QuestFrameCompleteQuestButton, "Completa missione")
        if currentPhase == "QUEST_PROGRESS" then
            label(QuestProgressRequiredItemsText, "Oggetti richiesti:")
            label(QuestFrameCompleteButton, "Continua")
            label(QuestFrameCancelButton, "Annulla")
        end
    end
end

local mapButtonTranslations = {
    Back = "Indietro",
    Abandon = "Abbandona",
    Share = "Condividi",
    Track = "Segui",
    Untrack = "Non seguire",
    ["Map & Quest Log"] = "Mappa e registro missioni",
    ["Search Quest Log"] = "Cerca nel registro missioni",
    ["All Objectives"] = "Tutti gli obiettivi",
    Quests = "Missioni",
    World = "Mondo",
    ["Zephras Isle"] = "Isola di Zephras",
    ["Eastern Kingdoms"] = "Regni Orientali",
    ["Tirisfal Glades"] = "Radure di Tirisfal",
    Description = "Descrizione",
    Objectives = "Obiettivi",
    Rewards = "Ricompense",
}

local function replaceMapButtons()
    if not italianEnabled or not WorldMapFrame or not WorldMapFrame:IsShown() then return end
    local titles = {}
    local objectives = {}
    for id, t in pairs(WoWForeverIT_VisibleQuestTranslations()) do
        if C_QuestLog and C_QuestLog.GetTitleForQuestID then
            local english = t.sourceTitle or C_QuestLog.GetTitleForQuestID(id)
            if english then titles[english] = t.title end
        elseif t.sourceTitle then
            titles[t.sourceTitle] = t.title
        end
        if t.sourceObjectives then objectives[t.sourceObjectives] = t.objectives end
    end
    visitUI(WorldMapFrame, function(region)
        if type(region.GetText) ~= "function" then return end
        local english = region:GetText()
        local italian = mapButtonTranslations[english]
        if region:IsObjectType("FontString") and english == "Rewards" then italian = "Ricompense" end
        if type(english) == "string" then
            -- The counter includes inline color codes in this beta.
            local plain = english:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
            if plain:match("^Quests:%s*%d+%s*/%s*%d+$") then
                italian = english:gsub("Quests:", "Missioni:", 1)
            end
            local prefix, title = english:match("^(%[%d+%]%s*)(.+)$")
            italian = titles[english] or (title and titles[title] and (prefix .. titles[title])) or italian
            local dash, objective = english:match("^(%s*%-%s*)(.+)$")
            italian = objectives[english] or (objective and objectives[objective] and (dash .. objectives[objective])) or italian
        end
        italian = italian or WoWForeverIT_TranslateObjectiveLine(english)
        if italian then label(region, italian) end
    end)
end

local menuTranslations = WoWForeverIT_UI or {}
local menuRoots = {"GameMenuFrame", "SettingsPanel", "InterfaceOptionsFrame", "VideoOptionsFrame",
    "AudioOptionsFrame", "KeyBindingFrame", "AddonList", "MacroFrame", "MacroPopupFrame",
    "HelpFrame", "SupportFrame", "EditModeManagerFrame"}
local menuHooks = setmetatable({}, {__mode = "k"})
local function replaceGameMenu()
    if not italianEnabled then return end
    for _, name in ipairs(menuRoots) do
        local root = _G[name]
        if root and type(root.IsShown) == "function" and root:IsShown() then
            visitUI(root, function(region)
                if type(region.GetText) ~= "function" or type(region.IsObjectType) ~= "function" then return end
                -- Never translate typed text, macro names/bodies, or search values.
                if region:IsObjectType("EditBox") then return end
                if not region:IsObjectType("FontString") and not region:IsObjectType("Button") then return end
                if name == "MacroFrame" then
                    local widget = region
                    for _ = 1, 4 do
                        if not widget then break end
                        local widgetName = type(widget.GetName) == "function" and widget:GetName() or ""
                        if widgetName and widgetName:match("^MacroButton%d") then return end
                        widget = type(widget.GetParent) == "function" and widget:GetParent() or nil
                    end
                end
                local english = region:GetText()
                local italian = menuTranslations[english]
                if not italian and type(english) == "string" then
                    local number = english:match("^Action Bar (%d+)$")
                    if number then italian = "Barra azioni " .. number end
                    number = english:match("^Action Button (%d+)$")
                    if number then italian = "Pulsante azione " .. number end
                end
                if italian then label(region, italian) end
            end)
        end
    end
end
local function installMenuHook()
    for _, name in ipairs(menuRoots) do
        local root = _G[name]
        if root and not menuHooks[root] and type(root.HookScript) == "function" then
            root:HookScript("OnShow", function()
                pcall(replaceGameMenu)
                if C_Timer and C_Timer.After then C_Timer.After(0, function() pcall(replaceGameMenu) end) end
            end)
            menuHooks[root] = true
        end
    end
end

local function replaceNpcButtons()
    if not italianEnabled then return end
    if inQuestLog() or not QuestFrame or not QuestFrame:IsShown() then return end
    local names = {Continue = "Continua", Cancel = "Annulla", Accept = "Accetta", Decline = "Rifiuta"}
    visitUI(QuestFrame, function(region)
        if region:IsObjectType("Button") and type(region.GetText) == "function" then
            local italian = names[region:GetText()]
            if italian then label(region, italian) end
        end
    end)
end

replaceTrackerText = function()
    if not italianEnabled then return end
    local titles = {}
    local objectives = {}
    local trackerHeaders = {
        ["All Objectives"] = "Tutti gli obiettivi",
        Quests = "Missioni",
        ["Ready for turn-in"] = "Pronta per la consegna",
        ["Speak with Aamelia Windfield about the Malfunctioning Cyclone Construct."] = "Parla con Aamelia Windfield del Costrutto Ciclone Malfunzionante.",
    }
    local trackerTerms = {
        ["Doom Weed"] = "Erba Funesta",
        ["Duskbat Pelt"] = "Pelle di Pipistrello del Crepuscolo",
        ["Coarse Thread"] = "Filo Grezzo",
        ["Putrid Claw"] = "Artiglio Putrido",
        ["Notched Rib"] = "Costola Intagliata",
        ["Blackened Skull"] = "Teschio Annerito",
        ["Embalming Ichor"] = "Icore da Imbalsamazione",
        ["Scarlet Warrior slain"] = "Guerrieri Scarlatti uccisi",
        ["Devlin's Remains"] = "Resti di Devlin",
        ["Gregor's Remains"] = "Resti di Gregor",
        ["Nissa's Remains"] = "Resti di Nissa",
        ["Thurman's Remains"] = "Resti di Thurman",
    }
    for id, t in pairs(WoWForeverIT_VisibleQuestTranslations()) do
        if C_QuestLog and C_QuestLog.GetTitleForQuestID then
            local english = t.sourceTitle or C_QuestLog.GetTitleForQuestID(id)
            if english then titles[english] = t.title end
        elseif t.sourceTitle then
            titles[t.sourceTitle] = t.title
        end
        if t.sourceObjectives then objectives[t.sourceObjectives] = t.objectives end
    end
    local function translate(region)
        if type(region.GetText) == "function" then
            local english = region:GetText()
            local prefix, title = type(english) == "string" and english:match("^(%[%d+%]%s*)(.+)$")
            local dash, objective = type(english) == "string" and english:match("^(%s*%-%s*)(.+)$")
            local italian = trackerHeaders[english] or titles[english] or objectives[english]
                or (title and titles[title] and (prefix .. titles[title]))
                or (objective and objectives[objective] and (dash .. objectives[objective]))
            if not italian and type(english) == "string" then
                local lead, term, count = english:match("^([%s%-]*)(.-)(:%s*%d+/%d+.*)$")
                if term and trackerTerms[term] then
                    italian = lead .. trackerTerms[term] .. count
                end
                if not italian then
                    local before, amount, item = english:match("^(%s*%-?%s*)(%d+/%d+%s+)(.+)$")
                    if item and trackerTerms[item] then
                        italian = before .. amount .. trackerTerms[item]
                    end
                end
            end
            italian = italian or WoWForeverIT_TranslateObjectiveLine(english)
            if italian then label(region, italian) end
        end
    end
    for _, name in ipairs({"ObjectiveTrackerFrame", "QuestObjectiveTracker"}) do
        local tracker = _G[name]
        if tracker and tracker.Header and tracker.Header.Text then
            pcall(translate, tracker.Header.Text)
        end
    end
    -- The modern "All Objectives" panel stores its visible quests in a
    -- module. The old QUEST_TRACKER_MODULE is absent on some clients.
    for _, name in ipairs({"QuestObjectiveTracker", "QUEST_TRACKER_MODULE"}) do
        local module = _G[name]
        if module then
            for id, t in pairs(WoWForeverIT_VisibleQuestTranslations()) do
                local block
                if type(module.GetExistingBlock) == "function" then
                    local ok, result = pcall(module.GetExistingBlock, module, id)
                    if ok then block = result end
                end
                if not block and type(module.usedBlocks) == "table" then
                    block = module.usedBlocks[id]
                end
                if block and (block.id == nil or block.id == id) then
                    if block.HeaderText then pcall(label, block.HeaderText, t.title) end
                    if type(block.lines) == "table" then
                        for _, line in pairs(block.lines) do
                            if line and line.Text then pcall(translate, line.Text) end
                        end
                    end
                end
            end
        end
    end
    -- Forever/Classic can use the older QuestWatchFrame (or WatchFrame).
    -- Keep every search inside a tracker, never in the reused NPC dialog.
    local seen = {}
    for _, name in ipairs({"ObjectiveTrackerFrame", "QuestWatchFrame", "WatchFrame", "ObjectiveTrackerBlocksFrame", "QuestObjectiveTracker"}) do
        local root = _G[name]
        if root and not seen[root] then
            seen[root] = true
            visitUI(root, translate)
        end
    end
    if QuestWatchFrame then
        for i = 1, (MAX_QUESTWATCH_LINES or 30) do
            local line = _G["QuestWatchLine" .. i]
            if line then pcall(translate, line) end
        end
    end
end

local function trackerTitle(self, quest)
    if not quest or type(quest.GetID) ~= "function" then return end
    local id = quest:GetID()
    local translated = italianEnabled and WoWForeverIT_VisibleQuestTranslations()[id]
    if not translated then return end
    local block = self.GetExistingBlock and self:GetExistingBlock(id)
    if block and block.HeaderText then pcall(label, block.HeaderText, translated.title) end
    pcall(replaceTrackerText)
end

local function replaceTitle()
    local t = activeTranslation()
    if t then
        setField(QuestInfoTitleHeader, t.title or (inQuestLog() and C_QuestLog.GetTitleForQuestID(C_QuestLog.GetSelectedQuest()) or readText(GetTitleText)))
    elseif inQuestLog() then
        local id = C_QuestLog and C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest()
        if id and C_QuestLog.GetTitleForQuestID then
            setField(QuestInfoTitleHeader, C_QuestLog.GetTitleForQuestID(id))
        end
    elseif QuestFrame and QuestFrame:IsShown() then
        setField(QuestInfoTitleHeader, readText(GetTitleText))
    end
end

local function replaceDescription()
    local t = activeTranslation()
    if t then setField(QuestInfoDescriptionText, t.description) end
end

local function replaceCompletion()
    local t = activeTranslation()
    if t and currentPhase == "QUEST_COMPLETE" then
        setField(QuestInfoRewardText, t.completion)
    end
end

local function replaceProgress()
    local t = activeTranslation()
    if t and currentPhase == "QUEST_PROGRESS" then
        setField(QuestProgressTitleText, t.title)
        setField(QuestProgressText, t.progress)
    end
end

local function replaceObjectives()
    local t = activeTranslation()
    if t then setField(QuestInfoObjectivesText, t.objectives) end
end

local function replaceVisibleText()
    local t = activeTranslation()
    if not t then
        -- Blizzard reuses these FontStrings between quests; restore the live
        -- text even when the next quest has no entry in our database.
        restoreEnglish(true)
        replaceLabels()
        replaceMapButtons()
        replaceNpcButtons()
        replaceTrackerText()
        return
    end
    restoreEnglish(true)
    replaceTrackerText()
    replaceLabels()
    replaceMapButtons()
    replaceNpcButtons()
    if currentPhase == "QUEST_PROGRESS" and not inQuestLog() then
        replaceProgress()
    else
        replaceTitle()
    end
    replaceDescription()
    if inQuestLog() or currentPhase == "QUEST_DETAIL" then
        replaceObjectives()
    elseif currentPhase == "QUEST_COMPLETE" then
        replaceCompletion()
    elseif currentPhase == "QUEST_PROGRESS" then
        replaceProgress()
    end
end

local function installHooks()
    if hooksInstalled or type(hooksecurefunc) ~= "function" then return end
    if type(QuestInfo_ShowTitle) ~= "function" or type(QuestInfo_ShowDescriptionText) ~= "function"
        or type(QuestInfo_ShowObjectivesText) ~= "function" then return end
    hooksecurefunc("QuestInfo_ShowTitle", replaceTitle)
    hooksecurefunc("QuestInfo_ShowDescriptionText", replaceDescription)
    hooksecurefunc("QuestInfo_ShowObjectivesText", replaceObjectives)
    if type(QuestInfo_Display) == "function" then
        hooksecurefunc("QuestInfo_Display", replaceVisibleText)
    end
    if type(QuestInfo_ShowRewardText) == "function" then
        hooksecurefunc("QuestInfo_ShowRewardText", replaceCompletion)
    end
    if type(QuestFrameProgressPanel_OnShow) == "function" then
        hooksecurefunc("QuestFrameProgressPanel_OnShow", replaceVisibleText)
    end
    hooksInstalled = true
end

-- Secure post-hooks translate immediately after Blizzard redraws the widgets.
-- Register per target/method: mixins and live instances can appear after login.
local function hookRedraw(target, method, callback)
    if type(hooksecurefunc) ~= "function" then return false end
    local object = target or _G
    if type(object[method]) ~= "function" then return false end
    local key = target or globalHookTarget
    local methods = redrawHooks[key]
    if not methods then methods = {}; redrawHooks[key] = methods end
    if methods[method] then return true end
    local safeCallback = function(...) pcall(callback, ...) end
    local ok
    if target then ok = pcall(hooksecurefunc, target, method, safeCallback)
    else ok = pcall(hooksecurefunc, method, safeCallback) end
    if ok then methods[method] = true end
    return ok
end

local function installTrackerHook()
    for _, name in ipairs({"QuestObjectiveTrackerMixin", "QuestObjectiveTracker", "QUEST_TRACKER_MODULE"}) do
        local target = _G[name]
        if type(target) == "table" then
            if hookRedraw(target, "UpdateSingle", trackerTitle) then trackerHookInstalled = true end
            hookRedraw(target, "Update", replaceTrackerText)
        end
    end
    local tracker = ObjectiveTrackerFrame
    if tracker then hookRedraw(tracker, "Update", replaceTrackerText) end
    if hookRedraw(nil, "QuestWatch_Update", replaceTrackerText) then legacyTrackerHookInstalled = true end
    hookRedraw(nil, "ObjectiveTracker_Update", replaceTrackerText)
end

local function installMapHooks()
    for _, name in ipairs({"QuestMapFrame_UpdateAll", "QuestMapFrame_UpdateQuests",
        "QuestMapFrame_UpdateQuestDetails", "QuestMapFrame_ShowQuestDetails", "QuestLogQuests_Update", "QuestLog_Update"}) do
        hookRedraw(nil, name, replaceVisibleText)
    end
    for _, name in ipairs({"WorldMapFrame", "QuestMapFrame", "QuestScrollFrame"}) do
        local root = _G[name]
        if root then
            hookRedraw(root, "Update", replaceVisibleText)
            if not showHooks[root] and type(root.HookScript) == "function" then
                local ok = pcall(root.HookScript, root, "OnShow", function() pcall(replaceVisibleText) end)
                if ok then showHooks[root] = true end
            end
        end
    end
end

local function refresh()
    installHooks()
    installTrackerHook()
    installMapHooks()
    installMenuHook()
    -- Do not wait for the 1.5-second safety ticker on clicks or quest events.
    pcall(replaceVisibleText)
    -- One coalesced retry covers widgets populated later during the same event.
    if not deferredRefreshPending and C_Timer and type(C_Timer.After) == "function" then
        deferredRefreshPending = true
        C_Timer.After(0, function()
            deferredRefreshPending = false
            pcall(replaceVisibleText)
        end)
    end
end

local function installPulse()
    if pulseInstalled or not C_Timer or type(C_Timer.NewTicker) ~= "function" then return end
    C_Timer.NewTicker(1.5, function()
        if not italianEnabled then return end
        if WorldMapFrame and WorldMapFrame:IsShown() then
            pcall(replaceMapButtons)
        end
        pcall(replaceTrackerText)
        installMenuHook()
        pcall(replaceGameMenu)
    end)
    pulseInstalled = true
end

restoreEnglish = function(keepLabels)
    -- Only a language toggle restores saved UI labels. During redraws Blizzard
    -- may have replaced them with new counters or reused quest rows.
    if not keepLabels then restoreLabels() end
    if inQuestLog() then
        local id = C_QuestLog and C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest()
        if id and C_QuestLog.GetTitleForQuestID then
            setField(QuestInfoTitleHeader, C_QuestLog.GetTitleForQuestID(id))
        end
        if type(GetQuestLogQuestText) == "function" then
            local description, objectives = GetQuestLogQuestText()
            setField(QuestInfoDescriptionText, description)
            setField(QuestInfoObjectivesText, objectives)
        end
        return
    end
    if not QuestFrame or not QuestFrame:IsShown() then return end
    setField(QuestInfoTitleHeader, readText(GetTitleText))
    setField(QuestInfoDescriptionText, readText(GetQuestText))
    setField(QuestInfoObjectivesText, readText(GetObjectiveText))
    setField(QuestInfoRewardText, readText(GetRewardText))
    setField(QuestProgressTitleText, readText(GetTitleText))
    setField(QuestProgressText, readText(GetProgressText))
end

local frame = CreateFrame("Frame")
for _, event in ipairs({"ADDON_LOADED", "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE", "QUEST_FINISHED", "QUEST_LOG_UPDATE", "QUEST_WATCH_LIST_CHANGED"}) do
    frame:RegisterEvent(event)
end
frame:SetScript("OnEvent", function(_, event, arg)
    if event == "ADDON_LOADED" then
        if arg == addonName then
            print(prefix .. "caricato. /wfit toggle | /wfit debug | /wfit info")
            installHooks()
            installTrackerHook()
            refresh()
            installPulse()
        else
            refresh()
        end
        return
    end
    if event == "QUEST_LOG_UPDATE" or event == "QUEST_WATCH_LIST_CHANGED" then
        installTrackerHook()
        refresh()
        return
    end
    if event == "QUEST_FINISHED" then currentID = nil currentPhase = nil return end
    local id = type(GetQuestID) == "function" and GetQuestID() or nil
    if type(id) ~= "number" or id <= 0 then id = nil end
    currentID = id
    currentPhase = event
    if debugEnabled then
        report("Evento", event)
        report("Quest ID", id)
        report("Titolo", readText(GetTitleText))
        report("Descrizione", readText(GetQuestText))
        report("Obiettivi", readText(GetObjectiveText))
        if event == "QUEST_PROGRESS" then report("Progresso", readText(GetProgressText)) end
        if event == "QUEST_COMPLETE" then report("Completamento", readText(GetRewardText)) end
    end
    if event == "QUEST_DETAIL" or event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE" then
        if not (id and ((WoWForeverIT_Quests and WoWForeverIT_Quests[id]) or WoWForeverIT_QuestIT.DataIT[id])) then
            if debugEnabled then report("Traduzione assente per questID", id) end
        end
        refresh()
    end
end)

SLASH_WOWFOREVERIT1 = "/wfit"
SlashCmdList.WOWFOREVERIT = function(input)
    local cmd = (input or ""):lower():match("^%s*(%S*)")
    if cmd == "toggle" then
        italianEnabled = not italianEnabled
        if WoWForeverIT_SetTooltipLanguage then WoWForeverIT_SetTooltipLanguage(italianEnabled) end
        if italianEnabled then refresh() replaceGameMenu() else restoreEnglish() end
        if QuestObjectiveTracker and type(QuestObjectiveTracker.MarkDirty) == "function" then
            QuestObjectiveTracker:MarkDirty()
        end
        report("Testo nella finestra quest", italianEnabled and "italiano" or "inglese")
    elseif cmd == "tooltip" then
        if SlashCmdList.WOWFOREVERITTOOLTIP then
            SlashCmdList.WOWFOREVERITTOOLTIP()
        else
            report("Diagnostica tooltip", "modulo QuestTooltips.lua non caricato. Controlla la cartella e il file .toc, poi riavvia WoW.")
        end
    elseif cmd == "debug" then
        debugEnabled = not debugEnabled
        report("Debug", debugEnabled and "attivo" or "disattivo")
    elseif cmd == "info" then
        report("Quest ID corrente", inQuestLog() and C_QuestLog and C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest() or currentID)
        report("Hook UI", hooksInstalled and "installati" or "non disponibili")
        report("Hook tracciatore", trackerHookInstalled and "installato" or "non disponibile")
        report("Build", (GetBuildInfo and select(1, GetBuildInfo())) or "sconosciuta")
        report("Locale", (GetLocale and GetLocale()) or "sconosciuta")
    else
        print(prefix .. "/wfit toggle | /wfit debug | /wfit info")
    end
end
