ESX = nil
Citizen.CreateThread(function()
 while ESX == nil do
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  Citizen.Wait(0)
 end
end)

local releaseCoords = {
    x = 1774.02,
    y = 2552.06,
    z = 45.56,
    rot = 90.1,
}


local jailCoords = {
    x = 1774.02,
    y = 2552.06,
    z = 45.56,
    rot = 90.1,
}
local isInJail = false
local remaningSeconds = 0

-- /jail id time
RegisterCommand("jail", function(source, args, rawCommand)
    
    ESX.TriggerServerCallback('Jail:getJob', function(jobname)
        
        if jobname == 'police' then
            local player = tonumber(args[1]) 
            local time = tonumber(args[2])

            TriggerServerEvent('Jail:sendToJail', player, time)

        end

    end)

end)

RegisterNetEvent('Jail:goToJail')
AddEventHandler('Jail:goToJail', function(seconds)

    goToJail(seconds)

end)

Citizen.CreateThread(function()
    while true do
        if isInJail then
            
            if remaningSeconds > 0 then
                remaningSeconds = remaningSeconds -1
                if remaningSeconds ==  60 or remaningSeconds == 120 or remaningSeconds == 180 or remaningSeconds == 240 or remaningSeconds ==  300 or remaningSeconds == 600 or remaningSeconds == 900 or remaningSeconds == 1200 or remaningSeconds == 1800 then
                    ShowNotification('~o~Du musst noch ' .. remaningSeconds .. 'Sekunden absitzen')
            else
                isInJail = false
                SetEntityCoords(playerPed, releaseCoords.x, releaseCoords.y, releaseCoords.z)
                ShowNotification('~g~Du hast deine Haftstrafe abgesessen und wirst nun entlassen.')
            end

        end
        Citizen.Wait(1000)
    end
end)


function goToJail(seconds)
    local playerPed = PlayerPedId()
    isInJail = true
    remaningSeconds = seconds
    SetEntityCoords(playerPed, jailCoords.x, jailCoords.y, jailCoords.z)
    SetEntityHeading(playerPed, jailCoords.rot)
    ShowNotification('~r~Du bist nun für ~y~' .. seconds .. 'Sekunden ~r~im Gefängnis!')
end

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
       AddTextComponentString(text)
    DrawNotification(false, true)
   end