local QBCore = exports['qb-core']:GetCoreObject()
local busy = {}
local function reply(success, message) return { success = success, message = message } end
local function countItem(src, player, item)
    if Config.UseOxInventory then return exports.ox_inventory:GetItemCount(src, item) or 0 end
    local entry = player.Functions.GetItemByName(item)
    return entry and entry.amount or 0
end
local function addItem(src, player, item, amount)
    if Config.UseOxInventory then return exports.ox_inventory:AddItem(src, item, amount) end
    return player.Functions.AddItem(item, amount)
end
local function removeItem(src, player, item, amount)
    if Config.UseOxInventory then return exports.ox_inventory:RemoveItem(src, item, amount) end
    return player.Functions.RemoveItem(item, amount)
end
lib.callback.register('casino-bridge:exchange', function(src, action, amount)
    if busy[src] then return reply(false, 'Transaction already processing') end
    if action ~= 'buy' and action ~= 'sell' then return reply(false, 'Invalid action') end
    if type(amount) ~= 'number' or amount ~= amount or amount % 1 ~= 0 or amount < 1 or amount > Config.MaxExchange then
        return reply(false, 'Invalid amount')
    end
    local ped = GetPlayerPed(src)
    if ped == 0 or #(GetEntityCoords(ped) - Config.ExchangeCoords) > Config.InteractionDistance + 2 then
        return reply(false, 'Move closer to the cashier')
    end
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return reply(false, 'Player unavailable') end
    if Config.RequireMembership and countItem(src, player, Config.MemberItem) < 1 and countItem(src, player, Config.VipItem) < 1 then
        return reply(false, 'Casino membership required')
    end
    busy[src] = true
    local ok, result = pcall(function()
        local cost = amount * Config.ChipPrice
        if action == 'buy' then
            if player.Functions.GetMoney('cash') < cost then return reply(false, 'Insufficient cash') end
            if Config.UseOxInventory and not exports.ox_inventory:CanCarryItem(src, Config.ChipItem, amount) then
                return reply(false, 'Not enough inventory space')
            end
            if not player.Functions.RemoveMoney('cash', cost, 'casino-chip-purchase') then return reply(false, 'Payment failed') end
            if not addItem(src, player, Config.ChipItem, amount) then
                local refunded = player.Functions.AddMoney('cash', cost, 'casino-chip-refund')
                if not refunded then print(('[casino-bridge] CRITICAL: cash refund failed for %d amount %d'):format(src, cost)) end
                return reply(false, 'Chip delivery failed; refund attempted')
            end
            return reply(true, ('Purchased %d chips'):format(amount))
        end
        if countItem(src, player, Config.ChipItem) < amount then return reply(false, 'Not enough chips') end
        if not removeItem(src, player, Config.ChipItem, amount) then return reply(false, 'Could not remove chips') end
        if not player.Functions.AddMoney('cash', cost, 'casino-chip-sale') then
            local restored = addItem(src, player, Config.ChipItem, amount)
            if not restored then print(('[casino-bridge] CRITICAL: chip restoration failed for %d amount %d'):format(src, amount)) end
            return reply(false, 'Payout failed; restoration attempted')
        end
        return reply(true, ('Sold %d chips'):format(amount))
    end)
    busy[src] = nil
    if not ok then
        print(('[casino-bridge] Exchange error for %d: %s'):format(src, tostring(result)))
        return reply(false, 'Transaction failed; contact staff')
    end
    return result
end)
AddEventHandler('playerDropped', function() busy[source] = nil end)
