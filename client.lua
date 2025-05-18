-- snt-evidencebags / client.lua
-- Autor: SanTy – oprava volania ox_lib:inputDialog

local QBCore = exports['qb-core']:GetCoreObject()

-- /makebag – dialóg na číslo spisu
RegisterCommand(Config.CreateCommand, function()
    local input

    -- 1) export z ox_lib (nové verzie)
    if exports['ox_lib'] and exports['ox_lib'].inputDialog then
        input = exports['ox_lib']:inputDialog('Create Evidence Bag', {
            { type = 'input', label = 'Record Number',
              placeholder = 'e.g. 2025-001', icon = 'hashtag' }
        })
    -- 2) fallback na globálny lib (staršie verzie)
    elseif lib and lib.inputDialog then
        input = lib.inputDialog('Create Evidence Bag', {
            { type = 'input', label = 'Record Number',
              placeholder = 'e.g. 2025-001', icon = 'hashtag' }
        })
    else
        print('OX_lib nemá funkciu inputDialog – aktualizuj ju.')
        return
    end

    -- Ak hráč nič nezadal, skončíme
    if not input or input[1] == '' then return end

    -- Pošleme číslo spisu na server
    TriggerServerEvent('snt-evidencebags:server:createBag', input[1])
end, false)

