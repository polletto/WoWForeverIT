-- Saves English quest texts that have no matching Italian translation, so a
-- missing field can be added later with its exact text and fingerprint.
-- WoW writes WoWForeverIT_Capture to WTF/Account/<account>/SavedVariables/
-- WoWForeverIT.lua on /reload or logout; tools/export_capture.lua reads it.
local Core = WoWForeverIT_QuestIT.Core
local LIMIT = 3000
-- Field names follow Data_it.lua; the local overrides use other names.
local ownField = {title = "title", text = "description", objectives = "objectives", progress = "progress", reward = "completion"}

local function store()
    WoWForeverIT_Capture = type(WoWForeverIT_Capture) == "table" and WoWForeverIT_Capture or {}
    WoWForeverIT_Capture.version = 1
    WoWForeverIT_Capture.quests = WoWForeverIT_Capture.quests or {}
    return WoWForeverIT_Capture
end

local function count()
    local n = 0
    for _, fields in pairs(store().quests) do
        for _ in pairs(fields) do n = n + 1 end
    end
    return n
end

local function safe(v)
    return type(v) == "string" and v ~= "" and not (type(issecretvalue) == "function" and issecretvalue(v))
end

local function capture(id, field, english, title)
    if type(id) ~= "number" or id <= 0 or not safe(english) then return end
    local own = WoWForeverIT_Quests and WoWForeverIT_Quests[id]
    -- Local overrides replace the whole quest: fields they lack stay English.
    if own and own[ownField[field]] then return end
    local ok, status = pcall(Core.TranslationStatus, id, field, english)
    if not ok then return end
    local quests = store().quests
    if status == "current" then
        if quests[id] then
            quests[id][field] = nil
            if not next(quests[id]) then quests[id] = nil end
        end
        return
    end
    local okHash, hash = pcall(Core.EnglishHash, english)
    if not okHash then return end
    local entry = quests[id] and quests[id][field]
    if entry and entry.hash == hash then entry.seen = time and time() or entry.seen return end
    if not entry and count() >= LIMIT then return end
    quests[id] = quests[id] or {}
    quests[id][field] = {
        -- The player's own name, class and race become $N/$L/$C/$R as translators write them.
        en = Core.NormalizeText(Core.Placeholders(english)),
        hash = hash,
        status = status,
        title = safe(title) and title or nil,
        build = GetBuildInfo and select(2, GetBuildInfo()) or nil,
        seen = time and time() or nil,
    }
end

local function read(api)
    if type(api) ~= "function" then return nil end
    local ok, value = pcall(api)
    if ok then return value end
end

local fieldsByEvent = {
    QUEST_DETAIL = {{"title", "GetTitleText"}, {"text", "GetQuestText"}, {"objectives", "GetObjectiveText"}},
    QUEST_PROGRESS = {{"title", "GetTitleText"}, {"progress", "GetProgressText"}},
    QUEST_COMPLETE = {{"title", "GetTitleText"}, {"reward", "GetRewardText"}},
}

local function fromNpc(event)
    local id = type(GetQuestID) == "function" and read(GetQuestID)
    local title = read(GetTitleText)
    for _, pair in ipairs(fieldsByEvent[event]) do capture(id, pair[1], read(_G[pair[2]]), title) end
end

local function fromLog()
    if not C_QuestLog or type(C_QuestLog.GetSelectedQuest) ~= "function" then return end
    local id = read(C_QuestLog.GetSelectedQuest)
    if type(id) ~= "number" or id <= 0 then return end
    local title = type(C_QuestLog.GetTitleForQuestID) == "function" and C_QuestLog.GetTitleForQuestID(id)
    capture(id, "title", title, title)
    if type(GetQuestLogQuestText) == "function" then
        local ok, description, objectives = pcall(GetQuestLogQuestText)
        if ok then
            capture(id, "text", description, title)
            capture(id, "objectives", objectives, title)
        end
    end
end

local function enabled() return WoWForeverIT_GetOption("capture") end

local hooked = {}
local function install()
    if type(hooksecurefunc) ~= "function" then return end
    for _, name in ipairs({"QuestMapFrame_ShowQuestDetails", "QuestLog_UpdateQuestDetails"}) do
        if not hooked[name] and type(_G[name]) == "function" then
            hooked[name] = pcall(hooksecurefunc, name, function()
                if enabled() then pcall(fromLog) end
            end)
        end
    end
end

local frame = CreateFrame("Frame")
for _, event in ipairs({"ADDON_LOADED", "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE"}) do frame:RegisterEvent(event) end
frame:SetScript("OnEvent", function(_, event)
    if event == "ADDON_LOADED" then install() return end
    if enabled() then pcall(fromNpc, event) end
end)
install()

function WoWForeverIT_CaptureCommand(argument)
    local prefix = "|cff44ccff[WoWForeverIT]|r "
    if argument == "azzera" or argument == "reset" then
        store().quests = {}
        print(prefix .. "Testi raccolti azzerati.")
        return
    end
    print(prefix .. "Testi inglesi senza traduzione raccolti: " .. count() .. (enabled() and "" or " (raccolta disattivata nelle opzioni)"))
    print(prefix .. "Vengono salvati con /reload o all'uscita in WTF\\Account\\<account>\\SavedVariables\\WoWForeverIT.lua. /wfit cattura azzera per svuotare.")
end

-- Exposed for tests.
WoWForeverIT_CaptureField = capture
