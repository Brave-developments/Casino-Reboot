RegisterNetEvent('casino:context:hit&stand', function() 
    if GetResourceState("ox_lib") == "started" then
        lib.registerContext({
            id = 'blackjack_hit_stand',
            title = 'Diamond Casino Blackjack',
            options = {
                {
                    title = 'Hit',
                    description = 'Draw another card',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 1)
                    end
                },
                {
                    title = 'Stand',
                    description = 'Be a pussy',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 2)
                    end
                }
            }
        })
        lib.showContext('blackjack_hit_stand')
    else
        exports['qb-menu']:openMenu({
            {
                header = "Diamond Casino Blackjack",
                isMenuHeader = true,
            },
            {
                header = "Hit", 
                txt = "Draw another card",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 1
                }
            },
            {
                header = "Stand", 
                txt = "Be a pussy",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 2
                }
            },
        })
    end
end)

RegisterNetEvent('casino:context:hit&doubledown', function() 
    if GetResourceState("ox_lib") == "started" then
        lib.registerContext({
            id = 'blackjack_hit_doubledown',
            title = 'Diamond Casino Blackjack',
            options = {
                {
                    title = 'Hit',
                    description = 'Draw another card',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 1)
                    end
                },
                {
                    title = 'Stand',
                    description = 'Be a pussy',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 2)
                    end
                },
                {
                    title = 'Double Down',
                    description = 'Double your initial bet',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 3)
                    end
                }
            }
        })
        lib.showContext('blackjack_hit_doubledown')
    else
        exports['qb-menu']:openMenu({
            {
                header = "Diamond Casino Blackjack",
                isMenuHeader = true,
            },
            {
                header = "Hit", 
                txt = "Draw another card",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 1
                }
            },
            {
                header = "Stand", 
                txt = "Be a pussy",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 2
                }
            },
            {
                header = "Double Down", 
                txt = "Double your initial bet",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 3
                }
            },
        })
    end
end)

RegisterNetEvent('casino:context:hit&split', function()
    if GetResourceState("ox_lib") == "started" then
        lib.registerContext({
            id = 'blackjack_hit_split',
            title = 'Diamond Casino Blackjack',
            options = {
                {
                    title = 'Hit',
                    description = 'Draw another card',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 1)
                    end
                },
                {
                    title = 'Stand',
                    description = 'Be a pussy',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 2)
                    end
                },
                {
                    title = 'Split',
                    description = 'Split',
                    onSelect = function()
                        TriggerEvent("ry::client:blackjackMenu", 4)
                    end
                }
            }
        })
        lib.showContext('blackjack_hit_split')
    else
        exports['qb-menu']:openMenu({
            {
                header = "Diamond Casino Blackjack",
                isMenuHeader = true,
            },
            {
                header = "Hit", 
                txt = "Draw another card",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 1
                }
            },
            {
                header = "Stand", 
                txt = "Be a pussy",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 2
                }
            },
            {
                header = "Split", 
                txt = "Split",
                params = {
                    event = "ry::client:blackjackMenu",
                    args = 4
                }
            },
        })
    end
end)
