ESX = exports["es_extended"]:getSharedObject()
local VehicleData = nil

local function showNotification(message)
    ESX.ShowNotification(message)
end

local function loadAnimationDict(animDict)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end
end

local function isVehicleUpsideDown(vehicle)
    local roll = GetEntityRoll(vehicle)
    return (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2
end

local function isPlayerInsideVehicle()
    return IsPedInAnyVehicle(PlayerPedId(), true)
end

local function getClosestVehicle()
    return ESX.Game.GetClosestVehicle()
end

local function distanceCheck(coords1, coords2, maxDistance)
    return #(coords1 - coords2) <= maxDistance
end

local function flipVehicle(vehicle)
    local animDict = Config.General.ProgressBar.anim_dict
    local animClip = Config.General.ProgressBar.anim_clip

    loadAnimationDict(animDict)

    if lib.progressBar({
        duration = Config.General.ProgressBar.duration,
        label = Config.General.ProgressBar.label,
        useWhileDead = false,
        canCancel = true,
        disable = { car = true, move = true, combat = true },
        anim = { dict = animDict, clip = animClip },
    }) then
        local carCoords = GetEntityRotation(vehicle, 2)
        SetEntityRotation(vehicle, carCoords[1], 0, carCoords[3], 2, true)
        SetVehicleOnGroundProperly(vehicle)
        showNotification(Config.General.Notify.inside)
        ClearPedTasks(PlayerPedId())
    else
        showNotification(Config.General.Notify.stopped_flipping)
    end
end

exports.ox_target:addGlobalVehicle({
    {
        name = Config.General.Target.name,
        label = Config.General.Target.label,
        icon = Config.General.Target.icon,
        onSelect = function(data)
            if isPlayerInsideVehicle() then
                showNotification(Config.General.Notify.inside)
            else
                local pedCoords = GetEntityCoords(PlayerPedId())
                local vehicle = getClosestVehicle()
                local maxDistance = 3

                if distanceCheck(pedCoords, GetEntityCoords(vehicle), maxDistance) then
                    flipVehicle(vehicle)
                else
                    showNotification(Config.General.Notify.too_far)
                end
            end
        end,
        canInteract = function(vehicle)
            return isVehicleUpsideDown(vehicle) and GetEntitySpeed(vehicle) < 2
        end
    }
})

