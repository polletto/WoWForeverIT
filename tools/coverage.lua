-- Reproducible count by unique quest ID; counts stored fields, not verified quests.
for line in io.lines('WoWForeverIT/WoWForeverIT.toc') do
 if line:match('%.lua$') and line~='Core.lua' then dofile('WoWForeverIT/'..line) end
end
local data=WoWForeverIT_QuestIT.DataIT
local own=WoWForeverIT_Quests or {}
local union={}
local imported,localCount,overlap=0,0,0
for id in pairs(data) do imported=imported+1;union[id]=true end
for id in pairs(own) do localCount=localCount+1;if data[id] then overlap=overlap+1 end;union[id]=true end
local count,full,fields,unchangedTitles=0,0,0,0
local core=WoWForeverIT_QuestIT.Core
local columns={title=0,text=0,objectives=0,progress=0,reward=0}
for id in pairs(union) do
 count=count+1
 local t=own[id] or data[id]
 local present=0
 local title=own[id] and t.title or (t.title and t.title.it)
 local source=data[id] and data[id].title
 if title and source then
  local hash=core.TextHash(core.FoldCase(core.NormalizeText(core.GenericPlaceholders(title))))
  if core.HashMatches(source.enHash,hash) then unchangedTitles=unchangedTitles+1 end
 end
 for _,field in ipairs({'title','text','objectives','progress','reward'}) do
  local key=own[id] and ({text='description',reward='completion'})[field] or nil
  local value=t[key or field]
  if (type(value)=='string' and value~='') or (type(value)=='table' and type(value.it)=='string' and value.it~='') then
   present=present+1;columns[field]=columns[field]+1
  end
 end
 if present==5 then full=full+1 end
 fields=fields+present
end
print('Imported/extended records: '..imported)
print('Local overrides: '..localCount..'; overlapping IDs: '..overlap)
print('Unique quest IDs: '..count)
print('All five fields present: '..full..'; partial records: '..(count-full))
print('Effective stored fields: '..fields)
print('Titles unchanged against English fingerprints: '..unchangedTitles)
for _,field in ipairs({'title','text','objectives','progress','reward'}) do print(field..': '..columns[field]) end
print('Presence does not establish Italian quality, Forever text matching, or in-game verification.')
