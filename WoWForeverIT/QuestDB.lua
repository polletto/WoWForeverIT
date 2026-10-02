-- Adapter for QuestIT 0.8.6 by Drakanast. See Vendor/QuestIT/LICENSE.
-- Keep the upstream text fingerprints and render player placeholders at runtime.
local Core = WoWForeverIT_QuestIT.Core
Core.Try = function(_, fn, ...) return pcall(fn, ...) end

function WoWForeverIT_TranslateField(id, field, english)
    if type(english) ~= "string" or english == "" then return nil end
    local ok, status, translation = pcall(Core.TranslationStatus, id, field, english)
    if not ok or status ~= "current" then return nil end
    local rendered, text = pcall(function()
        return Core.RenderItalian(translation.it, Core.PlayerInfo())
    end)
    if rendered then return text end
end

function WoWForeverIT_ResolveQuest(id, inLog)
    -- Retain the small database already tested in game as local overrides.
    local own = WoWForeverIT_Quests and WoWForeverIT_Quests[id]
    if own then return own end
    if not WoWForeverIT_QuestIT.DataIT[id] then return nil end
    local result = {}
    local function read(field, api)
        if type(api) ~= "function" then return end
        local ok, english = pcall(api)
        if ok then result[field] = WoWForeverIT_TranslateField(id,
            field == "description" and "text" or field == "completion" and "reward" or field, english) end
    end
    if inLog then
        read("title", function() return C_QuestLog.GetTitleForQuestID(id) end)
        if type(GetQuestLogQuestText) == "function" then
            local ok, description, objectives = pcall(GetQuestLogQuestText)
            if ok then
                result.description = WoWForeverIT_TranslateField(id, "text", description)
                result.objectives = WoWForeverIT_TranslateField(id, "objectives", objectives)
            end
        end
    else
        read("title", GetTitleText)
        read("description", GetQuestText)
        read("objectives", GetObjectiveText)
        read("progress", GetProgressText)
        read("completion", GetRewardText)
    end
    if next(result) then return result end
end

function WoWForeverIT_VisibleQuestTranslations()
    local result = {}
    for id, entry in pairs(WoWForeverIT_Quests or {}) do result[id] = entry end
    -- Query only quests present in the log, not all 2,446 database IDs.
    if C_QuestLog and C_QuestLog.GetNumQuestLogEntries and C_QuestLog.GetInfo then
        local ok, count = pcall(C_QuestLog.GetNumQuestLogEntries)
        if ok and type(count) == "number" then
            for index = 1, count do
                local success, info = pcall(C_QuestLog.GetInfo, index)
                if success and info and not info.isHeader and info.questID and not result[info.questID] then
                    local title = WoWForeverIT_TranslateField(info.questID, "title", info.title)
                    if title then result[info.questID] = {title = title, sourceTitle = info.title} end
                end
            end
        end
    end
    return result
end
