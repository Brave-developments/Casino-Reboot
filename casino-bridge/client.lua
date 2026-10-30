local function notify(description, type)
    lib.notify({ title = 'Diamond Casino', description = description, type = type or 'inform' })
end
RegisterNetEvent('casino-bridge:client:notify', notify)

local function openExchange()
    local result = lib.inputDialog('Casino Chip Exchange', {
        { type = 'select', label = 'Transaction', options = {
            { value = 'buy', label = 'Buy chips' },
            { value = 'sell', label = 'Sell chips' }
        }, required = true },
        { type = 'number', label = 'Amount', min = 1, max = Config.MaxExchange, required = true }
    })
    if not result then return end
    local amount = tonumber(result[2])
    if not amount or amount % 1 ~= 0 or amount < 1 or amount > Config.MaxExchange then
        return notify('Invalid chip amount', 'error')
    end
    local response = lib.callback.await('casino-bridge:exchange', false, result[1], amount)
    if response then notify(response.message, response.success and 'success' or 'error') end
end

CreateThread(function()
    local point = lib.points.new({ coords = Config.ExchangeCoords, distance = 12 })
    function point:nearby()
        if self.currentDistance <= Config.InteractionDistance then
            lib.showTextUI('[E] Casino cashier')
            if IsControlJustReleased(0, 38) then openExchange() end
        else
            lib.hideTextUI()
        end
    end
    function point:onExit() lib.hideTextUI() end
end)
