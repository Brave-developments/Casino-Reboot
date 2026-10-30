local QBCore = exports['qb-core']:GetCoreObject()
local busy = {}
local function reply(success, message) return { success = success, message = message } end

lib.callback.register('casino-bridge:exchange', function(source, action, amount)
    if busy[source] then return reply(false, 'Transaction already processing') end
    if action ~= 'buy' and action ~= 'sell' then return reply(false, 'Invalid action') end
    if type(amount) ~= 'number' or amount % 1 ~= 0 or amount < 1 or amount > Config.MaxExchange then
        return reply(false, 'Invalid amount')
    end
    local ped = GetPlayerPed(source)
    if ped == 0 or #(GetEntityCoords(ped) - Config.ExchangeCoords) > Config.InteractionDistance + 2.0 then
        return reply(false, 'Move closer to the cashier')
    end
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return reply(false, 'Player unavailable') end
    busy[source] = true
    local ok, result = pcall(function()
        local cost = amount * Config.ChipPrice
        if action == 'buy' then
            if player.Functions.GetMoney('cash') < cost then return reply(false, 'Insufficient cash') end
            if not player.Functions.RemoveMoney('cash', cost, 'casino-chip-purchase') then return reply(false, 'Payment failed') end
            if not player.Functions.AddItem(Config.ChipItem, amount) then
                player.Functions.AddMoney('cash', cost, 'casino-chip-refund')
                return reply(false, 'Inventory full; cash refunded')
            end
            return reply(true, ('Purchased %d chips'):format(amount))
        end
        local item = player.Functions.GetItemByName(Config.ChipItem)
        if not item or item.amount < amount then return reply(false, 'Not enough chips') end
        if not player.Functions.RemoveItem(Config.ChipItem, amount) then return reply(false, 'Could not remove chips') end
        if not player.Functions.AddMoney('cash', cost, 'casino-chip-sale') then
            player.Functions.AddItem(Config.ChipItem, amount)
            return reply(false, 'Payment failed; chips restored')
        end
        return reply(true, ('Sold %d chips'):format(amount))
    end)
    busy[source] = nil
    if not ok then
        print(('[casino-bridge] Exchange failed: %s'):format(result))
        return reply(false, 'Transaction failed; contact staff')
    end
    return result
end)
AddEventHandler('playerDropped', function() busy[source] = nil end)
