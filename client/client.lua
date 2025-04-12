RegisterNetEvent('pk-combine:makeAnim', function(amount)
    lib.progressCircle({
        duration = 2000,
        label = 'Mixer ' .. amount .. ' stk...',
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            walk = false,
            car = false,
            combat = false,
        },
        anim = {
            dict = 'amb@prop_human_parking_meter@male@base',
            clip = 'base'
        },
    })
end)

lib.callback.register('pk-combine:openDialog', function(max)
    exports.ox_inventory:closeInventory()
    local input = lib.inputDialog('Vælg antal', {
        {type = 'number', label = 'Antal', default = 1, min = 1, max = max},
    })

    local amount = tonumber(input and input[1])
    if not amount or amount < 1 or amount > max then return false end

    return amount
end)