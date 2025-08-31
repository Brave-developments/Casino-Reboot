local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("casino:server:buyCasinoChip", function(amount)
    local src = source
    local totalCost = amount
    local success = false

    -- Check if player has at least one 'casino_member' item
    local casinoMembership = nil
    if GetResourceState("ox_inventory") == "started" then
        casinoMembership = exports.ox_inventory:GetItem(src, "casino_member", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(src, "casino_member")
        end)
        if ok and result then
            casinoMembership = result
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                casinoMembership = Player.Functions.GetItemByName("casino_member")
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            casinoMembership = Player.Functions.GetItemByName("casino_member")
        end
    end

    if casinoMembership and casinoMembership.amount > 0 then
        -- Check money
        local playerMoney = 0
        if GetResourceState("ox_inventory") == "started" then
            playerMoney = exports.ox_inventory:GetPlayer(src).money["bank"] or 0
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                playerMoney = Player.Functions.GetMoney("bank")
            end
        end

        if playerMoney >= totalCost then
            -- Remove money
            local moneyRemoved = false
            if GetResourceState("ox_inventory") == "started" then
                moneyRemoved = exports.ox_inventory:RemoveMoney(src, "bank", totalCost, "casino_chip_purchase")
            else
                local Player = QBCore.Functions.GetPlayer(src)
                if Player then
                    moneyRemoved = Player.Functions.RemoveMoney("bank", totalCost, "casino_chip_purchase")
                end
            end

            if moneyRemoved then
                -- Add chips
                if GetResourceState("ox_inventory") == "started" then
                    success = exports.ox_inventory:AddItem(src, "casino_chip", amount)
                elseif GetResourceState("qb-inventory") == "started" then
                    local ok, result = pcall(function()
                        return exports["qb-inventory"]:AddItem(src, "casino_chip", amount)
                    end)
                    if ok and result then
                        success = true
                    else
                        local Player = QBCore.Functions.GetPlayer(src)
                        if Player then
                            success = Player.Functions.AddItem("casino_chip", amount)
                        end
                    end
                else
                    local Player = QBCore.Functions.GetPlayer(src)
                    if Player then
                        success = Player.Functions.AddItem("casino_chip", amount)
                    end
                end

                if success then
                    if GetResourceState("qb-inventory") == "started" then
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casino_chip"], "add", amount)
                    end
                    TriggerClientEvent('QBCore:Notify', src, "You bought " .. amount .. " Casino Chips", "success")
                else
                    TriggerClientEvent('QBCore:Notify', src, "You don't have enough space in your inventory", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Failed to remove money", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Not enough money in your bank", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You need a casino membership to buy Casino Chips", "error")
    end
end)

RegisterNetEvent("casino:server:sellCasinoChip", function(amount)
    local src = source
    local success = false

    -- Check if player has casino chips
    local item = nil
    if GetResourceState("ox_inventory") == "started" then
        item = exports.ox_inventory:GetItem(src, "casino_chip", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(src, "casino_chip")
        end)
        if ok and result then
            item = result
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                item = Player.Functions.GetItemByName("casino_chip")
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            item = Player.Functions.GetItemByName("casino_chip")
        end
    end

    if item and item.amount >= amount then
        -- Remove chips
        local chipsRemoved = false
        if GetResourceState("ox_inventory") == "started" then
            chipsRemoved = exports.ox_inventory:RemoveItem(src, "casino_chip", amount)
        elseif GetResourceState("qb-inventory") == "started" then
            local ok, result = pcall(function()
                return exports["qb-inventory"]:RemoveItem(src, "casino_chip", amount)
            end)
            if ok and result then
                chipsRemoved = true
            else
                local Player = QBCore.Functions.GetPlayer(src)
                if Player then
                    chipsRemoved = Player.Functions.RemoveItem("casino_chip", amount)
                end
            end
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                chipsRemoved = Player.Functions.RemoveItem("casino_chip", amount)
            end
        end

        if chipsRemoved then
            -- Add money
            local moneyAdded = false
            if GetResourceState("ox_inventory") == "started" then
                moneyAdded = exports.ox_inventory:AddMoney(src, "bank", amount, "casino_chip_exchange")
            else
                local Player = QBCore.Functions.GetPlayer(src)
                if Player then
                    moneyAdded = Player.Functions.AddMoney("bank", amount, "casino_chip_exchange")
                end
            end

            if moneyAdded then
                if GetResourceState("qb-inventory") == "started" then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casino_chip"], "remove", amount)
                end
                TriggerClientEvent('QBCore:Notify', src, "You exchanged " .. amount .. " Casino Chips", "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "Failed to add money", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Failed to remove casino chips", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough Casino Chips to exchange", "error")
    end
end)
