# Server FiveM Custom - Base

Server FiveM completamente custom senza dipendenze ESX.

## Caratteristiche

### Sistema di Spawn
- Spawn con ped `mp_m_freemode_01` (maschio) o `mp_f_freemode_01` (femmina)
- Spawn automatico allo spawn point configurato
- Item iniziali automatici per ogni nuovo giocatore

### Item Iniziali
Ogni giocatore riceve automaticamente:
- 1x Pistola MK2 (con munizioni infinite)
- 10x Bende
- 1x Zaino
- 50.000$ in contanti

### Sistema Armi
- **Munizioni Infinite**: Tutte le armi hanno munizioni infinite
- **Nessun Rinculo**: Tutte le armi non hanno rinculo
- Non è necessario ricaricare o cercare munizioni
- Esperienza di tiro ottimizzata per PVP

### Sistema Salute
- **Nessuna Fame/Sete**: Non è necessario mangiare o bere
- Armatura rigenerata automaticamente al 100%
- Focus sul combattimento senza bisogni fisiologici

### Safe Zones
- **Safe Zone Principale**: Spawn point con marker verde visibile (30m raggio)
- **Safe Zones Teletrasporto**: Ogni destinazione safe ha una mini safe zone (25m raggio)

Nelle safe zones:
- Invincibilità completa
- Impossibile sparare o essere colpiti
- Impossibile investire altri giocatori
- Possibilità di spawnare veicoli

### Zone Rosse (PVP)
- Zone PVP con polyzone
- Marker rosso visibile per identificare le zone
- Sistema di drop loot alla morte:
  - Il cadavere non è visibile
  - Appare un borsone con il loot del giocatore
  - Altri giocatori possono perquisire il borsone premendo E
  - Non si può rubare lo zaino e il suo contenuto
  - Solo gli item fuori dallo zaino sono rubabili
  - Il borsone scompare dopo 5 minuti

Destinazioni nel menu teletrasporto:
- 🟢 Zone Sicure: 707, 593, Grove Street, Sandy Shores, Paleto Bay
- 🔴 Zone PVP: Zona PVP Nord, Zona PVP Sud, Arena di Combattimento

### Sistema di Teletrasporto
- Ped interattivo allo spawn point
- Menu ox_lib per scegliere la destinazione
- Zone sicure e zone rosse disponibili
- Icone colorate per identificare il tipo di zona

### Personalizzazione Aspetto
- Sistema fivem-appearance integrato
- Comando: `/appearance` (solo nelle safe zones)
- Nessuna dipendenza da framework esterni

### Sistema Veicoli
- `/moto` - Spawna una BF400 (solo nelle safe zones)
- `/macchina` - Spawna una Adder (solo nelle safe zones)
- `F` - Elimina il veicolo spawnato (quando sei dentro)

### Shop System
- Ped shop allo spawn point
- Acquista armi, cibo, e altri oggetti
- Sistema di pagamento con denaro contante

Item disponibili:
- Pistola MK2: $5.000
- SMG: $8.000
- Fucile: $12.000
- Benda: $100
- Acqua: $50
- Pane: $50
- Telefono: $500
- Zaino: $1.000

### Storage System
- Ped storage allo spawn point
- Visualizza il tuo inventario
- Gestisci i tuoi oggetti

### Sistema Ferro e Trader
- **Miniera di Ferro al 707**: Blip visibile sulla mappa
- Premi E per raccogliere ferro (1-3 unità ogni raccolta)
- Tempo raccolta: 5 secondi con animazione
- Cooldown: 10 secondi tra una raccolta e l'altra

**Ped Trader allo Spawn**:
- Scambia ferro con oggetti e denaro
- Menu ox_lib per visualizzare scambi disponibili
- Mostra quantità di ferro disponibile

Item scambiabili con ferro:
- Pistola MK2: 50 Ferro
- SMG: 80 Ferro
- Fucile: 120 Ferro
- Bende (x10): 5 Ferro
- Acqua (x5): 2 Ferro
- Pane (x5): 2 Ferro
- Telefono: 10 Ferro
- Denaro (10K): 20 Ferro

### Sistema Radio
- `/radiof [frequenza]` - Entra in una frequenza radio
- `/radiooff` - Esci dalla frequenza radio
- `/radioanim` - Cambia animazione radio

Animazioni disponibili:
1. Animazione Spalla
2. Animazione Petto
3. Animazione Orecchio

### Inventario
- ox_inventory custom senza dipendenze ESX
- `F2` o `/inventory` o `/inv` - Apri inventario
- `/giveitem [item] [quantità]` - Aggiungi item (admin)

### Respawn Timer
- Se muori fuori dalla safe zone: respawn automatico dopo 20 secondi
- Countdown visibile sullo schermo

## Installazione

1. Scarica le dipendenze richieste:
   - oxmysql
   - ox_lib
   - pma-voice
   - Risorse base FiveM (mapmanager, chat, spawnmanager, sessionmanager, basic-gamemode, hardcap, rconlog)

2. Configura il database MySQL nel `server.cfg`:
   ```cfg
   set mysql_connection_string "mysql://root:password@localhost/fivem?charset=utf8mb4"
   ```

3. Posiziona le risorse custom:
   - `resources/base_loading`
   - `resources/base_core`
   - `resources/fivem-appearance`
   - `resources/ox_inventory`

4. Avvia il server con `server.cfg`

## Configurazione

Modifica `resources/base_core/config.lua` per personalizzare:
- Punto di spawn
- Posizioni di teletrasporto (safe zones)
- Zone rosse (PVP zones) con polyzone
- Dimensioni safe zones
- Item iniziali
- Timer di respawn
- Item nel shop e prezzi
- Animazioni radio

## Comandi

| Comando | Descrizione |
|---------|-------------|
| `/appearance` | Apri menu personalizzazione aspetto (solo safe zones) |
| `/moto` | Spawna BF400 (solo safe zones) |
| `/macchina` | Spawna Adder (solo safe zones) |
| `/inventory` o `/inv` o `F2` | Apri inventario |
| `/giveitem [item] [quantità]` | Aggiungi item (admin) |
| `/radiof [frequenza]` | Entra in frequenza radio |
| `/radiooff` | Esci dalla radio |
| `/radioanim` | Cambia animazione radio |

## Struttura Risorse

```
resources/
├── base_loading/          # Loading screen
├── base_core/             # Sistema core
│   ├── client/
│   │   ├── main.lua       # Gestione spawn e funzioni base
│   │   ├── spawn.lua      # Sistema respawn
│   │   ├── safezone.lua   # Gestione safe zones
│   │   ├── teleport.lua   # Sistema teletrasporto con ped
│   │   ├── vehicles.lua   # Sistema veicoli
│   │   ├── weapons.lua    # Munizioni infinite
│   │   ├── redzones.lua   # Zone rosse PVP con polyzone
│   │   ├── deathbag.lua   # Sistema borsone drop loot
│   │   ├── shop.lua       # Sistema shop
│   │   ├── storage.lua    # Sistema storage
│   │   └── radio.lua      # Sistema radio
│   ├── server/
│   │   ├── main.lua       # Gestione server e item iniziali
│   │   ├── deathbag.lua   # Gestione server borsoni
│   │   └── shop.lua       # Gestione acquisti
│   └── config.lua         # Configurazione generale
├── fivem-appearance/      # Sistema personalizzazione
└── ox_inventory/          # Inventario custom
```

## Interazioni

### Allo Spawn
- **Ped Teletrasporto**: Premi E per aprire menu destinazioni
- **Ped Shop**: Premi E per aprire il negozio (denaro)
- **Ped Storage**: Premi E per visualizzare inventario
- **Ped Trader**: Premi E per scambiare ferro

### Zone Rosse
- Entrata: Notifica "Sei entrato in una zona PVP!"
- Marker rosso visibile
- Drop loot alla morte
- Perquisizione borsone con E

### In Veicolo
- Premi F per eliminare il veicolo spawnato

### Alla Miniera (707)
- Blip visibile sulla mappa
- Premi E per raccogliere ferro
- Animazione di raccolta (martellamento)
- Attendi cooldown tra raccolte

## Note

- Server completamente standalone, nessuna dipendenza da ESX o altri framework
- Tutte le funzionalità sono custom-made
- Configurabile tramite file config
- Sistema modulare e facilmente estendibile
- Zone PVP con polyzone per definire aree complesse
- Sistema radio integrato con pma-voice
- Drop loot realistico con protezione zaino
