
ESX = exports.es_extended:getSharedObject()

local Duty = {}

AddEventHandler('esx:playerLoaded',function (src,xPlayer)
    MySQL.Async.fetchAll('SELECT  duty FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result) 
        if result ~= nil then
            if result[1].duty > 0 then
                Duty[xPlayer.identifier] = true
            else
                Duty[xPlayer.identifier] = false
            end
            xPlayer.triggerEvent("mxm_duty:updateDuty",Duty[xPlayer.identifier])
        end
    end)
end)


ESX.RegisterServerCallback("mxm_duty:EnterLeave", function(source, cb, boolean)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        exports["mxm_duty"]:setDuty(source,boolean)
        local inDuty = exports["mxm_duty"]:getDuty(source)
        cb(inDuty)
    end
end)


exports('getDuty',function(source)
    local xPlayer =  ESX.GetPlayerFromId(source)
    if xPlayer then
        if Duty[xPlayer.identifier] ~= nil then
            return Duty[xPlayer.identifier] 
        end 
    end
end)


exports('setDuty',function(source,boolean)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        Duty[xPlayer.identifier]  = boolean
        xPlayer.triggerEvent("mxm_duty:updateDuty",boolean)
    end
end)


AddEventHandler('playerDropped', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer then
        if Duty[xPlayer.identifier] ~= nil then
            MySQL.Async.execute('UPDATE users SET duty = @duty WHERE identifier = @identifier', {
                ['@duty'] = Duty[xPlayer.identifier], 
                ["@identifier"] = xPlayer.identifier
            }, function(c2)
                Duty[xPlayer.identifier] = nil
            end)
        end 
	end
end)



--Example usage
--[[


ExampleChekJobInDutyOnline = function (job)  
    local count = 0
    for index, player in pairs(GetPlayers()) do
        if tonumber(player) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local inDuty = exports["mxm_duty"]:getDuty(tonumber(player))
            if xPlayer then
                if xPlayer.job.name == job and inDuty then
                    count = count + 1
                end
            end
        end
    end
    return count
end


]]

