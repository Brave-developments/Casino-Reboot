local QBCore = exports['qb-core']:GetCoreObject()

local quantity = 0
local ItemList = {
    ["casino_chip"] = 1,
}

RegisterNetEvent("ry::server:purchaseMembership", function()
    local src = source
    local MembershipCheck = nil
    if GetResourceState("ox_inventory") == "started" then
        MembershipCheck = exports.ox_inventory:GetItem(src, "casino_members", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(src, "casino_members")
        end)
        if ok and result then
            MembershipCheck = result
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                MembershipCheck = Player.Functions.GetItemByName('casino_members')
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            MembershipCheck = Player.Functions.GetItemByName('casino_members')
        end
    end
    
    if MembershipCheck ~= nil then
        TriggerClientEvent('ry::casinoMembershipMenu', src)
        TriggerClientEvent('QBCore:Notify', src, 'You already have a Membership', 'error')
    else
        local success = false
        if GetResourceState("ox_inventory") == "started" then
            success = exports.ox_inventory:AddItem(src, "casino_members", 1)
        elseif GetResourceState("qb-inventory") == "started" then
            local ok, result = pcall(function()
                return exports["qb-inventory"]:AddItem(src, "casino_members", 1)
            end)
            if ok and result then
                success = true
            else
                local Player = QBCore.Functions.GetPlayer(src)
                if Player then
                    success = Player.Functions.AddItem('casino_members', 1, false, info)
                end
            end
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                success = Player.Functions.AddItem('casino_members', 1, false, info)
            end
        end
        
        if success then
            if GetResourceState("qb-inventory") == "started" then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_members'], "add", 1)
            end
            TriggerClientEvent('ry::casinoMembershipMenu', src)
        end
    end
end)

RegisterNetEvent("ry::server:purchaseVIPMembership", function()
    local src = source
    local VIPMembershipCheck = nil
    if GetResourceState("ox_inventory") == "started" then
        VIPMembershipCheck = exports.ox_inventory:GetItem(src, "casino_vip", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(src, "casino_vip")
        end)
        if ok and result then
            VIPMembershipCheck = result
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                VIPMembershipCheck = Player.Functions.GetItemByName('casino_vip')
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            VIPMembershipCheck = Player.Functions.GetItemByName('casino_vip')
        end
    end
    
    if VIPMembershipCheck ~= nil then
        TriggerClientEvent('ry::casinoMembershipMenu', src)
        TriggerClientEvent('QBCore:Notify', src, 'You already have a Membership', 'error')
    else
        local success = false
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
                    success = Player.Functions.AddItem('casino_vip', 1, false, info)
                end
            end
        else
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                success = Player.Functions.AddItem('casino_vip', 1, false, info)
            end
        end
        
        if success then
            if GetResourceState("qb-inventory") == "started" then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_vip'], "add", 1)
            end
            TriggerClientEvent('ry::casinoMembershipMenu', src)
        end
    end 
end)


QBCore.Functions.CreateCallback('ry::server:HasCasinoMembership', function(source, cb)
    local Item = nil
    if GetResourceState("ox_inventory") == "started" then
        Item = exports.ox_inventory:GetItem(source, "casino_members", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(source, "casino_members")
        end)
        if ok and result then
            Item = result
        else
            local Player = QBCore.Functions.GetPlayer(source)
            if Player then
                Item = Player.Functions.GetItemByName("casino_members")
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Item = Player.Functions.GetItemByName("casino_members")
        end
    end

    if Item ~= nil then 
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('ry::server:HasVIPMembership', function(source, cb)
    local Item = nil
    if GetResourceState("ox_inventory") == "started" then
        Item = exports.ox_inventory:GetItem(source, "casino_vip", nil, true)
    elseif GetResourceState("qb-inventory") == "started" then
        local ok, result = pcall(function()
            return exports["qb-inventory"]:GetItem(source, "casino_vip")
        end)
        if ok and result then
            Item = result
        else
            local Player = QBCore.Functions.GetPlayer(source)
            if Player then
                Item = Player.Functions.GetItemByName("casino_vip")
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Item = Player.Functions.GetItemByName("casino_vip")
        end
    end

    if Item ~= nil then 
        cb(true)
    else
        cb(false)
    end
end)

















