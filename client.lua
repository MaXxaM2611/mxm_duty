ESX = exports.es_extended:getSharedObject()


local CicloSleep = true
local Duty = 0

RegisterNetEvent(Config.esx.playerLoaded)
AddEventHandler(Config.esx.playerLoaded, function(xPlayer)
    ESX.PlayerData = xPlayer
    CreateMarker()
end)

RegisterNetEvent(Config.esx.setJob)
AddEventHandler(Config.esx.setJob, function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("mxm_duty:updateDuty")
AddEventHandler("mxm_duty:updateDuty", function(duty)
    Duty = duty
end)

exports('getClienDuty',function()
    return Duty
end)


OpenMenuDuty = function()
    local Ped = PlayerPedId()
    ESX.UI.Menu.CloseAll()
    local elements =  {}
    if  ESX.PlayerData ~= nil  then
        local inDuty =  exports["mxm_duty"]:getClienDuty()
        if not inDuty  then
            table.insert(elements,  {label =    Lang["enter_duty"], value = true})
        else
            table.insert(elements,  {label =    Lang["leave_duty"], value = false})
        end  
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'duty_menu', {
            title = Lang["title_duty_menu"],
            align = Config.esx.menuAlign,
            elements = elements 
        }, function(d, m)
                if Config.Animation.enable then
                    TaskStartScenarioInPlace(Ped, 'WORLD_HUMAN_CLIPBOARD', 0, false)
                    m.close()
                    Citizen.Wait(Config.Animation.time)
                    ClearPedTasks(Ped)
                end
                ESX.TriggerServerCallback("mxm_duty:EnterLeave", function(result)
                    if result then
                        m.close()
                        ESX.ShowNotification(Lang["notify:enter"])
                    else
                        m.close()
                        ESX.ShowNotification(Lang["notify:leave"])
                    end
                end, d.current.value)
            end, function(d, m)
            ESX.UI.Menu.CloseAll()
        end)
    else
        return
    end
end


CreateMarker = function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            CicloSleep = true
                for k, v in pairs(Config.Position) do 
                    if ESX.PlayerData == nil  then
                    else
                        if v.job == ESX.PlayerData.job.name and ESX.PlayerData.job.grade >= v.grademin then
                            local Distanza = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v.x, v.y, v.z, true)
                            if  Distanza <= 4 then
                                DrawMarker(2,v.x , v.y , v.z, 0, 0, 0, 0, 0, 0, 0.2, 0.21, 0.10, 255, 255, 255, 200, false, 1, 0, 0)
                                CicloSleep = false
                                if Distanza <= 0.70 then
                                    DrawText3Ds(v.x , v.y , v.z+0.15,Lang["text_enterleave"])
                                    if IsControlJustReleased(1, 51) then
                                        OpenMenuDuty()
                                    end
                                end
                            end
                        end
                    end
                end
            if CicloSleep then
                Citizen.Wait(150)
            end
        end
    end)
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end




--Example usage

--[[

RegisterCommand("Testduty",function ()
    local inDuty = exports["mxm_duty"]:getClienDuty()
    if  inDuty  then   
        print("in Duty")         
        -- Sei in servizio
    else
        print("Off Duty")       
        -- Non sei in servizio
    end
end)

]]

