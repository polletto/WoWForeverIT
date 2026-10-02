-- Six missing Zephras quests: concise original Italian adaptations.
-- Sources and limitations: Sources-Zephras.txt and docs/quest-coverage.md.
local db = WoWForeverIT_QuestIT.DataIT
-- https://www.wowhead.com/forever/quest=92840
db[92840] = db[92840] or {}
db[92840].title = db[92840].title or {it = "Catturare il vento", enHash = {"5ad6a941"}}
db[92840].objectives = db[92840].objectives or {it = "Porta l'Index Esoteria alle pietre erette del Belvedere nelle alture di Shen'dar. Attivalo e proteggilo mentre raccoglie i dati.", enHash = {"10ac3783"}}
db[92840].text = db[92840].text or {it = "La magia che sostiene l'isola persiste attorno alle pietre erette, luoghi sacri custoditi dai Plasmavento. Ora che sono occupati altrove, possiamo studiarla. Porta questo dispositivo sul posto e difendilo durante la raccolta dei dati. Agisci con discrezione.", enHash = {"1a51e472"}}
db[92840].progress = db[92840].progress or {it = "Trovo poche differenze tra i Plasmavento e gli Al'Aketh, a parte la violenza più esplicita di questi ultimi. La loro fede cieca li rende entrambi pericolosi: per questo la nostra missione è fondamentale.", enHash = {"823d6da8", "28a26848", "a5351b72"}}
db[92840].reward = db[92840].reward or {it = "Non volevo spargimenti di sangue: eri lì per raccogliere informazioni, ma i Plasmavento hanno scelto la violenza. La notizia si è già diffusa. Qui a Valanaar non oseranno reagire, ma non dimenticheranno. Hai aiutato molto l'Alto Ordine, $N: capisco perché Rathiril creda in te.", enHash = {"52fde190", "a168dad0", "8bf5c710"}}
-- https://www.wowhead.com/forever/quest=92834
db[92834] = db[92834] or {}
db[92834].title = db[92834].title or {it = "Vendicato dieci volte", enHash = {"6b2dcc66"}}
db[92834].objectives = db[92834].objectives or {it = "Raccogli 10 Amuleti di Pietra del Vento degli Al'Aketh dai cultisti a nord di Valanaar, nei campi di Gustberry o al Santuario di Akir.", enHash = {"e4333c77"}}
db[92834].text = db[92834].text or {it = "Credevo nel dialogo e ho mandato il mio amico Belathaan Brightwish al Santuario di Akir. Ora è arrivata una scatola con la sua lingua, ricoperta di pigmento argentato. Con questo culto non si può ragionare. Uccidi i cultisti e portami gli amuleti che usano per pregare.", enHash = {"b8bc5819"}}
db[92834].progress = db[92834].progress or {it = "Un capo deve riconoscere i propri errori. I Plasmavento avevano ragione: cercare un accordo con gli Al'Aketh era inutile. La mia scelta è costata la vita a un caro amico e ne porterò il peso per sempre.", enHash = {"48a916a1"}}
db[92834].reward = db[92834].reward or {it = "L'Alto Ordine preferisce evitare conflitti e morti inutili.\n\n<Gli occhi di Elaadrin brillano di energia arcana.>\n\nMa il culto ha scambiato la prudenza per debolezza. Pagherà caro questo errore.", enHash = {"5b3cd272", "5d3637a4", "b8cdcff8"}}
-- https://www.wowhead.com/forever/quest=92860
db[92860] = db[92860] or {}
db[92860].title = db[92860].title or {it = "Al servizio di Zephras", enHash = {"d036a2be"}}
db[92860].objectives = db[92860].objectives or {it = "Riferisci a Valennia Stormfist che l'Alto Ordine sostiene la lotta contro gli Al'Aketh.", enHash = {"e5f02e47"}}
db[92860].text = db[92860].text or {it = "Abbiamo cercato di evitare lo scontro, ma l'ostilità del culto non lascia più scelta. Si parla di grandi movimenti sull'isola: stanno preparando qualcosa di pericoloso. Informa Valennia Stormfist che l'Alto Ordine appoggerà pienamente Valanaar contro gli Al'Aketh.", enHash = {"2a7f9081"}}
db[92860].reward = db[92860].reward or {it = "Mi addolora la morte di Belathaan: era mio cugino, un buon mago e un fedele servitore di Zephras. Lo vendicheremo. Vuoi già aiutarci? Vieni, parliamo della situazione.", enHash = {"c4216e43", "bd576565", "aaa7b78f"}}
-- https://www.wowhead.com/forever/quest=92871
db[92871] = db[92871] or {}
db[92871].title = db[92871].title or {it = "Al servizio di Zephras", enHash = {"d036a2be"}}
db[92871].objectives = db[92871].objectives or {it = "Riferisci a Valennia Stormfist che i Plasmavento sostengono la lotta contro gli Al'Aketh.", enHash = {"83bfeb42"}}
db[92871].text = db[92871].text or {it = "Valennia e i suoi guardiani hanno sempre difeso Zephras. Il culto sta radunando forze sull'isola e sembra preparare qualcosa. Raggiungi Valennia e confermale che i Plasmavento offriranno pieno sostegno a Valanaar contro gli Al'Aketh.", enHash = {"67746342"}}
db[92871].reward = db[92871].reward or {it = "Vuoi metterti subito al lavoro? Vieni, discutiamo di ciò che sta accadendo.", enHash = {"2bc3ea39"}}
-- https://www.wowhead.com/forever/quest=93746
db[93746] = db[93746] or {}
db[93746].title = db[93746].title or {it = "Una risposta decisa", enHash = {"3d4f9a64"}}
db[93746].objectives = db[93746].objectives or {it = "Affronta Belathaan Brightwish lungo la strada per il Santuario di Akir.", enHash = {"535aa980"}}
db[93746].text = db[93746].text or {it = "L'Alto Ordine conosce i limiti imposti dai Plasmavento. Belathaan deve tornare dai suoi con qualche livido e maggiore rispetto per quei confini. È partito verso il Santuario di Akir: trovalo da solo lungo la strada e dagli una lezione.", enHash = {"f19ac3b6"}}
db[93746].reward = db[93746].reward or {it = "Belathaan è morto?!\n\n<Ayessa ascolta il tuo racconto.>\n\nElaadrin lo aveva mandato da solo a trattare la pace con gli Al'Aketh? Sono fanatici assassini! Non è colpa tua, $N: eri nel posto giusto al momento sbagliato. L'arroganza dell'Alto Ordine ha provocato tutto questo.", enHash = {"ee0e4812", "e789375e", "b9b53248"}}
-- https://www.wowhead.com/forever/quest=93461
db[93461] = db[93461] or {}
db[93461].title = db[93461].title or {it = "Benvenuto al villaggio di Shen'dar", enHash = {"eadeb69f"}}
db[93461].objectives = db[93461].objectives or {it = "Parla con Rathiril Sunlance e Coriella Calmbreeze nel villaggio di Shen'dar.", enHash = {"cd3e0635"}}
db[93461].text = db[93461].text or {it = "Hai l'aspetto di qualcuno dell'Alto Ordine: il bagliore negli occhi tradisce le tue origini. Prima di lavorare qui, presentati a Rathiril Sunlance, nella sala principale dietro l'angolo. Poi visita Coriella Calmbreeze: la sua locanda offre alloggio e provviste.", enHash = {"c5b7458d"}}
db[93461].reward = db[93461].reward or {it = "Hai incontrato Rathiril? Bene. Alto Ordine e Plasmavento sono in tensione, ma nel villaggio mantengono rapporti civili. Fuori da qui è un'altra storia. Se cerchi qualcosa da fare, ho alcuni incarichi per te.", enHash = {"6e692305", "f08f7c09", "090b581f"}}
