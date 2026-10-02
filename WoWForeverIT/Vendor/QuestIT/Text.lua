-- WoWForeverIT_QuestIT: funzioni comuni, esposte in WoWForeverIT_QuestIT.Core per il visualizzatore
-- e per l'addon facoltativo WoWForeverIT_QuestITCollector (## Dependencies: WoWForeverIT_QuestIT).
-- Le regole devono restare identiche a tools/qit_text.py (vedi doc/impronta.md).
WoWForeverIT_QuestIT = WoWForeverIT_QuestIT or {}
local Core = {}
WoWForeverIT_QuestIT.Core = Core

-- Pattern Lua case-insensitive per una stringa letterale, delimitato da
-- frontiere di parola (così "Mage" non tocca "damage").
local function ciPattern(s)
    local p = s:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
    p = p:gsub("%a", function(c) return "[" .. c:lower() .. c:upper() .. "]" end)
    return "%f[%w]" .. p .. "%f[%W]"
end

-- Su Forever UnitName("player") restituisce "<nome> <cognome>" in un'unica
-- stringa. Si divide al primo spazio; il cognome può mancare.
function Core.SplitPlayerName(fullName)
    if type(fullName) ~= "string" or fullName == "" then return nil, nil end
    local space = fullName:find(" ", 1, true)
    if not space then return fullName, nil end
    local first, last = fullName:sub(1, space - 1), fullName:sub(space + 1)
    if first == "" then first = nil end
    if last == "" then last = nil end
    return first, last
end

-- Nome e cognome del personaggio -> $N $L, $N, $L.
-- $L è un segnaposto nostro (cognome): Blizzard non ne ha uno.
function Core.NamePlaceholders(text)
    if type(text) ~= "string" or text == "" then return text end
    local first, last = Core.SplitPlayerName(UnitName("player"))
    if first and last then text = text:gsub(ciPattern(first .. " " .. last), "$N $L") end
    if first then text = text:gsub(ciPattern(first), "$N") end
    if last then text = text:gsub(ciPattern(last), "$L") end
    return text
end

-- Raccoglitore: segnaposto del SOLO personaggio ($N, $L, la sua classe $C,
-- la sua razza $R).
function Core.Placeholders(text)
    if type(text) ~= "string" or text == "" then return text end
    text = Core.NamePlaceholders(text)
    local className = UnitClass("player")
    local raceName = UnitRace("player")
    if className and className ~= "" then text = text:gsub(ciPattern(className), "$C") end
    if raceName and raceName ~= "" then text = text:gsub(ciPattern(raceName), "$R") end
    return text
end

-- Come export_en.py: \r\n -> \n e niente spazi bianchi a fine testo.
function Core.NormalizeText(text)
    text = text:gsub("\r\n", "\n")
    text = text:gsub("[ \t\n\r\v\f]+$", "")
    return text
end

-- Impronta: h = (h * 31 + byte) mod 2^32 sui byte UTF-8, 8 cifre esadecimali.
-- Solo aritmetica intera sotto 2^53: esatta con i double di Lua 5.1.
function Core.TextHash(text)
    local h = 0
    for i = 1, #text do
        h = (h * 31 + text:byte(i)) % 4294967296
    end
    return string.format("%04x%04x", math.floor(h / 65536), h % 65536)
end

-- Impronta: TUTTE le classi -> $C e TUTTE le razze -> $R, dalla lista unica
-- WoWForeverIT_QuestIT.NamesEN (Names_en.lua, generato da data/names_en.json), già
-- ordinata con i nomi più lunghi prima. L'impronta non dipende dal personaggio.
function Core.GenericPlaceholders(text)
    local names = WoWForeverIT_QuestIT.NamesEN
    for _, name in ipairs(names.classes) do text = text:gsub(ciPattern(name), "$C") end
    for _, name in ipairs(names.races) do text = text:gsub(ciPattern(name), "$R") end
    return text
end

-- Impronta (versione WoWForeverIT_QuestIT.NamesEN.hashVersion) del testo inglese preso
-- dalle API, confrontabile con data/it. Regole: doc/impronta.md.
function Core.EnglishHash(apiText)
    return Core.TextHash(Core.FoldCase(Core.NormalizeText(Core.GenericPlaceholders(Core.NamePlaceholders(apiText)))))
end

-- Impronta v5: maiuscole e minuscole non contano. Solo le lettere ASCII A-Z,
-- come in qit_text.py (string.lower dipende dal locale).
function Core.FoldCase(text)
    return (text:gsub("[A-Z]", function(c) return string.char(c:byte() + 32) end))
end

-- Seconda prova: segnaposto ATTACCATI ad altre lettere.
-- In alcuni testi il gioco incolla il nome del personaggio, la sua classe o la sua razza
-- ad altre lettere: "$Nama" diventa "Zugrakama", "$Rs" diventa "Orcs", "Arch$c" diventa
-- "Archmage". Con le frontiere di parola quelle parole non tornano segnaposto e l'impronta
-- non combacia (doc/impronta.md, "Limite noto"). Qui si rifà l'impronta sostituendo le
-- stesse forme anche DENTRO le parole. Le regole dell'impronta (v5) non cambiano: cambia
-- solo il testo su cui si calcola, e solo quando la prima ricerca non ha trovato niente.
local function attachedPattern(s)  -- come ciPattern, ma senza frontiere di parola
    local p = s:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
    return (p:gsub("%a", function(c) return "[" .. c:lower() .. c:upper() .. "]" end))
end

-- Solo le forme del PERSONAGGIO (nome, cognome, la sua classe, la sua razza): sono le
-- uniche che il gioco può avere incollato ad altre lettere in un testo che sta leggendo.
function Core.AttachedPlaceholders(text)
    if type(text) ~= "string" or text == "" then return text end
    local first, last = Core.SplitPlayerName(UnitName("player"))
    if first and last then text = text:gsub(attachedPattern(first .. " " .. last), "$N $L") end
    if first then text = text:gsub(attachedPattern(first), "$N") end
    if last then text = text:gsub(attachedPattern(last), "$L") end
    local className = UnitClass("player")
    local raceName = UnitRace("player")
    if className and className ~= "" then text = text:gsub(attachedPattern(className), "$C") end
    if raceName and raceName ~= "" then text = text:gsub(attachedPattern(raceName), "$R") end
    return text
end

-- Impronta della seconda prova: prima le regole di sempre, poi le forme attaccate.
function Core.AttachedEnglishHash(apiText)
    return Core.TextHash(Core.FoldCase(Core.NormalizeText(
        Core.AttachedPlaceholders(Core.GenericPlaceholders(Core.NamePlaceholders(apiText))))))
end

-- enHash di una traduzione: una stringa o una lista di impronte (una per forma
-- del testo inglese, per esempio per genere). Vale se l'impronta è una di quelle.
function Core.HashMatches(enHash, hash)
    if type(enHash) == "table" then
        for _, h in ipairs(enHash) do if h == hash then return true end end
        return false
    end
    return enHash == hash
end

-- Stato della traduzione di un campo, dato il testo inglese attuale (dalle API):
--   "current" -> tradotto e l'impronta coincide (seconda risposta: la traduzione)
--   "changed" -> tradotto, ma l'inglese è cambiato
--   "missing" -> non tradotto
-- Tabella dati: WoWForeverIT_QuestIT.DataIT, generata da tools/build_db.py (Data_it.lua).
-- Varianti: un campo può avere testi diversi secondo chi lo vede (per esempio la classe),
-- tradotti a parte come "text#2", "text#3"... (doc/impronta.md, "Varianti di un campo").
-- Si prova prima il campo, poi le varianti. "changed" solo se il campo principale è tradotto.
function Core.TranslationStatus(questID, field, englishApiText)
    local entry = WoWForeverIT_QuestIT.DataIT and WoWForeverIT_QuestIT.DataIT[questID]
    if not entry then return "missing" end
    local candidates = {}
    if entry[field] then candidates[1] = entry[field] end
    local prefix = field .. "#"
    for name, tr in pairs(entry) do
        if type(name) == "string" and name:sub(1, #prefix) == prefix then candidates[#candidates + 1] = tr end
    end
    if #candidates == 0 then return "missing" end
    local hash = Core.EnglishHash(englishApiText)
    for _, tr in ipairs(candidates) do
        if Core.HashMatches(tr.enHash, hash) then return "current", tr end
    end
    -- seconda prova, solo se la prima non ha trovato niente
    local attached = Core.AttachedEnglishHash(englishApiText)
    for _, tr in ipairs(candidates) do
        if Core.HashMatches(tr.enHash, attached) then return "current", tr end
    end
    return entry[field] and "changed" or "missing"
end


-- Ricerca in una tabella a impronta (saluti, pagine, opzioni): prima l'impronta di sempre,
-- poi quella della seconda prova. La terza risposta resta SEMPRE l'impronta normale: è la
-- chiave con cui il raccoglitore identifica il testo.
local function lookup(store, apiText)
    local key = Core.EnglishHash(apiText)
    local tr = store and store[key]
    if tr then return "current", tr, key end
    local attached = Core.AttachedEnglishHash(apiText)
    if attached ~= key and store and store[attached] then return "current", store[attached], key end
    return "missing", nil, key
end

-- Saluti degli NPC (gossip e pannello di saluto): non hanno un ID, si
-- identificano con l'impronta del testo inglese (stesse regole).
--   "current" -> tradotto (seconda risposta: la traduzione), "missing" -> no.
-- La terza risposta è sempre la chiave (impronta). Tabella: WoWForeverIT_QuestIT.GossipIT.
function Core.GossipStatus(englishApiText)
    return lookup(WoWForeverIT_QuestIT.GossipIT, englishApiText)
end

-- Pagine dei testi da leggere (libri, pergamene, lettere, targhe): come i saluti,
-- chiave = impronta del testo inglese della pagina. Tabella: WoWForeverIT_QuestIT.BooksIT.
function Core.BookStatus(englishApiText)
    return lookup(WoWForeverIT_QuestIT.BooksIT, englishApiText)
end

-- Opzioni di dialogo (impronta v6): chiave senza il passo delle classi e razze, che in un
-- pulsante sono di solito quelle del pulsante ("Warrior", "I am interested in mage
-- training."). Come option_hash in tools/qit_text.py; doc/impronta.md, "Opzioni di dialogo".
function Core.OptionHash(apiText)
    return Core.TextHash(Core.FoldCase(Core.NormalizeText(Core.NamePlaceholders(apiText))))
end

-- Opzioni di dialogo del GossipFrame (C_GossipInfo.GetOptions, campo name). Tabella:
-- WoWForeverIT_QuestIT.OptionsIT. Tre prove, in ordine:
--   1. il testo così com'è (solo nome e cognome -> $N/$L);
--   2. la classe e la razza DEL GIOCATORE -> $C/$R, per le opzioni tradotte con $C
--      ("I require $C training.", il pulsante dell'istruttore della sua classe);
--   3. i segnaposto attaccati ad altre lettere (come la seconda prova dei saluti).
-- La terza risposta è la chiave trovata; se non si trova niente, quella della prova 1,
-- con cui il raccoglitore salva il testo.
function Core.OptionStatus(englishApiText)
    local store = WoWForeverIT_QuestIT.OptionsIT
    local key = Core.OptionHash(englishApiText)
    if store and store[key] then return "current", store[key], key end
    local own = Core.TextHash(Core.FoldCase(Core.NormalizeText(Core.Placeholders(englishApiText))))
    if own ~= key and store and store[own] then return "current", store[own], own end
    local attached = Core.TextHash(Core.FoldCase(Core.NormalizeText(
        Core.AttachedPlaceholders(Core.NamePlaceholders(englishApiText)))))
    if attached ~= key and store and store[attached] then return "current", store[attached], attached end
    return "missing", nil, key
end

-- Pagina in HTML (la finestra di lettura è un SimpleHTML): per ora non si traduce.
function Core.IsHTML(text)
    return type(text) == "string" and text:find("^%s*<[Hh][Tt][Mm][Ll]") ~= nil
end

-- Nomi italiani (minuscoli, da testo corrente) per token di classe e razza.
-- { maschile, femminile }. Se il token manca si usa il nome del client.
Core.CLASS_IT = {
    WARRIOR = { "guerriero", "guerriera" },
    PALADIN = { "paladino", "paladina" },
    HUNTER = { "cacciatore", "cacciatrice" },
    ROGUE = { "ladro", "ladra" },
    PRIEST = { "sacerdote", "sacerdotessa" },
    SHAMAN = { "sciamano", "sciamana" },
    MAGE = { "mago", "maga" },
    WARLOCK = { "stregone", "strega" },
    DRUID = { "druido", "druida" },
}
Core.RACE_IT = {
    Human = { "umano", "umana" },
    Dwarf = { "nano", "nana" },
    NightElf = { "elfo della notte", "elfa della notte" },
    Gnome = { "gnomo", "gnoma" },
    Orc = { "orco", "orchessa" },
    Scourge = { "non morto", "non morta" },
    Tauren = { "tauren", "tauren" },
    Troll = { "troll", "troll" },
}

-- Articolo davanti a $C e $R: chi traduce scrive l'articolo base (un, una, il, la, del,
-- della...), qui si accorda con la parola inserita. { davanti a s+consonante/z/gn/ps/x,
-- davanti a vocale } ("un stregone" -> "uno stregone", "una orchessa" -> "un'orchessa").
-- Vedi doc/stile.md, "Articolo davanti a $C e $R".
local ARTICLES = {
    un = { "uno", nil }, una = { nil, "un'" },
    il = { "lo", "l'" }, la = { nil, "l'" },
    del = { "dello", "dell'" }, della = { nil, "dell'" },
    al = { "allo", "all'" }, alla = { nil, "all'" },
    dal = { "dallo", "dall'" }, dalla = { nil, "dall'" },
    nel = { "nello", "nell'" }, nella = { nil, "nell'" },
    sul = { "sullo", "sull'" }, sulla = { nil, "sull'" },
}
local INSERTED = "\001" -- segnaposto interno: inizio di una classe o razza inserita

-- Forma dell'articolo per la parola che comincia con next (minuscolo): 1 = s impura, z,
-- gn, ps, x; 2 = vocale; nil = nessun cambio.
local function ArticleCase(next)
    if next:find("^[aeiou]") then return 2 end
    if next:find("^s[^aeiou]") or next:find("^[zx]") or next:find("^gn") or next:find("^ps") then return 1 end
    return nil
end

local function FixArticles(text)
    text = text:gsub("%f[%a](%a+)([ \t]+)" .. INSERTED .. "()", function(word, space, pos)
        local forms = ARTICLES[word:lower()]
        local case = forms and ArticleCase(text:sub(pos, pos + 1):lower())
        local fixed = case and forms[case]
        if not fixed then return word .. space .. INSERTED end
        if word:find("^%u") then fixed = fixed:gsub("^%l", string.upper) end
        -- un'/l'/dell'... si attaccano alla parola: niente spazio.
        return fixed .. (fixed:find("'$") and "" or space) .. INSERTED
    end)
    return (text:gsub(INSERTED, ""))
end

-- Testo italiano -> testo finale. info = { first, last, class, race, sex, npcSex }.
-- sex (giocatore, $G) e npcSex (NPC che parla, $P) come UnitSex: 3 = femmina;
-- 2, 1 (sconosciuto) e nil = forma maschile.
function Core.RenderItalian(text, info)
    local female, npcFemale = info.sex == 3, info.npcSex == 3
    text = text:gsub("%$[Pp]([^:;]*):([^;]*);", function(m, f) return npcFemale and f or m end)
    text = text:gsub("%$[Gg]([^:;]*):([^;]*);", function(m, f) return female and f or m end)
    if not info.last then text = text:gsub(" %$L", "") end
    local values = { N = info.first or "", L = info.last or "", C = info.class or "", R = info.race or "" }
    local source = text
    text = text:gsub("()%$([NLCR])", function(pos, k)
        local value = values[k]
        -- $C e $R (nomi minuscoli) prendono la maiuscola a inizio testo o riga, o dopo . ! ?
        if k == "C" or k == "R" then
            local before = source:sub(1, pos - 1):gsub("[ \t]+$", "")
            if before == "" or before:find("[\n.!?]$") then value = value:gsub("^%l", string.upper) end
            return INSERTED .. value
        end
        return value
    end)
    return FixArticles(text)
end

-- Genere dell'NPC con cui si parla, per $P: UnitSex("npc") (2 maschio, 3 femmina).
-- nil senza NPC (diario delle quest), con un valore segreto o in caso di errore.
function Core.NpcSex()
    local ok, sex = Core.Try({ func = "UnitSex(\"npc\")" }, UnitSex, "npc")
    if not ok or sex == nil then return nil end
    if issecretvalue and issecretvalue(sex) then return nil end
    if type(sex) ~= "number" then return nil end
    return sex
end

-- Dati del personaggio corrente (e genere dell'NPC) per RenderItalian.
function Core.PlayerInfo()
    local first, last = Core.SplitPlayerName(UnitName("player"))
    local sex = UnitSex("player")
    local g = (sex == 3) and 2 or 1
    local className, classToken = UnitClass("player")
    local raceName, raceToken = UnitRace("player")
    local classIT = Core.CLASS_IT[classToken or ""]
    local raceIT = Core.RACE_IT[raceToken or ""]
    return {
        first = first, last = last, sex = sex, npcSex = Core.NpcSex(),
        class = classIT and classIT[g] or className,
        race = raceIT and raceIT[g] or raceName,
    }
end
