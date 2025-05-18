-- snt-evidencebags / server.lua  – verzia pre qb-inventory 2.x
local QBCore = exports['qb-core']:GetCoreObject()

------------------------------------------------------------
-- Pomocné funkcie
------------------------------------------------------------
local function dbg(...) if Config.Debug then print('[snt-evidencebags]', ...) end end
local function HasJob(p) return p and p.PlayerData and p.PlayerData.job and Config.AllowedJobs[p.PlayerData.job.name] end

-- NOVÉ: otvárame stash priamo exportom qb-inventory
local function OpenBagInventory(src, stashId, label)
    exports['qb-inventory']:OpenInventory(src, stashId, {
        label     = label,
        maxweight = Config.StashWeight,
        slots     = Config.StashSlots,
    })
    TriggerClientEvent('inventory:client:SetCurrentStash', src, stashId)
end
------------------------------------------------------------
-- Vytvorenie evidence bagu
------------------------------------------------------------
RegisterNetEvent('snt-evidencebags:server:createBag', function(record)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    if not HasJob(ply) then TriggerClientEvent('QBCore:Notify', src, 'Not authorised', 'error') return end
    if not record or #record < 1 or #record > 32 then TriggerClientEvent('QBCore:Notify', src, 'Invalid record number', 'error') return end

    local info = { description = ('Evidence Bag #%s'):format(record), record = record, sealed = false }
    if ply.Functions.AddItem(Config.EvidenceBagItem, 1, nil, info) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.EvidenceBagItem], 'add')
        TriggerClientEvent('QBCore:Notify', src, ('Evidence Bag #%s created'):format(record), 'success')
        MySQL.insert(('INSERT IGNORE INTO `%s` (record, stash, creator) VALUES (?,?,?)'):format(Config.ArchiveTable),
                     { record, ('evidencebag_%s'):format(record), ply.PlayerData.citizenid })
        dbg('Created bag', record)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Failed to add item', 'error')
    end
end)
------------------------------------------------------------
-- Použitie bagu (otvorenie stash)
------------------------------------------------------------
QBCore.Functions.CreateUseableItem(Config.EvidenceBagItem, function(src, item)
    local ply = QBCore.Functions.GetPlayer(src)
    if not ply then return end
    local meta   = item and (item.info or item.metadata)
    local record = meta and meta.record
    if not record then TriggerClientEvent('QBCore:Notify', src, 'Bag metadata missing', 'error') return end
    OpenBagInventory(src, ('evidencebag_%s'):format(record), ('Evidence Bag #%s'):format(record))
end)
------------------------------------------------------------
-- /sealbag <record>
------------------------------------------------------------
--QBCore.Commands.Add('sealbag', 'Seal an evidence bag', { { name='record', help='Record number' } }, false,
--    function(src, args)
--        local ply = QBCore.Functions.GetPlayer(src)
--        if not HasJob(ply) then TriggerClientEvent('QBCore:Notify', src, 'Not authorised', 'error') return end
--        local record = args[1]; if not record then TriggerClientEvent('QBCore:Notify', src, 'Usage: /sealbag <record>', 'error') return end
--        -- (Voliteľná kontrola obsahu – len ak export existuje)
--        if exports['qb-inventory'].GetStashItems then
--            local items = exports['qb-inventory']:GetStashItems(('evidencebag_%s'):format(record))
--            if items and #items == 0 then TriggerClientEvent('QBCore:Notify', src, 'Bag is empty', 'error') return end
--        end
--        MySQL.update(('UPDATE `%s` SET sealed=1, sealed_by=?, sealed_at=NOW() WHERE record=?'):format(Config.ArchiveTable),
--                     { ply.PlayerData.citizenid, record })
--        TriggerClientEvent('QBCore:Notify', src, ('Evidence Bag #%s sealed'):format(record), 'success')
--        dbg('Sealed bag', record)
--    end)
