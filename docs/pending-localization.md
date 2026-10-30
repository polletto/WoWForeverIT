Pending localization changes, 2026-10-08

No ZIP or release prepared for this batch, as requested.
- NPC pages/options use existing fingerprint tables: 95 greetings/pages and 49 dialogue options. Not all NPCs covered.
- Ten missing fields for nine already-present Zephras quests added (9 rewards, 1 progress).
- Eleven spell families: original Italian description translations; five aura families; numerical values captured at runtime.
- Player cast/channel labels refresh on repeated writes and deferred cast events. Only nonprotected labels allow combat display updates; spellbook/tooltip combat guard retained.
- Live beta verification pending. Local regression, fingerprints, player placeholders, reused cast labels, changed-mechanic rejection, language toggles pass via Lua5.4 shared library.
- Existing test15/test16/test17 changes retained.

Offline ForeverDB 0.30.0 inspected: 40 additional original Italian spell names for levels 1-10. All mappings and existing check18 regressions pass. Metadata dated Oct 8, client build 70205. No ZIP generated; live game validation pending. Source inventory: foreverdb-offline-inventory.json.

Additional batch: 174 spell names, full classSpells name coverage through level 30; quests 96821 and 99049 translated title/description/objectives using complete Forever fields and English fingerprints. Creature names retained where no verified Italian name exists. Database now 2529 IDs. check18 passes. No ZIP or publication.

Next offline batch: 32 additional title/objective fields across 17 quests, including initial Elwynn/Durotar and camping profession quests. Two objectives (95998, 97279) kept as separate fingerprinted variants, preserving previous texts. Database 2544 IDs. All 38 fields added across offline quest batches verified against exact sources with check_fields.py; regression suite passes. No ZIP/publication.

Integral source completion: 52 guarded fields across all 19 targeted quests (descriptions, available progress/completion, 3 objective variants). Excluded personalized source fields: 96821 reward (Joruus), 97225 progress (Enve), 97279 reward (Sparkled). All source texts recorded in foreverdb-full-quest-fields.json. 90 offline/integral fields checked current. Added Gouge body/aura, Blessing of Might hour variant, Serpent Sting aura; targeted numeric/pattern checks and existing regressions pass. No ZIP/publication.

Item localization module: dedicated items option (default on); modern Item tooltip postcall; generic binding/slots/armor-types/weapon-types/level/stats/durability/damage/speed translations. Five exact ID+English-name entries from offline sources. No inventory names or item links mutated, unknown effects untouched. check_items.py passes tooltip reuse, identity mismatch, colors, numbers, option restoration, combat/protected guards. Live client test required, no ZIP/release.

Item expansion: +119 verified ID/name pairs (124 total), initial quest items, materials, consumables, crafted gear. Added anchored profession-requirement, elemental-damage and block-value tooltip patterns; unknown professions remain unchanged. Mapping validation and check_items regression pass; inventory names remain unchanged, tooltip display only. No ZIP/release.

Live user verification Oct9: repeated player casts stay Italian; item generic lines and known names visible. New unpublished creature module: 20 observed Durotar/initial names, exact GUID creature ID + English title; unit tooltip only, separate creatures option. Players and pets excluded; names above units/target frames unchanged. check_creatures.py and offline identity validation pass. No new ZIP/release.

Nameplate test batch: 5 Zephras initial identities (Juvenile Vuldren, Pesky Cirrusfly, Cirrusfly Soldier/Queen, Scrawny Ursera), 25 creature names total. Nameplate SetText hook re-resolves current GUID/name on every write; players (explicit UnitIsPlayer + GUID exclusion) and pets untouched. Unknown names/IDs and protected FontStrings untouched. Local nameplate reuse/combat/toggle fixture passes. Live test still required.

After test19 packaging: added 3 further Zephras names (251143 Roiling Winds, 251160 Al'Aketh Convert, 251245 Prideclaw), total 28 creature names. Tests include exact ID/name matching for these. User requested no further ZIP until evening verification. test19 archive unchanged.

Micro menu: new scoped tooltip module, title translations preserve displayed keybindings/colors and obey interface option; unknown tooltip owners/text untouched. check_micro.py passes. Added 7 quests/14 title+objective fields (2551 database IDs); descriptions unavailable are not invented. Added 118 exact ID quest-item name entries via original family translations, existing names preserved. All 104 offline/integral fields current; item identity validation passes. No ZIP; new post-test19 changes pending evening live test.

## 2026-10-09 — Additional item and quest source pass
- 7,858 unique item names now available (original translations take priority). Imported data from z4mbo/WOW-Forver-Italiano, MIT, source snapshot/hash in Sources-Items-Imported.txt. Test/unused/deprecated names and unresolved placeholders excluded.
- 4,122 exact item-description records. Tooltip translation requires matching item ID, original English title and complete English description; changed values/effects remain unchanged. Quotes and colors preserved; disabling restores original text. No external runtime code imported. Source translations still need in-game proofreading.
- 2,609 quest IDs represented, with varying field coverage. All usable titles/objectives in the 339-quest observed offline inventory match a translation; all nontruncated Forever guide fields match. This is not complete description/reward coverage for every ID.
- Added full text/variants for remaining zone quests, 60 observed title/objective fields, nine guide fields, and four exact-source titles from the additional MIT source. Personalised source texts with literal player names excluded.
- Remaining additional quest source contains Italian bodies without independent English text; those bodies were not imported using title-only guards. Need original English records or live captures for safe field matching.
- Lua fixture checks pass for quest fingerprints, repeated casts, item descriptions/toggle restoration, creature/nameplate exclusions and micro menu. Live WoW verification pending. No ZIP, push or release created.

## 2026-10-09 — Creature/NPC pass
- 133 unique translated creature/NPC names, exact ID + original English name required. Includes starting Tirisfal, Mulgore, Durotar and new-island records. Existing translations preserved; proper names kept; summoned totems excluded from new data.
- Source: observed ForeverDB qfNpcNames and MIT z4mbo VerifiedNPC data (snapshot cited in Sources-Items-Imported.txt). Additional project-authored translations of generic titles/ranks. Records in docs/creatures-expansion.json include unchanged proper names for provenance, not translated coverage.
- Completed leftover English faction names, location labels and generic NPC ranks in the existing 95 gossip pages / 49 dialogue options; fingerprints and player placeholders unchanged. This is terminology completion, not newly discovered complete dialogue pages.
- Extra sources inspected have no new independent English NPC dialogue bodies; offline NPC data contains names, roles and positions, not conversation text. Unknown conversations remain untouched.
- Quest/NPC and creature/nameplate fixtures pass; players and pets excluded, protected labels skipped. Live nameplate verification pending tonight. No ZIP created.

## Test20 live feedback — 2026-10-09
- User confirms creature nameplate translations work in game. Target frame previously English: added scoped target name display translation with the same ID/name and player/pet guards; local fixture passes, live check pending.
- Screenshot fixes: Professions, Legacy, Guild & Communities and micro-menu level/shop notices; Skysight and Walk on Air racial names/bodies; Wild Harvest use text (item247841) exact full-source guarded.
- Creature tooltip Level, Beast, Corpse and F6 report instruction added, scoped to creature/vehicle GUIDs.
- Existing regressions and target fixture pass. No updated ZIP created yet.

- Test21 live screenshot confirms translated target name alongside creature nameplates. Screenshot added to README gallery. Observed tracker objectives remain English; requires follow-up.

## 18 ottobre — aggiornamento quest e interfaccia, non pubblicato
- 163 nuovi campi con impronta inglese su 110 quest; 2.687 ID totali. Le varianti precedenti sono conservate. Fonte ForeverDB 0.37.0, snapshot 2026-10-18.264fccc4.
- Restano sette campi dubbi e il nome proprio invariato Chakuyak: nessun testo troncato o segnaposto sospetto è stato importato.
- 74 nuove etichette esatte di menu, assistenza, addon, macro, Amici e gilda.
- Nuovo modulo GroupFinder per controlli statici noti di ricerca, creazione annunci, filtri e ruoli. Nessuna scansione di righe dei risultati, candidati o descrizioni degli annunci. Necessario screenshot/test live per confermare i nomi dei controlli del nuovo pannello Forever.
- Finestra opzioni più alta, nota ancorata sotto l'ultima checkbox, testo aggiornato su oggetti e creature.
- Fixture superate per fonti quest, guardie sui testi, traduzioni e ripristino UI, controlli LFG tardivi e contenuti dei giocatori. Verifica in gioco ancora necessaria. Nessuno ZIP, push o rilascio.

## Test1 LFG screenshot — 18 ottobre
- Screenshot 185915: title, Quests & Zones, Custom, Back and List Self stayed English.
- Cause: Forever uses Blizzard_GroupFinder_VanillaStyle, with LFGListingFrame/LFGBrowseFrame and CategoryView.CategoryButtons; previous module targeted different controls.
- Added actual named frames, listing footer, category buttons and category refresh hook. Verified hierarchy against Gethe/wow-ui-source branch forever, Blizzard_LFGVanilla_Listing.lua and Mainline XML. No traversal of player result rows or comment edit boxes.
- Fixture now reproduces the screenshot hierarchy and verifies all five visible labels, category redraw and English restoration. New package 0.9.13-test2; live check pending.

## Test2 LFG tooltip feedback — 18 ottobre
- User screenshots confirm translated panel labels; footer shortened from Pubblica disponibilità to Pubblica.
- Added exact tooltips Who List, Group Browser, Create Listing, tank/heal/damage descriptions, new-player guidance and class/role warning. MicroMenu tooltip owner whitelist now includes VanillaStyle parent/listing/browse frames and their descendants. Warning colors retained.
- Eight tooltip cases, restoration, parent ownership and unrelated-tooltip exclusion pass local fixtures. Package 0.9.13-test3; live tooltip verification pending.

## 30 ottobre — quest Forever da ForeverDB, non pubblicato
- 162 nuovi campi con impronta inglese per quest Forever (ID 80000+): 74 titoli, 81 obiettivi, 7 descrizioni. 76 ID nuovi nel database, 2.763 ID totali. Fonte: foreverdb.net (`data/questguides`) e ForeverDB Companion 0.54.5, build 1.60.1.70658. Testi e impronte in `quest-translations-2026-10-30.json`.
- ForeverDB non contiene testi di progresso o completamento per le quest Forever (0 su 2.595 ID): quei campi restano mancanti e servono catture in gioco.
- Le descrizioni del sito sostituiscono nome e classe del giocatore con "adventurer" e "class"; per 92947 e 94414 l'impronta usa `$C`/`$N`. Gli obiettivi con "the required number of" non sono stati importati. Otto descrizioni del sito coincidono già con traduzioni esistenti dopo questa normalizzazione e non sono state duplicate.
- Nomi di PNG, oggetti e luoghi lasciati in inglese come nel database principale. Titoli invariati (Moonglade, Chakuyak, Carnage, Frosthowl) non aggiunti.
- Verifica in gioco ancora necessaria. Nessuno ZIP o rilascio.

## 30 ottobre — progressi e completamenti Forever da Wowhead, non pubblicato
- 213 nuovi campi con impronta inglese su 125 quest Forever (ID 80000+): 91 testi di progresso e 122 di completamento. Altri 15 campi Zephras avevano già una traduzione con la stessa impronta e non sono stati duplicati; per 92840, 93737 e 93951 il testo Wowhead differisce da quello già tradotto e la nuova versione è aggiunta come variante. Fonte: sezioni Progress e Completion di www.wowhead.com/forever/quest=ID, lette dal browser il 30 ottobre. Testi, impronte e traduzioni in `quest-translations-2026-10-30-wowhead.json`.
- Wowhead mostra `<name>`, `<class>` e `<race>` al posto di nome, classe e razza: convertiti in `$N`, `$C` e `$R` prima di calcolare l'impronta. Il testo è stato preso dall'HTML della pagina con gli a capo `<br>`, spazi doppi compresi.
- 62 delle 209 quest Forever senza questi campi non hanno testi su Wowhead (quasi tutte con ID 98000+): restano mancanti.
- Nomi di PNG, oggetti e luoghi lasciati in inglese come nei campi ForeverDB. Verifica in gioco ancora necessaria. Nessuno ZIP o rilascio.
