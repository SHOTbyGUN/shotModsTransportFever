function data() 
    return {
        info = {
            minorVersion   = 0,
            severityAdd    = "NONE",
            severityRemove = "NONE",
            name           = _("Bring back 120s"),
            description    = _("Medium speed wagons don't expire"),
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
                if data.metadata.railVehicle then
                    -- if vehicle top speed 120 and is a weight of a wagon
                    -- then never expire
                    if data.metadata.railVehicle.topSpeed == 120 and data.metadata.railVehicle.weight < 32 then
                        data.metadata.availability.yearTo = 0
                    end
                end
            return data
            end
            addModifier("loadModel", myModifier)
    end
} 
end


