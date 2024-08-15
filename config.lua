Config = {}

Config.General = {
    Target = {
        name = 'flipcar',
        label = "flipcar",
        icon = "fas fa-arrow-up",
    },
    ProgressBar = {
        duration = 8000,
        label = 'Vehicle overturning...',
        anim_dict = 'missfinale_c2ig_11',
        anim_clip = 'pushcar_offcliff_m',
    },
    Notify = {
        inside = 'You are in the vehicle!',
        overturned_vehicle = 'You overturned the vehicle!',
        stopped_flipping = 'You stopped flipping your vehicle!',
    }
}

Config.showNotification = function(message)
    ESX.Config.showNotification(message)
end