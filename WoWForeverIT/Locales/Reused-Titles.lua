-- Italian titles reused from WOW Forver - Italiano contributors (MIT).
-- See Vendor/WOWForverItaliano/LICENSE and Sources-Reused.txt.
-- Fill only titles still identical to their English source; preserve fingerprints.
local db = WoWForeverIT_QuestIT.DataIT
local entries = {
    [87] = {"Goldtooth", "Dentedoro"},
    [3904] = {"Milly's Harvest", "Il raccolto di Milly"},
    [3905] = {"Grape Manifest", "Elenco dell'uva"},
    [398] = {"Wanted: Maggot Eye", "Ricercato: Maggot Eye"},
}
for id, pair in pairs(entries) do
    local quest = db[id]
    if quest and quest.title and quest.title.it == pair[1] then
        quest.title.it = pair[2]
    end
end
