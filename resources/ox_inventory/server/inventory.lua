RegisterCommand('giveitem', function(source, args, rawCommand)
    if source == 0 then
        return
    end

    if #args < 2 then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Uso: /giveitem [item] [quantita]"}
        })
        return
    end

    local item = args[1]
    local count = tonumber(args[2])

    if not Items[item] then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Item non valido!"}
        })
        return
    end

    if AddItem(source, item, count) then
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Sistema", "Hai ricevuto " .. count .. "x " .. Items[item].label}
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Inventario pieno!"}
        })
    end
end)
