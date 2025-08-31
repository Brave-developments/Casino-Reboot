
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("insidetrack:server:getbalance", function(source, cb)
    local src = source 
    local Chips = nil
    if GetResourceState("ox_inventory") == "started" then
        Chips = exports.ox_inventory:GetItem(src, "casino_chip", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(src, "casino_chip")
        end)
        if ok and result then
            Chips = result
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                Chips = Player.Functions.GetItemByName("casino_chip")
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Chips = Player.Functions.GetItemByName("casino_chip")
        end
    end
    
    local minAmount = 100
    if Chips ~= nil then 
        if Chips.amount >= minAmount then
            Chips = Chips 
        else
            return TriggerClientEvent('QBCore:client:closeBetsNotEnough', src)
        end
    else
        return TriggerClientEvent('QBCore:client:closeBetsZeroChips', src)
    end
end)

RegisterServerEvent("insidetrack:server:placebet", function(bet)
    local src = source 
    local Chips = nil
    if GetResourceState("ox_inventory") == "started" then
        Chips = exports.ox_inventory:GetItem(src, "casino_chip", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(src, "casino_chip")
        end)
        if ok and result then
            Chips = result
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                Chips = Player.Functions.GetItemByName("casino_chip")
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Chips = Player.Functions.GetItemByName("casino_chip")
        end
    end
    
    if Chips ~= nil then 
        if Chips.amount >= bet then
            local success = false
            if GetResourceState("ox_inventory") == "started" then
                success = exports.ox_inventory:RemoveItem(src, "casino_chip", bet)
            elseif GetResourceState("qb-inventory") == "started" then
                local ok, result = pcall(function()
                    return exports["qb-inventory"]:RemoveItem(src, "casino_chip", bet)
                end)
                if ok and result then
                    success = true
                else
                    local Player = QBCore.Functions.GetPlayer(src)
                    if Player then
                        success = Player.Functions.RemoveItem("casino_chip", bet)
                    end
                end
            else
                local Player = QBCore.Functions.GetPlayer(src)
                if Player then
                    success = Player.Functions.RemoveItem("casino_chip", bet)
                end
            end
            
            if success then
                if GetResourceState("qb-inventory") == "started" then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_chip'], "remove", bet)
                end
                TriggerClientEvent('QBCore:Notify', src, "You placed a "..bet.." casino chips bet")
            end
        else
            return TriggerClientEvent('QBCore:client:closeBetsNotEnough', src)
        end
    else
        return TriggerClientEvent('QBCore:client:closeBetsZeroChips', src)
    end
end) 

RegisterServerEvent("insidetrack:server:winnings", function(amount)
    local src = source
    local success = false
    if GetResourceState("ox_inventory") == "started" then
        success = exports.ox_inventory:AddItem(src, "casino_chip", amount, {["quality"] = 100})
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:AddItem(src, "casino_chip", amount, {["quality"] = 100})
        end)
        if ok and result then
            success = true
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                success = Player.Functions.AddItem('casino_chip', amount, nil, {["quality"] = 100})
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            success = Player.Functions.AddItem('casino_chip', amount, nil, {["quality"] = 100})
        end
    end
    
    if success then
        if GetResourceState("qb-inventory") == "started" then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casino_chip"], "add", amount)
        end
        TriggerClientEvent('QBCore:Notify', src, "You Won "..amount.." casino chips!")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You have to much in your pockets', 'error')
    end
end) 

