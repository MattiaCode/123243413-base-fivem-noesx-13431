# Server FiveM Custom - Base

Server FiveM completamente custom senza dipendenze ESX.

## Caratteristiche

### Sistema di Spawn
- Spawn con ped `mp_m_freemode_01` (maschio) o `mp_f_freemode_01` (femmina)
- Spawn automatico allo spawn point configurato
- Item iniziali automatici per ogni nuovo giocatore

### Item Iniziali
Ogni giocatore riceve automaticamente:
- 1x Pistola MK2 (con 50 munizioni)
- 10x Bende
- 1x Zaino
- 50.000$ in contanti

### Safe Zones
- **Safe Zone Principale**: Spawn point con marker verde visibile
- **Safe Zones Teletrasporto**: Ogni destinazione di teletrasporto ha una mini safe zone

Nelle safe zones:
- Invincibilità completa
- Impossibile sparare o essere colpiti
- Impossibile investire altri giocatori
- Possibilità di spawnare veicoli

### Sistema di Teletrasporto
- Ped interattivo allo spawn point
- Menu ox_lib per scegliere la destinazione
- Destinazioni disponibili: 707, 593, Grove Street, Sandy Shores, Paleto Bay

### Personalizzazione Aspetto
- Sistema fivem-appearance integrato
- Comando: `/appearance` (solo nelle safe zones)
- Nessuna dipendenza da framework esterni

### Sistema Veicoli
- `/moto` - Spawna una BF400 (solo nelle safe zones)
- `/macchina` - Spawna una Adder (solo nelle safe zones)
- `F` - Elimina il veicolo spawnato (quando sei dentro)

### Inventario
- ox_inventory custom senza dipendenze ESX
- `F2` o `/inventory` o `/inv` - Apri inventario
- `/giveitem [item] [quantità]` - Aggiungi item

### Respawn Timer
- Se muori fuori dalla safe zone: respawn automatico dopo 20 secondi
- Countdown visibile sullo schermo

## Installazione

1. Scarica le dipendenze richieste:
   - oxmysql
   - ox_lib
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
- Posizioni di teletrasporto
- Dimensioni safe zones
- Item iniziali
- Timer di respawn

## Comandi

| Comando | Descrizione |
|---------|-------------|
| `/appearance` | Apri menu personalizzazione aspetto |
| `/moto` | Spawna BF400 |
| `/macchina` | Spawna Adder |
| `/inventory` o `/inv` | Apri inventario |
| `/giveitem [item] [quantità]` | Aggiungi item |

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
│   │   └── vehicles.lua   # Sistema veicoli
│   ├── server/
│   │   └── main.lua       # Gestione server e item iniziali
│   └── config.lua         # Configurazione generale
├── fivem-appearance/      # Sistema personalizzazione
└── ox_inventory/          # Inventario custom
```

## Note

- Server completamente standalone, nessuna dipendenza da ESX o altri framework
- Tutte le funzionalità sono custom-made
- Configurabile tramite file config
- Sistema modulare e facilmente estendibile
