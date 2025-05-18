# snt-evidencebags
Evidence Bag systém pro QBCore s qb-inventory 2.x a ox_lib.

**Autor:** SanTy

---

## Instalace

1. Zkopíruj složku **`snt-evidencebags`** do `resources/[qb]`.
2. Importuj SQL skript **`sql/evidencebags.sql`** do databáze.
3. Do **`qb-core/shared/items.lua`** přidej položku *evidencebag*:

```
  evidencebag = { name = 'evidencebag', label = 'Evidence Bag', weight = 100, type = 'item', image = 'evidencebag.png', unique = true, useable = true, shouldClose = true, description
'Evindece Beg' },
```



Ikonu evidencebag.png vlož do qb-inventory/html/images.

V server.cfg dodrž pořadí zdrojů:
```
ensure ox_lib
ensure qb-core
ensure qb-inventory
ensure snt-evidencebags
```

| Příkaz / Akce      | Popis                                                                                 |
| ------------------ | ------------------------------------------------------------------------------------- |
| `/makebag`         | Otevře ox\_lib dialog; zadej číslo spisu (např. **2025-001**) a obdržíš Evidence Bag. |
| Použití předmětu   | Otevře privátní stash bagu, kam lze ukládat důkazy.                                   |
| `/sealbag <číslo>` | Uzavře bag (zápis do DB; další úpravy nejsou dovoleny).                               |


- Povolené joby: **police, sheriff** (lze měnit v config.lua).
- Debug log vypneš nastavením Config.Debug = false.





# snt-evidencebags EN
Evidence Bag system for QBCore using qb-inventory 2.x and ox_lib.


**Author:** SanTy

---

## Installation

1. Drop the **`snt-evidencebags`** folder into `resources/[qb]`.
2. Import **`sql/evidencebags.sql`** into your database.
3. Add the *evidencebag* item to **`qb-core/shared/items.lua`**:

```
  evidencebag = { name = 'evidencebag', label = 'Evidence Bag', weight = 100, type = 'item', image = 'evidencebag.png', unique = true, useable = true, shouldClose = true, description
'Evindece Beg' },
```

4. Place evidencebag.png inside qb-inventory/html/images.

5. Make sure the start order in server.cfg is:
```
ensure ox_lib
ensure qb-core
ensure qb-inventory
ensure snt-evidencebags
```

| Command / Action    | Description                                                                                     |
| ------------------- | ----------------------------------------------------------------------------------------------- |
| `/makebag`          | Shows an ox\_lib dialog – enter a record number (e.g. **2025-001**) to receive an Evidence Bag. |
| Using the item      | Opens the bag’s private stash where evidence can be stored.                                     |
| `/sealbag <number>` | Seals the bag (writes to DB; further edits are blocked).                                        |

- Allowed jobs: **police, sheriff** (editable in config.lua).
- Disable debug logs by setting Config.Debug = false.
