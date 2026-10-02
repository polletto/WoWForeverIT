# Contribuire / Contributing

## Segnalare senza programmare

Apri una Issue e scegli missione mancante oppure problema dell'interfaccia. Per una quest, fornisci l'ID: presso l'NPC attiva `/wfit debug`, poi apri il dialogo. Per una missione già nel registro selezionala e usa `/wfit info`. Indica build del gioco, versione addon, titolo inglese e fase (accettazione, registro, progresso o completamento).

Allega il testo o uno screenshot leggibile. Non pubblicare dati personali, informazioni dell'account o intere cartelle WTF. Non abbandonare una quest solo per raccogliere dati: puoi segnalare il campo disponibile e completare gli altri in seguito.

## Tradurre e revisionare

- Verifica ID e fase: un titolo può identificare più missioni di una catena.
- Non inventare campi mancanti e non cambiare quantità, destinazioni o condizioni.
- Mantieni riconoscibili i nomi di NPC e oggetti del client. Proponi modifiche al glossario separatamente.
- Conserva segnaposto `$N`, `$L`, `$C`, `$R` e sintassi di genere; non inserire il nome del tuo personaggio nella traduzione.
- Distingui traduzione fedele, adattamento sintetico e testo Vanilla non confermato.
- Indica la fonte e verifica le condizioni del materiale che contribuisci. Non assumere che la licenza di un programma copra tutti i suoi dati.
- I nuovi campi importati devono mantenere il confronto con il testo inglese. Non aggirare il controllo solo per far comparire una traduzione.

La discussione e revisione avvengono tramite Issues e pull request. I contributi al codice originale sono proposti sotto MIT; i crediti e le condizioni del materiale di terzi devono restare distinti.

## Struttura

| Percorso | Contenuto |
| --- | --- |
| `WoWForeverIT/Core.lua` | Eventi, hook e aggiornamento delle finestre |
| `WoWForeverIT/QuestDB.lua` | Adattatore, controllo dei testi e segnaposto |
| `WoWForeverIT/Locales/itIT.lua`, `Brill.lua` | Override locali storici |
| `WoWForeverIT/Locales/Zephras*.lua` | Estensioni per Zephras |
| `WoWForeverIT/Locales/Tracker.lua` | Obiettivi brevi e contatori |
| `WoWForeverIT/Locales/UI.lua` | Dizionario interfaccia |
| `WoWForeverIT/Vendor/QuestIT/` | Dati e utilità importati con crediti |
| `tests/regression.lua` | Verifiche con API WoW simulate |
| `tools/package.py` | ZIP installabile e controllo TOC |

Evita di modificare i file generati di QuestIT per una correzione locale: preferisci un'estensione caricata dopo di essi. Il confronto usa la normalizzazione di `Vendor/QuestIT/Text.lua` e `Names_en.lua`, non un hash del testo grezzo. I testi recuperati via web possono avere a capo diversi da quelli del client: documenta le varianti e raccogli il testo in gioco quando possibile.

Esegui i controlli locali, poi verifica in gioco: cambio di quest, campi mancanti, consegna, contatori, riapertura mappa, aggiornamento tracker e `/wfit toggle`. Per la UI verifica che ricerche, nomi macro e comandi digitati restino intatti. Limita la scansione ai pannelli necessari: non percorrere globalmente UIParent.

## English

You can contribute without coding. Open an Issue with the quest ID, addon version, beta build, quest stage and readable text/screenshot. Keep quantities and conditions correct; retain player placeholders and identify source/provenance. Never fabricate missing fields or bypass English fingerprint checks.

Submit focused pull requests. Preserve third-party notices and distinguish original code licensing from game-text rights. Run `lua tests/regression.lua` and `python3 tools/package.py`, then test the actual client. Mock checks are not a substitute for in-game verification.

## Pubblicare una beta / Publishing a beta

Aggiorna `## Version` nel TOC e il changelog, poi pubblica il commit su `main`. Da un checkout aggiornato crea e invia il tag corrispondente:

```sh
git tag v0.9.5
git push origin v0.9.5
```

Sostituisci `0.9.5` con la versione effettiva. Il workflow rifiuta tag diversi dalla versione del TOC, verifica Lua 5.1, esegue i test e genera lo ZIP. Solo dopo il successo pubblica una GitHub prerelease con ZIP allegato e note generate. I normali commit non creano release. Non spostare tag già pubblicati: usa una nuova versione.

Update the TOC version and changelog, push the commit to `main`, then push the matching `vX.Y.Z` tag. The release workflow validates the version, Lua syntax and regression checks, builds the installable ZIP, and publishes a beta prerelease with generated notes. No extra token is required. Ordinary commits only run validation. Use a new version rather than moving published tags.

Conteggio riproducibile dei record e dei campi: `lua5.1 tools/coverage.lua`. Vedi [copertura attuale](docs/quest-coverage.md).

### Pubblicare tramite richiesta nel repository

In alternativa al push manuale del tag, dopo aver aggiornato TOC e changelog modifica `.github/release-request` con `vX.Y.Z` e pubblica su `main`. GitHub Actions verifica la versione, esegue i controlli, crea il tag sul commit della richiesta e pubblica lo ZIP nella stessa esecuzione. I tag creati con `GITHUB_TOKEN` non avviano un secondo workflow. Un tag esistente su un altro commit non viene spostato. Aggiorna il link del README al download della nuova Release.

Alternatively, update `.github/release-request` to the matching `vX.Y.Z` and push to `main`. The workflow validates and tests the requested version, creates its tag and publishes the beta ZIP in the same run. Existing tags on other commits are never moved.
