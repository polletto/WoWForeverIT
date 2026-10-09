-- Text families checked against Forever client databases, 2026-10-08.
-- Values always come from the live tooltip, never from a website's rank values.
local function body(name, pattern, translation)
 WoWForeverIT_SpellBodies[name]=WoWForeverIT_SpellBodies[name] or {}
 table.insert(WoWForeverIT_SpellBodies[name],{pattern,translation})
end
local function aura(name, pattern, translation)
 WoWForeverIT_AuraBodies[name]=WoWForeverIT_AuraBodies[name] or {}
 table.insert(WoWForeverIT_AuraBodies[name],{pattern,translation})
end
WoWForeverIT_Spells['Earthbind Totem']='Totem del Vincolo Terrestre'
WoWForeverIT_Spells['Strength of Earth Totem']='Totem della Forza della Terra'
WoWForeverIT_Spells['Ghost Wolf']='Lupo Spettrale'
body('Rockbiter Weapon',"^Imbue the Shaman's weapon, increasing melee attack power by ([%d%.,]+) and allowing melee attacks to cause additional threat when using that weapon%. Lasts for ([%d%.,]+) minutes%.$",'Infondi l’arma dello sciamano, aumentando la potenza d’attacco in mischia di %s e facendo sì che gli attacchi con quell’arma generino minaccia aggiuntiva. Dura %s minuti.')
body('Earth Shock','^Instantly shocks the target with concussive force, causing ([%d%.,]+) to ([%d%.,]+) Nature damage%. It also interrupts spellcasting and prevents any spell in that school from being cast for ([%d%.,]+) sec%. Causes a high amount of threat%.$','Colpisce istantaneamente il bersaglio con una forza dirompente, infliggendo da %s a %s danni da natura. Interrompe il lancio e impedisce di lanciare incantesimi della stessa scuola per %s s. Genera molta minaccia.')
body('Lightning Shield','^The caster is surrounded by ([%d]+) balls of lightning%. When a spell, melee or ranged attack hits the caster, the attacker will be struck for ([%d%.,]+) Nature damage%. This expends one lightning ball%. Only one ball will fire every few seconds%. Lasts ([%d%.,]+) min%. %(([%d%.,]+)s cooldown%)$','Avvolge l’incantatore in %s sfere di fulmini. Quando un incantesimo o un attacco in mischia o a distanza lo colpisce, l’attaccante subisce %s danni da natura e una sfera viene consumata. Può attivarsi una sola sfera ogni pochi secondi. Dura %s min. (Tempo di recupero: %s s)')
body('Stoneskin Totem','^Summons a Stoneskin Totem with ([%d%.,]+) health at the feet of the caster%. The totem protects party members within ([%d%.,]+) yards, reducing Physical damage taken by ([%d%.,]+)%. Lasts ([%d%.,]+) min%.$','Evoca ai piedi dell’incantatore un Totem Pelle di Pietra con %s punti salute. Protegge i membri del gruppo entro %s m, riducendo i danni fisici subiti di %s. Dura %s min.')
body('Flame Shock','^Instantly sears the target with fire, causing ([%d%.,]+) Fire damage immediately and ([%d%.,]+) Fire damage over ([%d%.,]+) sec%.$','Brucia istantaneamente il bersaglio, infliggendo %s danni da fuoco immediati e altri %s danni da fuoco in %s s.')
body('Strength of Earth Totem','^Summons a Strength of Earth Totem with ([%d%.,]+) health at the feet of the caster%. The totem increases the strength of party members within ([%d%.,]+) yards by ([%d%.,]+)%. Lasts ([%d%.,]+) min%.$','Evoca ai piedi dell’incantatore un Totem della Forza della Terra con %s punti salute. I membri del gruppo entro %s m ottengono %s Forza. Dura %s min.')
body('Earthbind Totem','^Summons an Earthbind Totem with ([%d%.,]+) health at the feet of the caster for ([%d%.,]+) sec that slows the movement speed of enemies within ([%d%.,]+) yards%.$','Evoca ai piedi dell’incantatore un Totem del Vincolo Terrestre con %s punti salute per %s s. Rallenta i nemici entro %s m.')
body('Searing Totem','^Summons a Searing Totem with ([%d%.,]+) health at your feet for ([%d%.,]+) sec that repeatedly attacks an enemy within ([%d%.,]+) yards for ([%d%.,]+) to ([%d%.,]+) Fire damage%.$','Evoca ai tuoi piedi un Totem Rovente con %s punti salute per %s s. Attacca ripetutamente un nemico entro %s m, infliggendo da %s a %s danni da fuoco.')
body('Ghost Wolf','^Turns the Shaman into a Ghost Wolf, increasing speed by ([%d%.,]+)%%%. Only useable outdoors%.$','Trasforma lo sciamano in un Lupo Spettrale, aumentando la velocità del %s%%. Utilizzabile solo all’aperto.')
body('Power Word: Shield','^Draws on the soul of the party member to shield them, absorbing ([%d%.,]+) damage%. Lasts ([%d%.,]+) sec%. While the shield holds, spellcasting will not be interrupted by damage%. Once shielded, the target cannot be shielded again for ([%d%.,]+) sec%.$','Attinge all’anima di un membro del gruppo per proteggerlo con uno scudo che assorbe %s danni. Dura %s s. Finché lo scudo regge, i danni non interrompono il lancio degli incantesimi. Dopo aver ricevuto lo scudo, il bersaglio non può riceverne un altro per %s s.')
body('Mark of the Wild',"^Increases the friendly target's armor by ([%d%.,]+) for ([%d%.,]+) hour%.$",'Aumenta l’Armatura del bersaglio amico di %s per %s ora.')
aura('Lightning Shield','^Causes ([%d%.,]+) Nature damage to attacker on hit%.$','Infligge %s danni da natura all’attaccante quando colpisce.')
aura('Flame Shock','^([%d%.,]+) Fire damage every ([%d%.,]+) seconds%.$','Infligge %s danni da fuoco ogni %s s.')
aura('Ghost Wolf','^Increases movement speed by ([%d%.,]+)%%%.$','Aumenta la velocità di movimento del %s%%.')
aura('Power Word: Shield','^Absorbs ([%d%.,]+) damage%.$','Assorbe %s danni.')
aura('Mark of the Wild','^Increases armor by ([%d%.,]+)%.$','Aumenta l’Armatura di %s.')

-- ForeverDB/client variant without the optional cooldown annotation.
body('Lightning Shield','^The caster is surrounded by ([%d]+) balls of lightning%. When a spell, melee or ranged attack hits the caster, the attacker will be struck for ([%d%.,]+) Nature damage%. This expends one lightning ball%. Only one ball will fire every few seconds%. Lasts ([%d%.,]+) min%.$','Avvolge l’incantatore in %s sfere di fulmini. Quando un incantesimo o un attacco in mischia o a distanza lo colpisce, l’attaccante subisce %s danni da natura e una sfera viene consumata. Può attivarsi una sola sfera ogni pochi secondi. Dura %s min.')

-- Names observed in ForeverDB 0.30.0 (2026-10-08.e2503fa5), levels 1-10.
-- Original Italian translations; exact English keys, no tooltip mechanics inferred.
local offlineNames = {
 ["Bane of Agony"]="Flagello dell’Agonia",
 ["Beast Training"]="Addestramento delle Bestie",
 ["Blessing of Protection"]="Benedizione della Protezione",
 ["Call Pet"]="Richiamo del Famiglio",
 ["Chilled"]="Rallentamento Gelido",
 ["Clearcasting"]="Lancio Gratuito",
 ["Confounding Flash"]="Lampo Disorientante",
 ["Create Healthstone"]="Creazione della Pietra della Salute",
 ["Defensive Stance"]="Postura Difensiva",
 ["Demoralizing Roar"]="Ruggito Demoralizzante",
 ["Desperate Prayer"]="Preghiera Disperata",
 ["Dismiss Pet"]="Congedo del Famiglio",
 ["Divine Grace"]="Grazia Divina",
 ["Drain Soul"]="Risucchio dell’Anima",
 ["Feed Pet"]="Nutrimento del Famiglio",
 ["Flametongue Weapon"]="Arma della Lingua di Fuoco",
 ["Growl"]="Ringhio",
 ["Hammer of Justice"]="Martello della Giustizia",
 ["Hex of Weakness"]="Maleficio della Debolezza",
 ["Holy Strike"]="Colpo Sacro",
 ["Improved Challenging Shout"]="Urlo di Sfida Migliorato",
 ["Improved Pummel"]="Pugno Migliorato",
 ["Maul"]="Mazzata",
 ["Mind Blast"]="Detonazione Mentale",
 ["Nature's Grasp"]="Presa della Natura",
 ["Revive Pet"]="Rianimazione del Famiglio",
 ["Sap"]="Tramortimento",
 ["Seal of Fury"]="Sigillo della Furia",
 ["Seal of the Crusader"]="Sigillo del Crociato",
 ["Sprint"]="Scatto",
 ["Starshards"]="Schegge Stellari",
 ["Stoneclaw Totem"]="Totem della Pietra Artigliata",
 ["Summon Voidwalker"]="Evocazione del Camminatore del Vuoto",
 ["Sunder Armor"]="Frantumazione dell’Armatura",
 ["Tame Beast"]="Addomesticamento delle Bestie",
 ["Taunt"]="Provocazione",
 ["Teleport: Moonglade"]="Teletrasporto: Radaluna",
 ["Touch of Weakness"]="Tocco della Debolezza",
 ["Track Beasts"]="Individuazione delle Bestie",
 ["Track Humanoids"]="Individuazione degli Umanoidi",
}
for en,it in pairs(offlineNames) do
 WoWForeverIT_Spells[en]=WoWForeverIT_Spells[en] or it
end

-- Additional exact names in the same offline inventory, levels 11-30.
local namesThrough30 = {
 ["Abolish Poison"]="Abolizione del Veleno",
 ["Abolish Poison Effect"]="Effetto di Abolizione del Veleno",
 ["Aimed Shot"]="Tiro Mirato",
 ["Ambush"]="Imboscata",
 ["Ancestral Spirit"]="Spirito Ancestrale",
 ["Aquatic Form"]="Forma Acquatica",
 ["Aspect of the Beast"]="Aspetto della Bestia",
 ["Aspect of the Cheetah"]="Aspetto del Ghepardo",
 ["Astral Recall"]="Richiamo Astrale",
 ["Banish"]="Esilio",
 ["Bash"]="Stordimento",
 ["Beast Lore"]="Conoscenza delle Bestie",
 ["Berserker Rage"]="Furia del Berserker",
 ["Berserker Stance"]="Postura del Berserker",
 ["Blessing of Freedom"]="Benedizione della Libertà",
 ["Blessing of Kings"]="Benedizione dei Re",
 ["Blessing of Salvation"]="Benedizione della Salvezza",
 ["Blessing of Wisdom"]="Benedizione della Saggezza",
 ["Call of the Ancestors"]="Richiamo degli Antenati",
 ["Call of the Elements"]="Richiamo degli Elementi",
 ["Cat Form"]="Forma Felina",
 ["Challenging Roar"]="Ruggito di Sfida",
 ["Challenging Shout"]="Urlo di Sfida",
 ["Chastise"]="Castigo",
 ["Cheap Shot"]="Colpo Basso",
 ["Claw"]="Artiglio",
 ["Cleave"]="Fendente",
 ["Concentration Aura"]="Aura di Concentrazione",
 ["Consecration"]="Consacrazione",
 ["Contingency Plan"]="Piano di Emergenza",
 ["Coup de Grace"]="Colpo di Grazia",
 ["Cower"]="Acquattamento",
 ["Create Firestone"]="Creazione della Pietra del Fuoco",
 ["Create Soulstone"]="Creazione della Pietra dell’Anima",
 ["Cure Disease"]="Cura delle Malattie",
 ["Cure Poison"]="Cura del Veleno",
 ["Curse of Recklessness"]="Maledizione della Temerarietà",
 ["Curse of Tongues"]="Maledizione delle Lingue",
 ["Curse of the Elements"]="Maledizione degli Elementi",
 ["Dark Sacrifice"]="Sacrificio Oscuro",
 ["Dash"]="Scatto Felino",
 ["Demon Armor"]="Armatura Demoniaca",
 ["Demoralizing Shout"]="Urlo Demoralizzante",
 ["Detect Invisibility"]="Individuazione dell’Invisibilità",
 ["Detect Traps"]="Individuazione delle Trappole",
 ["Devouring Plague"]="Piaga Divorante",
 ["Disarm"]="Disarmo",
 ["Disarm Trap"]="Disinnesco delle Trappole",
 ["Disengage"]="Disimpegno",
 ["Dispel Magic"]="Dissoluzione Magica",
 ["Distract"]="Distrazione",
 ["Distracting Shot"]="Tiro Distraente",
 ["Divine Intervention"]="Intervento Divino",
 ["Divine Spirit"]="Spirito Divino",
 ["Drain Life"]="Risucchio di Vita",
 ["Drain Mana"]="Risucchio di Mana",
 ["Eagle Eye"]="Occhio dell’Aquila",
 ["Elune's Grace"]="Grazia di Elune",
 ["Enrage"]="Furia",
 ["Execute"]="Esecuzione",
 ["Exorcism"]="Esorcismo",
 ["Expose Armor"]="Esposizione dell’Armatura",
 ["Eye of Kilrogg"]="Occhio di Kilrogg",
 ["Eyes of the Beast"]="Occhi della Bestia",
 ["Faerie Fire"]="Fuoco Fatato",
 ["Far Sight"]="Vista Lontana",
 ["Fear Ward"]="Protezione dalla Paura",
 ["Feedback"]="Contraccolpo",
 ["Feign Death"]="Finta Morte",
 ["Feint"]="Finta",
 ["Fire Resistance Totem"]="Totem della Resistenza al Fuoco",
 ["Flametongue Totem"]="Totem della Lingua di Fuoco",
 ["Flash Heal"]="Cura Rapida",
 ["Flash of Light"]="Lampo di Luce",
 ["Freezing Trap"]="Trappola Congelante",
 ["Frost Resistance Totem"]="Totem della Resistenza al Gelo",
 ["Frost Shock"]="Folgore del Gelo",
 ["Frost Trap"]="Trappola di Gelo",
 ["Frostbrand Weapon"]="Arma del Marchio del Gelo",
 ["Garrote"]="Garrota",
 ["Grounding Totem"]="Totem del Radicamento",
 ["Heal"]="Cura",
 ["Healing Stream Totem"]="Totem del Flusso Vitale",
 ["Health Funnel"]="Trasfusione Vitale",
 ["Hellfire"]="Fuoco Infernale",
 ["Hibernate"]="Ibernazione",
 ["Holy Fire"]="Fuoco Sacro",
 ["Immolation Trap"]="Trappola Incendiaria",
 ["Immolation Trap Effect"]="Effetto della Trappola Incendiaria",
 ["Inner Fire"]="Fuoco Interiore",
 ["Intercept"]="Intercettazione",
 ["Intimidating Shout"]="Urlo Intimidatorio",
 ["Kick"]="Calcio",
 ["Kidney Shot"]="Colpo ai Reni",
 ["Lesser Healing Wave"]="Ondata di Cura Inferiore",
 ["Magma Totem"]="Totem del Magma",
 ["Mana Burn"]="Combustione del Mana",
 ["Mana Spring Totem"]="Totem della Fonte di Mana",
 ["Mend Pet"]="Cura del Famiglio",
 ["Mind Control"]="Controllo Mentale",
 ["Mind Soothe"]="Pacificazione Mentale",
 ["Mind Vision"]="Visione Mentale",
 ["Mocking Blow"]="Colpo Beffardo",
 ["Mongoose Bite"]="Morso della Mangusta",
 ["Multi-Shot"]="Tiro Multiplo",
 ["Nature Resistance Totem"]="Totem della Resistenza alla Natura",
 ["Omen of Clarity"]="Presagio di Chiarezza",
 ["Overpower"]="Sopraffazione",
 ["Poison Cleansing Totem"]="Totem della Purificazione dal Veleno",
 ["Prayer of Healing"]="Preghiera di Cura",
 ["Prowl"]="Agguato",
 ["Psychic Scream"]="Urlo Psichico",
 ["Purge"]="Purificazione",
 ["Rain of Fire"]="Pioggia di Fuoco",
 ["Rake"]="Graffio",
 ["Rapid Fire"]="Fuoco Rapido",
 ["Rebirth"]="Rinascita",
 ["Redemption"]="Redenzione",
 ["Regrowth"]="Ricrescita",
 ["Reincarnation"]="Reincarnazione",
 ["Remove Curse"]="Rimozione delle Maledizioni",
 ["Retaliation"]="Ritorsione",
 ["Retribution Aura"]="Aura di Castigo",
 ["Revenge"]="Vendetta",
 ["Revive"]="Rianimazione",
 ["Righteous Fury"]="Furia Giusta",
 ["Rip"]="Squarcio",
 ["Ritual of Summoning"]="Rituale di Evocazione",
 ["Rupture"]="Lacerazione",
 ["Scare Beast"]="Spavento delle Bestie",
 ["Scorpid Sting"]="Puntura dello Scorpide",
 ["Seal of Justice"]="Sigillo della Giustizia",
 ["Seal of Light"]="Sigillo della Luce",
 ["Searing Pain"]="Dolore Bruciante",
 ["Sense Demons"]="Percezione dei Demoni",
 ["Sense Undead"]="Percezione dei Non Morti",
 ["Shackle Undead"]="Incatenamento dei Non Morti",
 ["Shadow Protection"]="Protezione dall’Ombra",
 ["Shadow Resistance Aura"]="Aura di Resistenza all’Ombra",
 ["Shadowguard"]="Guardia d’Ombra",
 ["Shield Bash"]="Colpo di Scudo",
 ["Shield Block"]="Blocco con lo Scudo",
 ["Shield Wall"]="Muro di Scudi",
 ["Shred"]="Artigliata",
 ["Slam"]="Contusione",
 ["Soothe Animal"]="Pacificazione degli Animali",
 ["Starfire"]="Fuoco Stellare",
 ["Subjugate Demon"]="Soggiogamento dei Demoni",
 ["Summon Felhunter"]="Evocazione del Vilsegugio",
 ["Summon Incubus"]="Evocazione dell’Incubo",
 ["Summon Succubus"]="Evocazione della Succube",
 ["Swipe"]="Spazzata",
 ["Tactical Mastery"]="Maestria Tattica",
 ["Teleport: Darnassus"]="Teletrasporto: Darnassus",
 ["Teleport: Ironforge"]="Teletrasporto: Forgiardente",
 ["Teleport: Orgrimmar"]="Teletrasporto: Orgrimmar",
 ["Teleport: Stormwind"]="Teletrasporto: Roccavento",
 ["Teleport: Thunder Bluff"]="Teletrasporto: Picco del Tuono",
 ["Teleport: Undercity"]="Teletrasporto: Sepulcra",
 ["Totemic Projection"]="Proiezione Totemica",
 ["Totemic Recall"]="Richiamo Totemico",
 ["Track Elementals"]="Individuazione degli Elementali",
 ["Track Hidden"]="Individuazione dei Nemici Nascosti",
 ["Track Undead"]="Individuazione dei Non Morti",
 ["Tranquility"]="Tranquillità",
 ["Travel Form"]="Forma Celere",
 ["Tremor Totem"]="Totem del Tremore",
 ["Turn Undead"]="Repulsione dei Non Morti",
 ["Unending Breath"]="Respiro Infinito",
 ["Vanish"]="Sparizione",
 ["Water Breathing"]="Respirazione Acquatica",
 ["Water Walking"]="Cammino sull’Acqua",
 ["Windfury Weapon"]="Arma della Furia del Vento",
 ["Wing Clip"]="Tarpa Ali",
}
for en,it in pairs(namesThrough30) do WoWForeverIT_Spells[en]=WoWForeverIT_Spells[en] or it end

-- Additional initial spell families verified against Wowhead Forever, 2026-10-08.
body('Gouge','^Causes ([%d%.,]+) damage, stops your attack, and incapacitates the target for ([%d%.,]+) sec%. The target must be facing you%. Any damage taken will break the effect%. Awards ([%d%.,]+) combo point%.$','Infligge %s danni, interrompe il tuo attacco e incapacita il bersaglio per %s s. Il bersaglio deve essere rivolto verso di te. Qualsiasi danno subito interrompe l’effetto. Genera %s punto combo.')
body('Blessing of Might','^Places a Blessing on the friendly target, increasing melee attack power by ([%d%.,]+) for ([%d%.,]+) hour%. Players may only have one Blessing on them per Paladin at any one time%.$','Benedice un bersaglio amico, aumentandone la potenza d’attacco in mischia di %s per %s ora. Ogni paladino può applicare una sola benedizione alla volta allo stesso giocatore.')
aura('Gouge','^Incapacitated%.$','Incapacitato.')
aura('Serpent Sting','^Causes ([%d%.,]+) Nature damage every ([%d%.,]+) sec%.$','Infligge %s danni da natura ogni %s s.')

-- Exact racial ability text captured in test20 screenshots.
WoWForeverIT_Spells['Skysight']='Vista del Cielo'
WoWForeverIT_Spells['Walk on Air']='Cammino nell’Aria'
body('Skysight','^Attempt to draw power from a convergence of elements and receive its blessing, increasing your movement and mounted movement speeds by ([%d%.,]+)%%%. Lasts ([%d%.,]+) sec if no elemental convergence is nearby, and ([%d%.,]+) min if one is found%.$','Tenta di attingere potere da una convergenza degli elementi e riceverne la benedizione, aumentando la velocità di movimento a piedi e in sella del %s%%. Dura %s s se non ci sono convergenze elementali nelle vicinanze, oppure %s min se ne viene trovata una.')
body('Walk on Air','^Glide downward through the air for ([%d%.,]+) sec while controlling your direction of travel%.$','Plana nell’aria per %s s, controllando la direzione del movimento.')
