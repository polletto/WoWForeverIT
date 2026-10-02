# Copertura missioni — beta 0.9.6

Conteggio del 2026-10-02, riproducibile con `lua5.1 tools/coverage.lua` dalla radice del repository. Si contano gli ID unici e i campi effettivi dopo la precedenza degli override locali.

| Misura | Totale |
| --- | ---: |
| ID nel database importato ed esteso | 2.464 |
| Override locali | 19 |
| Override già compresi negli ID precedenti | 19 |
| **Missioni uniche nel database** | **2.464** |
| Record con tutti e cinque i campi presenti | 1.586 |
| Record con copertura parziale | 878 |
| Campi testuali presenti | 11.006 |
| Titoli identici all'impronta inglese | 512 |

| Campo presente | Missioni |
| --- | ---: |
| Titolo | 2.464 |
| Descrizione | 2.188 |
| Obiettivi | 2.192 |
| Progresso presso l'NPC | 1.744 |
| Completamento presso l'NPC | 2.418 |

Un record presente non equivale a una traduzione integrale, ufficiale o verificata in gioco. I titoli identici all'inglese possono comprendere nomi propri e titoli ancora da localizzare. Anche un record con cinque campi può contenere nomi inglesi o campi che non combaciano più con la beta. Le quest senza testo di progresso non devono ricevere dialoghi inventati solo per completare il conteggio.

## Primo lotto aggiuntivo da Wowhead Forever

Sei ID assenti dal DB precedente, 26 campi aggiunti. Sono adattamenti concisi italiani originali: preservano incarichi, quantità e condizioni, senza distribuire i testi inglesi integrali. I campi mancanti restano assenti. Fonti e normalizzazione dei nomi giocatore in [Sources-Zephras.txt](../WoWForeverIT/Sources-Zephras.txt).

| ID | Titolo italiano | Campi |
| --- | --- | --- |
| 92840 | Catturare il vento | Titolo, descrizione, obiettivi, progresso, completamento |
| 92834 | Vendicato dieci volte | Titolo, descrizione, obiettivi, progresso, completamento |
| 92860 | Al servizio di Zephras — Alto Ordine | Titolo, descrizione, obiettivi, completamento |
| 92871 | Al servizio di Zephras — Plasmavento | Titolo, descrizione, obiettivi, completamento |
| 93746 | Una risposta decisa | Titolo, descrizione, obiettivi, completamento |
| 93461 | Benvenuto al villaggio di Shen'dar | Titolo, descrizione, obiettivi, completamento |

Le pagine italiane di 92871 e 93746 erano ancora in inglese. Nessuna traduzione ufficiale italiana viene attribuita a questi sei adattamenti. Il testo è applicato solo se l'impronta inglese coincide; sono ammesse esclusivamente varianti di spaziatura dei paragrafi. I sei ID e i loro campi richiedono ancora verifica nel client.

## Prossimi lotti

Confrontare gli ID della zona con quelli già caricati, poi verificare i singoli campi mancanti. Per le quest condivise con Vanilla confrontare anche il testo Forever: la corrispondenza del titolo o dell'ID da sola non basta. Controllare la pagina italiana effettiva, perché la localizzazione dei menu del sito non implica quella del testo della missione. Aggiungere campi con provenienza e impronte, conservando i record già funzionanti e i segnaposto del giocatore.

## Titoli italiani riutilizzati nella 0.9.6

Confrontati 66 titoli del progetto WOW Forver - Italiano con gli ID e le impronte già presenti. Nessun ID nuovo: quattro titoli ancora inglesi sono stati completati senza sostituire i campi già italiani. La copertura passa da 516 a 512 titoli identici all’inglese; gli ID unici restano 2.464.

| ID | Titolo italiano riutilizzato |
| --- | --- |
| 87 | Dentedoro |
| 3904 | Il raccolto di Milly |
| 3905 | Elenco dell'uva |
| 398 | Ricercato: Maggot Eye |

Nomi di NPC mantenuti come nella fonte. Licenza e provenienza: [Sources-Reused.txt](../WoWForeverIT/Sources-Reused.txt). Testi narrativi non importati: la fonte non fornisce il testo inglese completo per verificarne le impronte nel nostro adattatore. Il confronto con QuestieDB non ha trovato un pacchetto itIT per queste quest.
