local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallbeck('Jail:getJob', function(source, cb)

local xPlayer = ESX:GetPlayerFromId(source)
cb(xPlayer.job.name)

end)

RegisterServerEvent('Jail:sendToJail')
AddEventHandler('Jail:sendToJail', function(player, time)

    local xPlayer = ESX:GetPlayerFromId(player)

    if xPlayer ~= nil then

    TriggerClientEvent('Jail:goToJail', player, time)
    end
    
end)