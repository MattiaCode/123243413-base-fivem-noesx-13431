lib.callback.register('trader:getIronAmount', function(source)
    local ironItem = exports.ox_inventory:GetItem(source, 'iron')

    if ironItem then
        return ironItem.count
    end

    return 0
end)

RegisterServerEvent('trader:buyItem')
AddEventHandler('trader:buyItem', function(itemName, ironCost, count)
    local source = source

    local ironItem = exports.ox_inventory:GetItem(source, 'iron')

    if not ironItem or ironItem.count < ironCost then
        lib.notify(source, {
            title = 'Errore',
            description = 'Non hai abbastanza ferro!',
            type = 'error'
        })
        return
    end

    if exports.ox_inventory:RemoveItem(source, 'iron', ironCost) then
        if itemName == 'pistol_mk2' or itemName == 'smg' or itemName == 'rifle' then
            if exports.ox_inventory:AddItem(source, itemName, count, {ammo = 9999}) then
                lib.notify(source, {
                    title = 'Trader',
                    description = 'Scambio completato!',
                    type = 'success'
                })
            else
                exports.ox_inventory:AddItem(source, 'iron', ironCost)
                lib.notify(source, {
                    title = 'Errore',
                    description = 'Inventario pieno!',
                    type = 'error'
                })
            end
        else
            if exports.ox_inventory:AddItem(source, itemName, count) then
                lib.notify(source, {
                    title = 'Trader',
                    description = 'Scambio completato!',
                    type = 'success'
                })
            else
                exports.ox_inventory:AddItem(source, 'iron', ironCost)
                lib.notify(source, {
                    title = 'Errore',
                    description = 'Inventario pieno!',
                    type = 'error'
                })
            end
        end
    end
end)
