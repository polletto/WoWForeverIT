# 0.9.12 — 2026-10-09

- Estensione di quest, oggetti, abilità e dialoghi NPC con controlli sul testo originale.
- Nomi di creature in nameplate e bersaglio, con opzione e protezione dei nomi dei giocatori e pet.
- Correzione dei nomi negli incantesimi ripetuti e traduzioni parziali di menu, pannello Amici, tooltip e messaggi di sistema.
- Due screenshot di verifica in gioco nel README.

# Changelog

## 0.9.11

- Restore the complete tested icon binary after a transfer error in 0.9.10. Spell translations and behavior match the approved test14.

## 0.9.10

- Add Italian spell names and matched descriptions for mage abilities and an initial batch for all other classes, general abilities and racial passives.
- Translate supported buff effects, cast/channel names and warrior spellbook section headings.
- Add the custom addon icon and draggable minimap launcher with a gold border, plus saved spell translation options.
- Preserve numeric values, unknown text and protected UI; spell display updates remain disabled during combat lockdown.
- Publish the same GitHub beta ZIP automatically to CurseForge.

## 0.9.9

- Add the WoWForeverIT logo with an ITA badge and Italian tricolor to the repository and README.
- Add quest 96656 (Eleanor Shackleton): Italian title, description and objective, guarded by English fingerprints.
- Translate Vital Intelligence and Eleanor tracker objectives, including wrapped lines.
- Update coverage to 2,465 unique quest IDs; missing progress and completion fields remain absent.

## 0.9.8

- Add saved checkbox options for quests, quest tooltips, interface and debug, opened with /wfit or /wfit opzioni.

- Preserve class color spans and resize translated character tooltips.
- Add partial spellbook/appearance filter translations and quest 98389 English text variant.
- Add five beta screenshots to the README.
- Translate visible labels in character, reputation, skill, spellbook, profession and trainer panels. Keep editable fields and spell/recipe descriptions unchanged.
- Reapply labels after supported panel updates and install hooks for panels loaded later.


## 0.9.7

- Add `/wfit tooltip` for a delayed tooltip diagnostic snapshot.

- Translate quest log row and map pin tooltips: available titles, fingerprint-matched fields, short objectives and beta F6 issue instruction. Unknown text remains unchanged; item and spell tooltips are outside this scope.
- Hook QuestLogQuests_Update, which redraws the log when hovering map pins, to restore Italian rows immediately.
- Tooltip language toggle restores only unchanged lines owned by the active tooltip. Map-pin title, objective and F6 instruction verified in game by the tester.


## 0.9.6

- Reuse four previously English-identical quest titles from WOW Forver - Italiano contributors, preserving source credits and MIT notice.
- Keep existing Italian titles and English fingerprints; beta text changes still fall back to English.
- Unique quest count stays 2,464; English-identical titles decrease from 516 to 512.


## 0.9.5

- Secure post-hooks apply quest/map/tracker translations immediately after supported UI redraws rather than waiting for the 1.5-second safety ticker. Hooks also install on live modules loaded after login. Event retries are coalesced.
- Keep newly drawn counters and reused row labels during refresh; restore saved labels only when toggling back to English.
- Add six previously absent Zephras quests (26 fields) as concise original Italian adaptations with English fingerprints and recorded sources.
- Add reproducible coverage inventory: 2,464 unique IDs, 1,586 records with five stored fields, 878 partial records. These are data coverage counts, not a claim of complete or in-game-verified localization.
- Regression checks cover immediate redraws before timers, lazy loading, hook duplication, counters and language toggling. Map-pin title, objective and F6 instruction verified in game by the tester.

## 0.9.4

- Public repository documentation, contribution guide and issue forms.
- Preserve source credits and clarify code/game-text licensing.
- Reproducible installable ZIP packaging and regression checks.
- Short objective lookup tolerates line breaks, repeated spaces, non-breaking spaces and capitalization, including the Crystallized Lightning objective. Unknown labels and counters are preserved. Map-pin title, objective and F6 instruction verified in game by the tester.

## 0.9.3

- Ten Zephras quest titles represented by twelve records including the three Broken Construct stages.
- Add concise Italian adaptations of available quest fields and tracker objective labels.

## 0.9.0–0.9.2

- Integrate QuestIT 0.8.6 data with an isolated namespace, English fingerprints and player placeholders.
- Expand Esc/settings labels and add the first screenshot-backed Zephras fields.

## 0.8.1 and earlier

- Local Camposanto/Brill quest translations, NPC dialogs, map log and modern/legacy tracker support.
- Translate quest UI headers, buttons and colored quest count.
