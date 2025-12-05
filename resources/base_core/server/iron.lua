RegisterServerEvent('iron:collect')
AddEventHandler('iron:collect', function()
    local source = source
    local amount = math.random(Config.IronMine.collectAmount.min, Config.IronMine.collectAmount.max)

    if exports.ox_inventory:AddItem(source, 'iron', amount) then
        print('Player ' .. source .. ' collected ' .. amount .. ' iron')
    else
        lib.notify(source, {
            title = 'Errore',
            description = 'Inventario pieno!',
            type = 'error'
        })
    end
end)
