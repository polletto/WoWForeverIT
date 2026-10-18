# Verifica delle fonti quest — 18 ottobre 2026

Confronto del database quest di WoWForeverIT 0.9.12 con il download pubblico ForeverDB 0.37.0, metadati `2026-10-18.264fccc4`, build `1.60.1.70450`.

| Misura | Snapshot 0.30.0 | Snapshot 0.37.0 |
| --- | ---: | ---: |
| Quest osservate in Forever | 339 | 752 |
| Record nella guida, anche Classic | 1.444 | 1.576 |

413 ID osservati in più; questo non equivale a 413 missioni nuove nel gioco o mancanti nell'addon.

Il confronto considera titoli/obiettivi osservati e descrizioni/obiettivi della guida marcati Forever. Esclude i campi marcati solo Classic. Su 1.211 campi distinti, 1.040 sono riconosciuti dalle impronte correnti. Restano 171 campi su 118 ID: 140 mancanti e 31 con testo non corrispondente all'impronta esistente.

| Campo da verificare | Numero |
| --- | ---: |
| Titolo | 81 |
| Obiettivi | 82 |
| Descrizione | 8 |

Tra i campi confrontati, 666 non erano nello snapshot precedente e due sono cambiati. Il confronto con le impronte non certifica che tutte le stringhe riconosciute siano in italiano o verificate in gioco.

## Casi concreti

- 92481, **A Student of the Arcane**: titolo, descrizione e obiettivo disponibili da verificare/importare.
- 97279: l'obiettivo ora indica sei Abandoned Training Weapons da restituire a Kzan Thornslash nella Tana.
- 62: titolo passato a `Fargodeep MineEx`; suffisso sospetto, non importare automaticamente.
- 30 e 1221: obiettivi lunghi esattamente 300 caratteri e apparentemente troncati; cercare una fonte integrale.
- Alcune descrizioni contengono `adventurer` o `class` al posto di possibili segnaposto del giocatore: controllare il testo originale prima di tradurre.

Nessuna traduzione modificata, nessuno ZIP o rilascio creato da questa verifica. Il file JSON allegato contiene i 171 candidati, gli stati e le segnalazioni. Priorità: quest di classe e zone iniziali nuove, poi varianti degli obiettivi. Non sostituire le traduzioni esistenti quando manca una conferma del testo inglese integrale.

Fonte scaricata: https://foreverdb.net/api/dl/companion
SHA-256: `a575c59cadc2a8f383a3a78e77ca63be6806ba39727739c4a816e6deeb8a970b`.

## Integrazione successiva alla verifica
163 campi integrati su 110 quest, con varianti delle impronte e senza sostituire i testi precedenti. Totale database 2.687 ID. Restano sette campi dubbi e il nome proprio invariato Chakuyak (non contato come traduzione). Inventario e traduzioni in `quest-translations-2026-10-18.json`.
