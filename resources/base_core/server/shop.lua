RegisterServerEvent('base:buyItem')
AddEventHandler('base:buyItem', function(itemName, price)
    local source = source

    local moneyItem = exports.ox_inventory:GetItem(source, 'money')

    if not moneyItem or moneyItem.count < price then
        lib.notify(source, {
            title = 'Errore',
            description = 'Non hai abbastanza soldi!',
            type = 'error'
        })
        return
    end

    if exports.ox_inventory:RemoveItem(source, 'money', price) then
        if exports.ox_inventory:AddItem(source, itemName, 1, {ammo = 9999}) then
            lib.notify(source, {
                title = 'Negozio',
                description = 'Acquisto completato!',
                type = 'success'
            })
        else
            exports.ox_inventory:AddItem(source, 'money', price)
            lib.notify(source, {
                title = 'Errore',
                description = 'Inventario pieno!',
                type = 'error'
            })
        end
    end
end)
