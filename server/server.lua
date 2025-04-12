local ox_inventory = exports.ox_inventory

local combhook = ox_inventory:registerHook('swapItems', function(payload)
    if payload.fromInventory == payload.source and payload.fromSlot ~= nil and payload.toSlot ~= nil then
        local fromItem = payload.fromSlot.name
        local toItem = payload.toSlot.name
        local combo = Config.Combinations[fromItem] or Config.Combinations[toItem]

        if not combo then return end

        if fromItem == combo.needs or toItem == combo.needs then
            local src = payload.source
            local budItem = Config.Combinations[fromItem] and fromItem or toItem
            local paperItem = Config.Combinations[fromItem] and toItem or fromItem

            local budCount = ox_inventory:GetItem(src, budItem)?.count or 0
            local paperCount = ox_inventory:GetItem(src, paperItem)?.count or 0
            local maxCount = math.min(budCount, paperCount)

            if maxCount <= 0 then return false end

            local amount = lib.callback.await('pk-combine:openDialog', src, maxCount)
            if not amount or amount <= 0 then return false end

            TriggerClientEvent('pk-combine:makeAnim', src, amount)
            Wait(2000)

            if combo.removeItemA then
                ox_inventory:RemoveItem(src, budItem, amount)
            end
            if combo.removeItemB then
                ox_inventory:RemoveItem(src, paperItem, amount)
            end

            for _, v in pairs(combo.result) do
                ox_inventory:AddItem(src, v.name, v.amount * amount)
            end
        end
    end

    return false
end, {})
