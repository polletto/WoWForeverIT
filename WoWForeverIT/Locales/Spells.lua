-- Original Italian translations. Descriptions retain live client numbers.
-- Exact displayed English names only; translations are scoped to spell UI.
WoWForeverIT_AuraBodies={
 ['Arcane Intellect']={{'^Increases Intellect by ([%d%.,]+)%.$','Aumenta l’Intelletto di %s.'}},
 ['Frost Armor']={{'^Increases armor by ([%d%.,]+)%.$','Aumenta l’Armatura di %s.'}},
 ['Power Word: Fortitude']={{'^Increases Stamina by ([%d%.,]+)%.$','Aumenta la Tempra di %s.'}},
 ['Blessing of Might']={{'^Increases melee attack power by ([%d%.,]+)%.$','Aumenta la potenza d’attacco in mischia di %s.'}},
}
WoWForeverIT_Spells = {
 ['Dodge']='Schivata', ['Languages']='Lingue',
 ['Attack']='Attacco', ['Shoot']='Tiro', ['Cannibalize']='Cannibalismo',
 ['Will of the Forsaken']='Volontà dei Reietti', ['Touch of the Grave']='Tocco della Tomba',
 ['Underwater Breathing']='Respirazione Subacquea', ['Armor Proficiency']='Competenza nelle Armature',
 ['Comprehend Scroll']='Comprensione delle Pergamene',
 ['Fireball']='Palla di Fuoco', ['Frostbolt']='Dardo di Gelo',
 ['Arcane Intellect']='Intelletto Arcano', ['Frost Armor']='Armatura Gelida',
 ['Fire Blast']='Detonazione di Fuoco', ['Frost Nova']='Esplosione Gelida',
 ['Arcane Missiles']='Missili Arcani', ['Conjure Water']='Evocazione dell’Acqua',
 ['Conjure Food']='Evocazione del Cibo', ['Polymorph']='Metamorfosi',
 ['Blink']='Traslazione', ['Counterspell']='Controincantesimo',
 ['Arcane Explosion']='Esplosione Arcana', ['Arcane Brilliance']='Splendore Arcano',
 ['Amplify Magic']='Amplificazione della Magia', ['Dampen Magic']='Attenuazione della Magia',
 ['Blizzard']='Tormenta', ['Cone of Cold']='Cono di Freddo',
 ['Evocation']='Evocazione', ['Flamestrike']='Colonna di Fuoco',
 ['Ice Armor']='Armatura di Ghiaccio', ['Ice Barrier']='Barriera di Ghiaccio',
 ['Ice Block']='Blocco di Ghiaccio', ['Frost Ward']='Protezione dal Gelo',
 ['Fire Ward']='Protezione dal Fuoco', ['Mage Armor']='Armatura Magica',
 ['Mana Shield']='Scudo di Mana', ['Slow Fall']='Caduta Lenta',
 ['Remove Lesser Curse']='Rimozione della Maledizione Minore',
 ['Scorch']='Bruciatura', ['Detect Magic']='Individuazione della Magia',
 ['Presence of Mind']='Presenza Mentale', ['Combustion']='Combustione',
 ['Cold Snap']='Prontezza Gelida', ['Arcane Power']='Potere Arcano',
 ['Conjure Mana Agate']='Evocazione dell’Agata di Mana',
 ['Conjure Mana Jade']='Evocazione della Giada di Mana',
 ['Conjure Mana Citrine']='Evocazione del Citrino di Mana',
 ['Conjure Mana Ruby']='Evocazione del Rubino di Mana',
}
-- Source family must match the tooltip title before body rules are considered.
WoWForeverIT_SpellBodies = {
 ['Frost Armor']={
  {'^Increases Armor by ([%d%.,]+)%. If an enemy strikes the caster, they may have their movement slowed by ([%d%.,]+)%% and the time between their attacks increased by ([%d%.,]+)%% for ([%d%.,]+) sec%. Only one type of Armor spell can be active on the Mage at any time%. Lasts ([%d%.,]+) min%.$',
   'Aumenta l’Armatura di %s. I nemici che colpiscono l’incantatore possono subire una riduzione del %s%% della velocità di movimento e un aumento del %s%% del tempo tra gli attacchi per %s s. Il mago può avere attivo un solo incantesimo di armatura alla volta. Dura %s min.'},
  {'^Increases Armor by ([%d%.,]+)%. If an enemy strikes the caster, they may have their movement slowed by ([%d%.,]+)%% and their attacks slowed by ([%d%.,]+)%% for ([%d%.,]+) sec%. Only ([%d]+) type of Armor spell can be active on the Mage at any time%. Lasts ([%d%.,]+) min%.$',
   'Aumenta l’Armatura di %s. I nemici che colpiscono l’incantatore possono subire una riduzione del %s%% della velocità di movimento e del %s%% della velocità d’attacco per %s s. Il mago può avere attivo solo %s incantesimo di armatura alla volta. Dura %s min.'},
 },
 ['Frost Nova']={
  {'^Blasts enemies near the caster for ([%d%.,]+) to ([%d%.,]+) Frost damage and freezes them in place for up to ([%d%.,]+) sec%. Damage caused may interrupt the effect%.$',
   'Infligge da %s a %s danni da gelo ai nemici vicini e li immobilizza per un massimo di %s s. I danni subiti possono interrompere l’effetto.'},
 },
 ['Arcane Missiles']={
  {'^Launches Arcane Missiles at the enemy, causing ([%d%.,]+) Arcane damage each second for ([%d%.,]+) sec%.$',
   'Lancia missili arcani contro il nemico, infliggendo %s danni da arcano ogni secondo per %s s.'},
 },
 ['Conjure Water']={
  {'^Conjures ([%d]+) bottles of fresh water, providing the mage and his allies with something to drink%. Conjured items disappear if logged out for more than ([%d%.,]+) minutes%.$',
   'Crea %s bottiglie d’acqua fresca da bere per il mago e i suoi alleati.\n\nGli oggetti evocati scompaiono dopo una disconnessione superiore a %s minuti.'},
  {'^Conjures ([%d]+) bottles of fresh water, providing the mage and his allies with something to drink%.$',
   'Crea %s bottiglie d’acqua fresca da bere per il mago e i suoi alleati.'},
  {'^Conjured items disappear if logged out for more than ([%d%.,]+) minutes%.$',
   'Gli oggetti evocati scompaiono dopo una disconnessione superiore a %s minuti.'},
  {'^Conjures ([%d]+) bottles of water, providing the mage and his allies with something to drink%. Conjured items disappear if logged out for more than ([%d%.,]+) minutes%.$',
   'Crea %s bottiglie d’acqua da bere per il mago e i suoi alleati. Gli oggetti evocati scompaiono dopo una disconnessione superiore a %s minuti.'},
 },
 ['Conjure Food']={
  {'^Conjures ([%d]+) muffins, providing the mage and his allies with something to eat%. Conjured items disappear if logged out for more than ([%d%.,]+) minutes%.$',
   'Crea %s muffin da mangiare per il mago e i suoi alleati.\n\nGli oggetti evocati scompaiono dopo una disconnessione superiore a %s minuti.'},
  {'^Conjures ([%d]+) muffins, providing the mage and his allies with something to eat%.$',
   'Crea %s muffin da mangiare per il mago e i suoi alleati.'},
  {'^Conjured items disappear if logged out for more than ([%d%.,]+) minutes%.$',
   'Gli oggetti evocati scompaiono dopo una disconnessione superiore a %s minuti.'},
  {'^Conjures ([%d]+) loaves of bread, providing the mage and his allies with something to eat%. Conjured items disappear if logged out for more than ([%d%.,]+) minutes%.$',
   'Crea %s pagnotte da mangiare per il mago e i suoi alleati. Gli oggetti evocati scompaiono dopo una disconnessione superiore a %s minuti.'},
 },
 ['Fireball']={
  {'^Hurls a fiery ball that causes ([%d%.,]+) to ([%d%.,]+) Fire damage and an additional ([%d%.,]+) Fire damage over ([%d%.,]+) sec%.$',
   'Scaglia una palla di fuoco che infligge da %s a %s danni da fuoco e altri %s danni da fuoco in %s s.'},
 },
 ['Frostbolt']={
  {'^Launches a bolt of frost at the enemy, causing ([%d%.,]+) to ([%d%.,]+) Frost damage and slowing movement speed by ([%d%.,]+)%% for ([%d%.,]+) sec%.$',
   'Lancia un dardo di gelo che infligge da %s a %s danni da gelo e riduce la velocità di movimento del %s%% per %s s.'},
 },
 ['Arcane Intellect']={
  {'^Increases the target.s Intellect by ([%d%.,]+) for ([%d%.,]+) hour%.$',
   'Aumenta l’Intelletto del bersaglio di %s per %s ora.'},
  {'^Increases the target.s Intellect by ([%d%.,]+) for ([%d%.,]+) min%.$',
   'Aumenta l’Intelletto del bersaglio di %s per %s min.'},
 },
 ['Fire Blast']={
  {'^Blasts the enemy for ([%d%.,]+) to ([%d%.,]+) Fire damage%.$',
   'Investe il nemico con una detonazione che infligge da %s a %s danni da fuoco.'},
 },
 ['Arcane Explosion']={
  {'^Causes an explosion of arcane magic around the caster, causing ([%d%.,]+) to ([%d%.,]+) Arcane damage to all targets within ([%d%.,]+) yards%.$',
   'Provoca un’esplosione di magia arcana attorno all’incantatore, infliggendo da %s a %s danni da arcano a tutti i bersagli entro %s m.'},
 },
 ['Scorch']={
  {'^Scorches the enemy for ([%d%.,]+) to ([%d%.,]+) Fire damage%.$',
   'Brucia il nemico, infliggendo da %s a %s danni da fuoco.'},
 },
 ['Slow Fall']={
  {'^Slows falling speed for ([%d%.,]+) sec%.$',
   'Riduce la velocità di caduta per %s s.'},
 },
 ['Counterspell']={
  {'^Counters the enemy.s spellcast, preventing any spell from that school of magic from being cast for ([%d%.,]+) sec%. Generates a high amount of threat%.$',
   'Interrompe l’incantesimo del nemico e impedisce il lancio di magie della stessa scuola per %s s. Genera molta minaccia.'},
 },
 ['Remove Lesser Curse']={
  {'^Removes ([%d]+) Curse from a friendly target%.$',
   'Rimuove %s maledizione da un bersaglio amico.'},
 },
 ['Fire Ward']={
  {'^Absorbs ([%d%.,]+) Fire damage%. Lasts ([%d%.,]+) sec%.$',
   'Assorbe %s danni da fuoco. Dura %s s.'},
 },
 ['Frost Ward']={
  {'^Absorbs ([%d%.,]+) Frost damage%. Lasts ([%d%.,]+) sec%.$',
   'Assorbe %s danni da gelo. Dura %s s.'},
 },
}
WoWForeverIT_SpellBodies['Polymorph']={
 {'^Transforms the enemy into a sheep, forcing it to wander around for up to ([%d%.,]+) sec%. While wandering, the sheep cannot attack or cast spells but will regenerate very quickly%. Any damage will transform the target back into its normal form%. Only one target can be polymorphed at a time%. Only works on Beasts, Humanoids and Critters%.$',
  'Trasforma il nemico in una pecora, costringendolo a vagare per un massimo di %s s. Durante questo periodo non può attaccare né lanciare incantesimi, ma si rigenera molto rapidamente. Qualsiasi danno riporta il bersaglio alla sua forma normale. È possibile trasformare un solo bersaglio alla volta. Funziona solo su bestie, umanoidi e animaletti.'},
}
-- Exact Forever tooltip text, scoped to its spell family.
WoWForeverIT_SpellExactBodies = {
 ['Will of the Forsaken']={
  ['Instantly removes all Charm, Fear and Sleep effects.']='Rimuove istantaneamente tutti gli effetti di ammaliamento, paura e sonno.',
 },
 ['Armor Proficiency']={
  ['You are proficient in the use of the following armor types: Cloth']='Sai utilizzare i seguenti tipi di armatura:\nStoffa',
  ['You are proficient in the use of the following armor types:']='Sai utilizzare i seguenti tipi di armatura:',
  ['Cloth']='Stoffa',
 },
 ['Comprehend Scroll']={
  ['Decipher an untranslated scroll.']='Decifra una pergamena non tradotta.',
 },
 ['Dodge']={
  ['Gives a chance to dodge enemy melee attacks.']='Fornisce una probabilità di schivare gli attacchi in mischia dei nemici.',
 },
 ['Shoot']={
  ['Attack with an equipped wand.']='Attacca con la bacchetta equipaggiata.',
 },
 ['Languages']={
  ['You are fluent in the following languages: Orcish Gutterspeak']='Parli fluentemente le seguenti lingue:\nOrchesco\nLingua dei Reietti',
  ['You are fluent in the following languages:']='Parli fluentemente le seguenti lingue:',
  ['Orcish']='Orchesco', ['Gutterspeak']='Lingua dei Reietti',
 },
}
WoWForeverIT_SpellBodies['Touch of the Grave']={
 {'^Your spells and attacks have a ([%d%.,]+)%% chance to drain Health from the target, up to ([%d%.,]+)%% of your maximum Health%.$',
  'Le tue magie e i tuoi attacchi hanno una probabilità del %s%% di sottrarre salute al bersaglio, fino al %s%% della tua salute massima.'},
}
WoWForeverIT_SpellBodies['Cannibalize']={
 {'^When activated, regenerates ([%d%.,]+)%% of total Health and ([%d%.,]+)%% of total Mana every ([%d%.,]+) sec for ([%d%.,]+) sec%. Only works on Humanoid or Undead corpses within ([%d%.,]+) yds%. Any movement, action, or damage taken while Cannibalizing will cancel the effect%.$',
  'Quando attivata, rigenera il %s%% della salute totale e il %s%% del mana totale ogni %s s per %s s. Funziona solo sui cadaveri di umanoidi o non morti entro %s m. Qualsiasi movimento, azione o danno subito durante Cannibalismo interrompe l’effetto.'},
}
WoWForeverIT_SpellBodies['Underwater Breathing']={
 {'^Underwater breath lasts ([%d%.,]+)%% longer than normal%.$',
  'La durata della respirazione sott’acqua aumenta del %s%% rispetto al normale.'},
}

-- Initial vocabulary for the eight other original classes.
-- Warrior
WoWForeverIT_Spells["Heroic Strike"]="Assalto Eroico"
WoWForeverIT_Spells["Battle Stance"]="Postura da Battaglia"
WoWForeverIT_Spells["Battle Shout"]="Urlo di Battaglia"
WoWForeverIT_Spells["Charge"]="Carica"
WoWForeverIT_Spells["Rend"]="Squarcio"
WoWForeverIT_Spells["Thunder Clap"]="Rombo di Tuono"
WoWForeverIT_Spells["Hamstring"]="Azzoppamento"
WoWForeverIT_Spells["Bloodrage"]="Furia del Sangue"
-- Paladin
WoWForeverIT_Spells["Holy Light"]="Luce Sacra"
WoWForeverIT_Spells["Devotion Aura"]="Aura di Devozione"
WoWForeverIT_Spells["Seal of Righteousness"]="Sigillo della Rettitudine"
WoWForeverIT_Spells["Judgement"]="Giudizio"
WoWForeverIT_Spells["Blessing of Might"]="Benedizione della Potenza"
WoWForeverIT_Spells["Divine Protection"]="Protezione Divina"
WoWForeverIT_Spells["Lay on Hands"]="Mano Celestiale"
WoWForeverIT_Spells["Purify"]="Purificazione"
-- Hunter
WoWForeverIT_Spells["Auto Shot"]="Tiro Automatico"
WoWForeverIT_Spells["Raptor Strike"]="Assalto del Raptor"
WoWForeverIT_Spells["Arcane Shot"]="Tiro Arcano"
WoWForeverIT_Spells["Serpent Sting"]="Morso del Serpente"
WoWForeverIT_Spells["Aspect of the Monkey"]="Aspetto della Scimmia"
WoWForeverIT_Spells["Aspect of the Hawk"]="Aspetto del Falco"
WoWForeverIT_Spells["Concussive Shot"]="Tiro Stordente"
WoWForeverIT_Spells["Hunter's Mark"]="Marchio del Cacciatore"
-- Rogue
WoWForeverIT_Spells["Sinister Strike"]="Assalto Funesto"
WoWForeverIT_Spells["Eviscerate"]="Sventramento"
WoWForeverIT_Spells["Stealth"]="Furtività"
WoWForeverIT_Spells["Backstab"]="Pugnalata alle Spalle"
WoWForeverIT_Spells["Gouge"]="Sgorbiatura"
WoWForeverIT_Spells["Pick Pocket"]="Borseggio"
WoWForeverIT_Spells["Evasion"]="Evasione"
WoWForeverIT_Spells["Slice and Dice"]="Fendenti Furiosi"
-- Priest
WoWForeverIT_Spells["Smite"]="Punizione"
WoWForeverIT_Spells["Lesser Heal"]="Cura Minore"
WoWForeverIT_Spells["Power Word: Fortitude"]="Parola del Potere: Fermezza"
WoWForeverIT_Spells["Shadow Word: Pain"]="Parola d’Ombra: Dolore"
WoWForeverIT_Spells["Power Word: Shield"]="Parola del Potere: Scudo"
WoWForeverIT_Spells["Renew"]="Rinnovamento"
WoWForeverIT_Spells["Resurrection"]="Resurrezione"
WoWForeverIT_Spells["Fade"]="Dissolvenza"
-- Shaman
WoWForeverIT_Spells["Lightning Bolt"]="Dardo Fulminante"
WoWForeverIT_Spells["Healing Wave"]="Ondata di Cura"
WoWForeverIT_Spells["Rockbiter Weapon"]="Arma Rocciadura"
WoWForeverIT_Spells["Earth Shock"]="Folgore della Terra"
WoWForeverIT_Spells["Lightning Shield"]="Scudo di Fulmini"
WoWForeverIT_Spells["Stoneskin Totem"]="Totem Pelle di Pietra"
WoWForeverIT_Spells["Flame Shock"]="Folgore del Fuoco"
WoWForeverIT_Spells["Searing Totem"]="Totem Rovente"
-- Warlock
WoWForeverIT_Spells["Shadow Bolt"]="Dardo d’Ombra"
WoWForeverIT_Spells["Demon Skin"]="Pelle Demoniaca"
WoWForeverIT_Spells["Immolate"]="Immolazione"
WoWForeverIT_Spells["Corruption"]="Corruzione"
WoWForeverIT_Spells["Curse of Weakness"]="Maledizione della Debolezza"
WoWForeverIT_Spells["Summon Imp"]="Evocazione dell’Imp"
WoWForeverIT_Spells["Life Tap"]="Conversione Vitale"
WoWForeverIT_Spells["Fear"]="Paura"
-- Druid
WoWForeverIT_Spells["Wrath"]="Ira Silvana"
WoWForeverIT_Spells["Healing Touch"]="Tocco Curativo"
WoWForeverIT_Spells["Mark of the Wild"]="Marchio Selvaggio"
WoWForeverIT_Spells["Moonfire"]="Fuoco Lunare"
WoWForeverIT_Spells["Rejuvenation"]="Rinvigorimento"
WoWForeverIT_Spells["Thorns"]="Spine"
WoWForeverIT_Spells["Entangling Roots"]="Radici Avvolgenti"
WoWForeverIT_Spells["Bear Form"]="Forma d’Orso"
WoWForeverIT_SpellBodies["Holy Light"]=WoWForeverIT_SpellBodies["Holy Light"] or {}
table.insert(WoWForeverIT_SpellBodies["Holy Light"], {"^Heals a friendly target for ([%d%.,]+) to ([%d%.,]+)%.$", "Cura un bersaglio amico di %s–%s punti salute."})
WoWForeverIT_SpellBodies["Lesser Heal"]=WoWForeverIT_SpellBodies["Lesser Heal"] or {}
table.insert(WoWForeverIT_SpellBodies["Lesser Heal"], {"^Heals your target for ([%d%.,]+) to ([%d%.,]+)%.$", "Cura il bersaglio di %s–%s punti salute."})
WoWForeverIT_SpellBodies["Healing Wave"]=WoWForeverIT_SpellBodies["Healing Wave"] or {}
table.insert(WoWForeverIT_SpellBodies["Healing Wave"], {"^Heals a friendly target for ([%d%.,]+) to ([%d%.,]+)%.$", "Cura un bersaglio amico di %s–%s punti salute."})
WoWForeverIT_SpellBodies["Healing Touch"]=WoWForeverIT_SpellBodies["Healing Touch"] or {}
table.insert(WoWForeverIT_SpellBodies["Healing Touch"], {"^Heals a friendly target for ([%d%.,]+) to ([%d%.,]+)%.$", "Cura un bersaglio amico di %s–%s punti salute."})
WoWForeverIT_SpellBodies["Smite"]=WoWForeverIT_SpellBodies["Smite"] or {}
table.insert(WoWForeverIT_SpellBodies["Smite"], {"^Smites an enemy for ([%d%.,]+) to ([%d%.,]+) Holy damage%.$", "Colpisce un nemico infliggendo da %s a %s danni da sacro."})
WoWForeverIT_SpellBodies["Lightning Bolt"]=WoWForeverIT_SpellBodies["Lightning Bolt"] or {}
table.insert(WoWForeverIT_SpellBodies["Lightning Bolt"], {"^Casts a bolt of lightning at the target for ([%d%.,]+) to ([%d%.,]+) Nature damage%.$", "Scaglia un fulmine contro il bersaglio, infliggendo da %s a %s danni da natura."})
WoWForeverIT_SpellBodies["Shadow Bolt"]=WoWForeverIT_SpellBodies["Shadow Bolt"] or {}
table.insert(WoWForeverIT_SpellBodies["Shadow Bolt"], {"^Sends a shadowy bolt at the enemy, causing ([%d%.,]+) to ([%d%.,]+) Shadow damage%.$", "Scaglia un dardo d’ombra contro il nemico, infliggendo da %s a %s danni da ombra."})
WoWForeverIT_SpellBodies["Wrath"]=WoWForeverIT_SpellBodies["Wrath"] or {}
table.insert(WoWForeverIT_SpellBodies["Wrath"], {"^Causes ([%d%.,]+) to ([%d%.,]+) Nature damage to the target%.$", "Infligge da %s a %s danni da natura al bersaglio."})
WoWForeverIT_SpellBodies["Arcane Shot"]=WoWForeverIT_SpellBodies["Arcane Shot"] or {}
table.insert(WoWForeverIT_SpellBodies["Arcane Shot"], {"^An instant shot that causes ([%d%.,]+) Arcane damage%.$", "Un tiro istantaneo che infligge %s danni da arcano."})
WoWForeverIT_SpellBodies["Raptor Strike"]=WoWForeverIT_SpellBodies["Raptor Strike"] or {}
table.insert(WoWForeverIT_SpellBodies["Raptor Strike"], {"^A strong attack that increases melee damage by ([%d%.,]+)%.$", "Un potente attacco che aumenta i danni in mischia di %s."})
WoWForeverIT_SpellBodies["Sinister Strike"]=WoWForeverIT_SpellBodies["Sinister Strike"] or {}
table.insert(WoWForeverIT_SpellBodies["Sinister Strike"], {"^An instant strike that causes ([%d%.,]+) damage in addition to your normal weapon damage%. Awards ([%d]+) combo point%.$", "Un attacco istantaneo che infligge %s danni aggiuntivi rispetto ai normali danni dell’arma. Genera %s punto combo."})
WoWForeverIT_SpellBodies["Heroic Strike"]=WoWForeverIT_SpellBodies["Heroic Strike"] or {}
table.insert(WoWForeverIT_SpellBodies["Heroic Strike"], {"^A strong attack that increases melee damage by ([%d%.,]+) and causes a high amount of threat%.$", "Un potente attacco che aumenta i danni in mischia di %s e genera molta minaccia."})
WoWForeverIT_SpellBodies["Renew"]=WoWForeverIT_SpellBodies["Renew"] or {}
table.insert(WoWForeverIT_SpellBodies["Renew"], {"^Heals the target of ([%d%.,]+) damage over ([%d%.,]+) sec%.$", "Ripristina %s punti salute al bersaglio in %s s."})
WoWForeverIT_SpellBodies["Rejuvenation"]=WoWForeverIT_SpellBodies["Rejuvenation"] or {}
table.insert(WoWForeverIT_SpellBodies["Rejuvenation"], {"^Heals the target for ([%d%.,]+) over ([%d%.,]+) sec%.$", "Ripristina %s punti salute al bersaglio in %s s."})
WoWForeverIT_SpellBodies["Corruption"]=WoWForeverIT_SpellBodies["Corruption"] or {}
table.insert(WoWForeverIT_SpellBodies["Corruption"], {"^Corrupts the target, causing ([%d%.,]+) Shadow damage over ([%d%.,]+) sec%.$", "Corrompe il bersaglio, infliggendo %s danni da ombra in %s s."})
WoWForeverIT_SpellBodies["Shadow Word: Pain"]=WoWForeverIT_SpellBodies["Shadow Word: Pain"] or {}
table.insert(WoWForeverIT_SpellBodies["Shadow Word: Pain"], {"^A word of darkness that causes ([%d%.,]+) Shadow damage over ([%d%.,]+) sec%.$", "Una parola oscura che infligge %s danni da ombra in %s s."})
WoWForeverIT_SpellBodies["Serpent Sting"]=WoWForeverIT_SpellBodies["Serpent Sting"] or {}
table.insert(WoWForeverIT_SpellBodies["Serpent Sting"], {"^Stings the target, causing ([%d%.,]+) Nature damage over ([%d%.,]+) sec%. Only one Sting per Hunter can be active on any one target%.$", "Morde il bersaglio, infliggendo %s danni da natura in %s s. Ogni cacciatore può applicare un solo morso alla volta allo stesso bersaglio."})
WoWForeverIT_SpellBodies["Concussive Shot"]=WoWForeverIT_SpellBodies["Concussive Shot"] or {}
table.insert(WoWForeverIT_SpellBodies["Concussive Shot"], {"^Dazes the target, slowing movement speed by ([%d%.,]+)%% for ([%d%.,]+) sec%.$", "Frastorna il bersaglio, riducendone la velocità di movimento del %s%% per %s s."})
WoWForeverIT_SpellBodies["Aspect of the Monkey"]=WoWForeverIT_SpellBodies["Aspect of the Monkey"] or {}
table.insert(WoWForeverIT_SpellBodies["Aspect of the Monkey"], {"^The hunter takes on the aspects of a monkey, increasing chance to dodge by ([%d%.,]+)%%%. Only one Aspect can be active at a time%.$", "Il cacciatore assume l’aspetto della scimmia, aumentando la probabilità di schivata del %s%%. È possibile avere attivo un solo aspetto alla volta."})
WoWForeverIT_SpellBodies["Blessing of Might"]=WoWForeverIT_SpellBodies["Blessing of Might"] or {}
table.insert(WoWForeverIT_SpellBodies["Blessing of Might"], {"^Places a Blessing on the friendly target, increasing melee attack power by ([%d%.,]+) for ([%d%.,]+) min%. Players may only have one Blessing on them per Paladin at any one time%.$", "Benedice un bersaglio amico, aumentandone la potenza d’attacco in mischia di %s per %s min. Ogni paladino può applicare una sola benedizione alla volta allo stesso giocatore."})
WoWForeverIT_SpellBodies["Thorns"]=WoWForeverIT_SpellBodies["Thorns"] or {}
table.insert(WoWForeverIT_SpellBodies["Thorns"], {"^Thorns sprout from the friendly target causing ([%d%.,]+) Nature damage to attackers when hit%. Lasts ([%d%.,]+) min%.$", "Ricopre di spine un bersaglio amico: gli attaccanti subiscono %s danni da natura quando lo colpiscono. Dura %s min."})
WoWForeverIT_SpellBodies["Moonfire"]=WoWForeverIT_SpellBodies["Moonfire"] or {}
table.insert(WoWForeverIT_SpellBodies["Moonfire"], {"^Burns the enemy for ([%d%.,]+) to ([%d%.,]+) Arcane damage and then an additional ([%d%.,]+) Arcane damage over ([%d%.,]+) sec%.$", "Brucia il nemico, infliggendo da %s a %s danni da arcano e altri %s danni da arcano in %s s."})
WoWForeverIT_SpellBodies["Immolate"]=WoWForeverIT_SpellBodies["Immolate"] or {}
table.insert(WoWForeverIT_SpellBodies["Immolate"], {"^Burns the enemy for ([%d%.,]+) Fire damage and then an additional ([%d%.,]+) Fire damage over ([%d%.,]+) sec%.$", "Brucia il nemico, infliggendo %s danni da fuoco e altri %s danni da fuoco in %s s."})
WoWForeverIT_SpellBodies["Purify"]=WoWForeverIT_SpellBodies["Purify"] or {}
table.insert(WoWForeverIT_SpellBodies["Purify"], {"^Purifies the friendly target, removing ([%d]+) disease effect and ([%d]+) poison effect%.$", "Purifica un bersaglio amico, rimuovendo %s effetto di malattia e %s effetto di veleno."})
WoWForeverIT_SpellExactBodies["Battle Stance"]={["A balanced combat stance."]="Una postura equilibrata per il combattimento."}
WoWForeverIT_SpellExactBodies["Auto Shot"]={["Automatically shoots the target until cancelled."]="Spara automaticamente al bersaglio finché non viene annullato."}
WoWForeverIT_SpellExactBodies["Pick Pocket"]={["Pick the target's pocket."]="Borseggia il bersaglio."}
WoWForeverIT_SpellExactBodies["Summon Imp"]={["Summons an Imp under the command of the Warlock."]="Evoca un imp sotto il controllo dello stregone."}

-- Exact Forever orc and warrior tooltip variants.
WoWForeverIT_Spells["Axe Specialization"]="Specializzazione nelle Asce"
WoWForeverIT_Spells["Blood Fury"]="Furia Sanguinaria"
WoWForeverIT_Spells["Shatter Curse"]="Spezzamaledizioni"
WoWForeverIT_Spells["Hardiness"]="Tenacia"
WoWForeverIT_Spells["Block"]="Blocco"
WoWForeverIT_Spells["Parry"]="Parata"
WoWForeverIT_Spells["Camp Benefits"]="Benefici dell’Accampamento"
WoWForeverIT_SpellBodies["Axe Specialization"]=WoWForeverIT_SpellBodies["Axe Specialization"] or {}
table.insert(WoWForeverIT_SpellBodies["Axe Specialization"],{"^Increases your critical strike chance with all spells and abilities by ([%d%.,]+)%% while you have an axe or a two%-handed axe equipped%.$","Aumenta del %s%% la probabilità di colpo critico di tutte le magie e abilità quando hai equipaggiata un’ascia o un’ascia a due mani."})
WoWForeverIT_SpellBodies["Blood Fury"]=WoWForeverIT_SpellBodies["Blood Fury"] or {}
table.insert(WoWForeverIT_SpellBodies["Blood Fury"],{"^Increases Attack Power and Spell Power by ([%d%.,]+)%% for ([%d%.,]+) sec%.$","Aumenta la potenza d’attacco e la potenza magica del %s%% per %s s."})
WoWForeverIT_SpellBodies["Shatter Curse"]=WoWForeverIT_SpellBodies["Shatter Curse"] or {}
table.insert(WoWForeverIT_SpellBodies["Shatter Curse"],{"^Instantly removes and grants immunity to all Curses and Banes, and reduces all Magical damage taken by ([%d%.,]+)%% for ([%d%.,]+) sec%.$","Rimuove istantaneamente tutte le maledizioni e le sciagure e conferisce immunità a questi effetti. Riduce tutti i danni magici subiti del %s%% per %s s."})
WoWForeverIT_SpellBodies["Hardiness"]=WoWForeverIT_SpellBodies["Hardiness"] or {}
table.insert(WoWForeverIT_SpellBodies["Hardiness"],{"^Duration of Stun effects on you reduced by ([%d%.,]+)%%%.$","Riduce del %s%% la durata degli effetti di stordimento subiti."})
WoWForeverIT_SpellBodies["Thunder Clap"]=WoWForeverIT_SpellBodies["Thunder Clap"] or {}
table.insert(WoWForeverIT_SpellBodies["Thunder Clap"],{"^Blasts nearby enemies, increasing the time between their attacks by ([%d%.,]+)%% for ([%d%.,]+) sec and doing ([%d%.,]+) damage to them%. Will affect up to ([%d]+) targets%.$","Colpisce i nemici vicini, aumentando del %s%% il tempo tra i loro attacchi per %s s e infliggendo %s danni. Colpisce fino a %s bersagli."})
WoWForeverIT_SpellBodies["Charge"]=WoWForeverIT_SpellBodies["Charge"] or {}
table.insert(WoWForeverIT_SpellBodies["Charge"],{"^Charge an enemy, generate ([%d%.,]+) Rage, and Stun it for ([%d%.,]+) sec%. Cannot be used in combat%.$","Carica un nemico, genera %s rabbia e lo stordisce per %s s. Non può essere usata in combattimento."})
WoWForeverIT_SpellBodies["Rend"]=WoWForeverIT_SpellBodies["Rend"] or {}
table.insert(WoWForeverIT_SpellBodies["Rend"],{"^Wounds the target causing them to bleed for ([%d%.,]+) damage over ([%d%.,]+) sec%.$","Ferisce il bersaglio, causando un sanguinamento che infligge %s danni in %s s."})
WoWForeverIT_SpellBodies["Battle Shout"]=WoWForeverIT_SpellBodies["Battle Shout"] or {}
table.insert(WoWForeverIT_SpellBodies["Battle Shout"],{"^The warrior shouts, increasing the melee attack power of all party members within ([%d%.,]+) yards by ([%d%.,]+)%. Lasts ([%d%.,]+) min%.$","Il guerriero lancia un urlo che potenzia i membri del gruppo entro %s m, aumentando la loro potenza d’attacco in mischia di %s. Dura %s min."})
WoWForeverIT_SpellExactBodies["Languages"]["You are fluent in the following languages: Orcish"]="Parli fluentemente le seguenti lingue:\nOrchesco"
WoWForeverIT_SpellExactBodies["Armor Proficiency"]["You are proficient in the use of the following armor types: Cloth Leather Mail"]="Sai utilizzare i seguenti tipi di armatura:\nStoffa\nCuoio\nMaglia"
WoWForeverIT_AuraBodies["Camp Benefits"]={{"^Gained the following camp benefits: Sharpening Wheel: Strength increased by ([%d%.,]+)%.$","Hai ottenuto i seguenti benefici dell’accampamento:\n\nRuota per affilare: Forza aumentata di %s."}}

WoWForeverIT_SpellExactBodies['Block']={
 ['Gives a chance to block enemy melee and ranged attacks.']='Fornisce una probabilità di bloccare gli attacchi in mischia e a distanza dei nemici.',
}
WoWForeverIT_SpellExactBodies['Parry']={
 ['Gives a chance to parry enemy melee attacks.']='Fornisce una probabilità di parare gli attacchi in mischia dei nemici.',
}
-- Forever may expose the camp effect through the Spell tooltip data path.
WoWForeverIT_SpellBodies['Camp Benefits']=WoWForeverIT_AuraBodies['Camp Benefits']
WoWForeverIT_SpellExactBodies['Camp Benefits']={
 ['Gained the following camp benefits:']='Hai ottenuto i seguenti benefici dell’accampamento:',
}
table.insert(WoWForeverIT_SpellBodies['Camp Benefits'],{
 '^Sharpening Wheel: Strength increased by ([%d%.,]+)%.$',
 'Ruota per affilare: Forza aumentata di %s.',
})
