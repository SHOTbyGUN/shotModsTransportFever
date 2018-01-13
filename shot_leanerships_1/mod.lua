function data() 
    return {
        info = {
            minorVersion   = 0,
            severityAdd    = "NONE",
            severityRemove = "NONE",
            name           = _("Leaner ships"),
            description    = _("Ships weight less to fix issue caused by cargo weight patch"),
            tags           = { "Script Mod" },
            authors = { 
                { 	name = 'SHOT(by)GUN',
                    role = 'Creator', 
                }
            },
            dependencies = {},
        },
        runFn = function(settings)
            local function myModifier(fileName, data)
                if data.metadata.waterVehicle then
                    -- if ship weight over 60t lower mass to 60%
                    if data.metadata.waterVehicle.weight > 60000 then
                        data.metadata.waterVehicle.weight = data.metadata.waterVehicle.weight * 0.6
                    elseif data.metadata.waterVehicle.weight > 40000 then
                        data.metadata.waterVehicle.weight = data.metadata.waterVehicle.weight * 0.7
                    elseif data.metadata.waterVehicle.weight > 20000 then
                        data.metadata.waterVehicle.weight = data.metadata.waterVehicle.weight * 0.8
                    end
                end
            return data
            end
            addModifier("loadModel", myModifier)
    end
} 
end


