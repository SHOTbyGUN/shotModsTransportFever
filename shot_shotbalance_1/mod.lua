local function myModifier(fileName, data)
    if data.metadata.railVehicle then
        
        if data.metadata.railVehicle.engines and data.metadata.railVehicle.engines[1] then
            -- LOCOMOTIVE
        else
            -- WAGON
            
            if data.metadata.transportVehicle.capacities[1].type == "PASSENGERS" then
                -- Passenger wagon
                -- set weight to 80%
                data.metadata.railVehicle.weight = data.metadata.railVehicle.weight * 0.8
                
            else
                -- Cargo wagon
                -- set weight to 60%
                data.metadata.railVehicle.weight = data.metadata.railVehicle.weight * 0.6
            end
            
            
            
            -- set wagon lifespan little closer to 60
            data.metadata.maintenance.lifespan = 
                data.metadata.maintenance.lifespan 
                + ((60 - data.metadata.maintenance.lifespan) / 2)
                
            -- recalculate running costs
            --data.metadata.maintenance.runningCosts = 
            --    data.metadata.railVehicle.topSpeed * 
            --    data.metadata.railVehicle.weight * 90 - 5
        end
    end
    return data
end

local function modifyCargoWeight()
    for key, value in pairs(game.config.cargotypes) do
        if game.config.cargotypes[key].id == "PASSENGERS" then
            -- one passenger weight 65kg + luggage 10kg
            game.config.cargotypes[key].weight = 300
        else
            -- one cargo item weight 2tons
            game.config.cargotypes[key].weight = 2000
        end
    end
end

function data() 
    return {
        info = {
            minorVersion   = 0,
            severityAdd    = "NONE",
            severityRemove = "NONE",
            name           = _("Shot Rebalance"),
            description    = _("Game mechanics rebalanced"),
            tags           = { "Script Mod" },
            authors = { 
                { 	name = 'SHOT(by)GUN',
                    role = 'Creator', 
                }
            },
            dependencies = {},
        },
        
        runFn = function()
            modifyCargoWeight()
        end,
        
        addModifier("loadModel", myModifier)
    }
end


