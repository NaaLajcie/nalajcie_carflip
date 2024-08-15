ESX = exports["es_extended"]:getSharedObject()

local function isVehicleUpsideDown(vehicle)
    local roll = GetEntityRoll(vehicle)
    return (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2
end

local function flipVehicle(vehicle)
    if lib.progressBar({
        duration = Config.General.ProgressBar.duration,
        label = Config.General.ProgressBar.label,
        useWhileDead = false,
        canCancel = true,
        disable = { car = true, move = true, combat = true },
        anim = { dict = Config.General.ProgressBar.anim_dict, clip = Config.General.ProgressBar.anim_clip },
    }) then
        local carCoords = GetEntityRotation(vehicle, 2)
        SetEntityRotation(vehicle, carCoords[1], 0, carCoords[3], 2, true)
        SetVehicleOnGroundProperly(vehicle)
        Config.showNotification(Config.General.Notify.inside)
    else
        Config.showNotification(Config.General.Notify.stopped_flipping)
    end
end

exports.ox_target:addGlobalVehicle({
    {
        name = Config.General.Target.name,
        label = Config.General.Target.label,
        icon = Config.General.Target.icon,
        distance = Config.maxDistance.
        onSelect = function(data)
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                Config.showNotification(Config.General.Notify.inside)
            else
                flipVehicle(data.entity)
            end
        end,
        canInteract = function(vehicle)
            return isVehicleUpsideDown(vehicle) and GetEntitySpeed(vehicle) < 2
        end
    }
})

