local cfg = {
    active = false,
    notFound = false,
    oldVehicle = nil,
    tickTime = 1500,
    vehicles = { -- Add more cars here
        { model = 'adder', max = 10.0}, 
        { model = 't20', max = 5.0}
    }
}

CreateThread(function()
    while true do
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle and vehicle > 0 and DoesEntityExist(vehicle) then
            if not cfg.active and not cfg.notFound then
                for i=1, #cfg.vehicles do
                    if GetEntityModel(vehicle) == GetHashKey(cfg.vehicles[i].model) then
                        cfg.active = true
                        SetVehicleMaxSpeed(vehicle, cfg.vehicles[i].max)
                        break
                    end
                end
                if not cfg.active then
                    cfg.notFound = true
                end
            end
        else
            if cfg.oldVehicle then
                if DoesEntityExist(cfg.oldVehicle) then
                    SetVehicleMaxSpeed(cfg.oldVehicle, 0.0)
                end
                cfg.oldVehicle = nil
            end
            if cfg.active then
                cfg.active = false
            end
            if cfg.notFound then
                cfg.notFound = false
            end
        end
        Wait(cfg.tickTime)
    end
end)
