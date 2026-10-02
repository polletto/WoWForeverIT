-- Exact short objective labels from user captures and sourced quest pages.
local terms = {
    ["Protect the Index"] = "Proteggi l'Index Esoteria",
    ["Al'Aketh Windstone Charm"] = "Amuleto di Pietra del Vento degli Al'Aketh",
    ["Confront Belathaan Brightwish"] = "Affronta Belathaan Brightwish",
    ["Speak with Rathiril Sunlance"] = "Parla con Rathiril Sunlance",
    ["Speak with the Innkeeper"] = "Parla con la locandiera",
    ["Windsong Crawler Meat"] = "Carne di Granchio di Cantovento",
    ["Flutterfly Dust"] = "Polvere di Svolazzafarfalla",
    ["Lowlands Galestrider Tenderloin"] = "Filetto di Calcavento delle Pianure",
    ["Wind Hollow Essence"] = "Essenza di Spirito del Vento Vuoto",
    ["Abandoned Belongings"] = "Oggetti Abbandonati",
    ["Resaan's Heirloom"] = "Cimelio di Resaan",
    ["Ripe Stormapple"] = "Melatempesta Matura",
    ["Hungry Bandit slain"] = "Banditi Affamati uccisi",
    ["Obtain Crystallized lightning from the Shrieking Cave"] = "Recupera il Fulmine Cristallizzato nella Grotta Stridente",
    ["Obtain Crystallized Lightning from the Shrieking Cave"] = "Recupera il Fulmine Cristallizzato nella Grotta Stridente",
    ["Obtain Enchanted Gyrozephyr from Windsong Lake"] = "Recupera il Girozefiro Incantato nel Lago Cantovento",
    ["Obtain Air Construct Core from the Bandit Camp"] = "Recupera il Nucleo del Costrutto d'Aria nell'accampamento dei banditi",
    ["Listen to what Riaani Nightwind has to say"] = "Ascolta Riaani Nightwind",
    ["Find and speak with Elegael Thornpaw in the northeastern part of Shadowgale Forest."] = "Trova Elegael Thornpaw a nordest della Foresta di Ventombra e parlagli.",
    ["Speak with Aamelia Windfield about the Malfunctioning Cyclone Construct."] = "Parla con Aamelia Windfield del Costrutto Ciclone Malfunzionante.",
    ["Ready for turn-in"] = "Pronta per la consegna",
}
-- The client may wrap objective text with newlines or non-breaking spaces.
local function key(text)
    return text:gsub("\194\160", " "):gsub("%s+", " "):match("^%s*(.-)%s*$"):lower()
end
local normalized = {}
for english, italian in pairs(terms) do normalized[key(english)] = italian end
local function lookup(text) return text and normalized[key(text)] end
function WoWForeverIT_TranslateObjectiveLine(english)
    if type(english) ~= "string" then return nil end
    local direct = lookup(english)
    if direct then return direct end
    local prefix, count, term = english:match("^(%s*%-?%s*)(%d+%s*/%s*%d+%s+)(.+)$")
    local translated = lookup(term)
    if translated then return prefix .. count .. translated end
    local lead, item, suffix = english:match("^([%s%-]*)(.-)(:%s*%d+%s*/%s*%d+.*)$")
    translated = lookup(item)
    if translated then return lead .. translated .. suffix end
    local dash, objective = english:match("^(%s*%-%s*)(.+)$")
    translated = lookup(objective)
    if translated then return dash .. translated end
end
