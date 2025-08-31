local QBCore = exports['qb-core']:GetCoreObject()

-- Buying a casino member item
RegisterNetEvent("casino:server:buyCasinoMember", function()
    local src = source
    local totalCost = 5000 -- Set the price for a casino_member item
    local success = false

    -- Check if the player has enough money
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
            moneyRemoved = exports.ox_inventory:RemoveMoney(src, "bank", totalCost, "casino_member_purchase")
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                moneyRemoved = Player.Functions.RemoveMoney("bank", totalCost, "casino_member_purchase")
            end
        end

        if moneyRemoved then
            -- Add item
            if GetResourceState("ox_inventory") == "started" then
                success = exports.ox_inventory:AddItem(src, "casino_member", 1)
            elseif GetResourceState("qb-inventory") == "started" then
                local ok, result = pcall(function()
                    return exports["qb-inventory"]:AddItem(src, "casino_member", 1)
                end)
                if ok and result then
                    success = true
                else
                    local Player = QBCore.Functions.GetPlayer(src)
                    if Player then
                        success = Player.Functions.AddItem("casino_member", 1)
                    end
                end
            else
                local Player = QBCore.Functions.GetPlayer(src)
                if Player then
                    success = Player.Functions.AddItem("casino_member", 1)
                end
            end

            if success then
                if GetResourceState("qb-inventory") == "started" then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casino_member"], "add", 1)
                end
                TriggerClientEvent('QBCore:Notify', src, "You bought a Casino Membership", "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough space in your inventory", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Failed to remove money", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough money in your bank", "error")
    end
end)

-- Buying a casino VIP item
RegisterNetEvent("casino:server:buyCasinoVIP", function()
    local src = source
    local totalCost = 50000 -- Set the price for a casino_vip item
    local success = false

    -- Check if the player has enough money
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
            moneyRemoved = exports.ox_inventory:RemoveMoney(src, "bank", totalCost, "casino_vip_purchase")
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                moneyRemoved = Player.Functions.RemoveMoney("bank", totalCost, "casino_vip_purchase")
            end
        end

        if moneyRemoved then
            -- Add item
            if GetResourceState("ox_inventory") == "started" then
                success = exports.ox_inventory:AddItem(src, "casino_vip", 1)
            elseif GetResourceState("qb-inventory") == "started" then
                local ok, result = pcall(function()
                    return exports["qb-inventory"]:AddItem(src, "casino_vip", 1)
                end)
                if ok and result then
                    success = true
                else
                    local Player = QBCore.Functions.GetPlayer(src)
                    if Player then
                        success = Player.Functions.AddItem("casino_vip", 1)
                    end
                end
            else
                local Player = QBCore.Functions.GetPlayer(src)
                if Player then
                    success = Player.Functions.AddItem("casino_vip", 1)
                end
            end

            if success then
                if GetResourceState("qb-inventory") == "started" then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casino_vip"], "add", 1)
                end
                TriggerClientEvent('QBCore:Notify', src, "You bought a Casino VIP Membership", "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough space in your inventory", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Failed to remove money", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough money in your bank", "error")
    end
end)
-- You would also create a corresponding client.lua to interact with the NPC

