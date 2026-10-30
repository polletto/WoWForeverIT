-- Usage: lua5.1 tools/export_capture.lua path/to/SavedVariables/WoWForeverIT.lua > capture.json
-- Lists the English quest texts captured in game (WoWForeverIT_Capture) as JSON,
-- with the fingerprint to use as enHash once a field is translated.
local path = assert(arg[1], "usage: lua5.1 tools/export_capture.lua WoWForeverIT.lua")
local chunk = assert(loadfile(path))
setfenv(chunk, {})
local env = getfenv(chunk)
chunk()
local quests = env.WoWForeverIT_Capture and env.WoWForeverIT_Capture.quests or {}

local function quote(s)
    return '"' .. tostring(s):gsub('[%c"\\]', function(c)
        local named = {['"'] = '\\"', ['\\'] = '\\\\', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t'}
        return named[c] or string.format('\\u%04x', c:byte())
    end) .. '"'
end

local rows = {}
for id, fields in pairs(quests) do
    for field, entry in pairs(fields) do
        rows[#rows + 1] = {id = id, field = field, entry = entry}
    end
end
local order = {title = 1, text = 2, objectives = 3, progress = 4, reward = 5}
table.sort(rows, function(a, b)
    if a.id ~= b.id then return a.id < b.id end
    return (order[a.field] or 9) < (order[b.field] or 9)
end)
local out = {}
for _, row in ipairs(rows) do
    local e = row.entry
    out[#out + 1] = string.format('  {"id": %d, "field": %s, "title": %s, "status": %s, "enHash": %s, "en": %s}',
        row.id, quote(row.field), e.title and quote(e.title) or "null", quote(e.status or "missing"),
        quote(e.hash or ""), quote(e.en or ""))
end
print("[\n" .. table.concat(out, ",\n") .. "\n]")
io.stderr:write(#rows .. " campi raccolti\n")
