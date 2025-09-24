local RSGCore = exports['rsg-core']:GetCoreObject()
local debug = true

-- Event
RegisterNetEvent('naufal-blindfold:client:setblindfold', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "open"
    })
end)

RegisterNetEvent('naufal-blindfold:client:remove-blindfold', function()
    SendNUIMessage({ type = 'closeAll' })
    SendNUIMessage({ action = "close" })
end)

-- Debug
if Config.Debug.Active then
    local usedcommand = false
    RegisterCommand(Config.Debug.Command, function(source, args, rawCommand)
        usedcommand = not usedcommand 
        if usedcommand then
            TriggerEvent('naufal-blindfold:client:setblindfold')
        elseif not usedcommand then
            TriggerEvent('naufal-blindfold:client:remove-blindfold')
        end
    end)
end

-- Thread
CreateThread(function()
    exports.ox_target:addGlobalPlayer({
        {
            name = 'blindfold',
            icon = 'fa-solid fa-car-side',
            label = 'Blindfold',
            canInteract = function(entity, distance, coords, name)
                local count = RSGCore.Functions.HasItem('blindfold', 1)
                local id = GlobalState.blindfolds[GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))]
                if id then
                    return false
                end
                if count then
                    return true
                end
            end,
            onSelect = function(data)
                TriggerServerEvent('naufal-blindfold:server:setblindfold', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            name = 'remove-blindfold',
            icon = 'fa-solid fa-car-side',
            label = "Remove blindfold",
            canInteract = function(entity, distance, coords, name)
                local id = GlobalState.blindfolds[GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))]
                if id then
                    return true
                end
                return false
            end,
            onSelect = function(data)
                TriggerServerEvent('naufal-blindfold:server:remove-blindfold', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        }
    })
end)