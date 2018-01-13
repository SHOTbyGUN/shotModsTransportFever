local function getSpeed(data)
    if data.speedLimit then
        return data.speedLimit * 3.6
    else
        return 300
    end
end

local function modifyTrack(fileName, data)
    data.cost = getSpeed(data) - 40
    data.desc = data.desc .. "\nCost: " .. data.cost .. " $/m"
	return data
end

local function modifyBridge(fileName, data)
    
    local speedCost
    
    if data.carriers[1] == "ROAD" then
        -- double road bridge costs
        data.cost = data.cost * 2
    else
        data.cost = getSpeed(data) * 3
        --data.desc = data.desc .. "\nCost: " .. data.cost .. " $/m"
    end
	return data
end

local function modifyTunnel(fileName, data)
    -- double tunnel costs
	data.cost = data.cost * 2
    --data.desc = data.desc .. "\nCost: " .. data.cost .. " $/m"
	return data
end

local function modifyConstruction(fileName, data)
    if data.type == "RAIL_DEPOT" and data.description.name == _("Train depot") then
        data.cost = data.cost * 10
    end
    --data.desc = data.desc .. "\nCost: " .. data.cost .. " $/m"
    --RAIL_DEPOT does not have data.cost variable, the cost is introduced in updatefn function
    --this means rail depot price cannot be modded !!!
    --this function is disabled in runFn function below
	return data
end

function data() 
    return {
        info = {
            minorVersion   = 2,
            severityAdd    = "NONE",
            severityRemove = "NONE",
            name           = _("Expensive tracks"),
            description    = _("Increased costs for tracks, bridges, tunnels and catenary"),
            tags           = { "Script Mod" },
            authors = { 
                { 	name = 'SHOT(by)GUN',
                    role = 'Creator', 
                }
            },
            dependencies = {},
        },
    runFn = function(settings)
        -- increase catenary cost multiplier from 0.3 to 0.5
        game.config.costs.railroadCatenary = 0.5
        
        -- increase terrain modification costs
        game.config.costs.terrainRaise = game.config.costs.terrainRaise * 2
        game.config.costs.terrainLower = game.config.costs.terrainLower * 2
        
        addModifier("loadTrack", modifyTrack)
		addModifier("loadBridge", modifyBridge)
		addModifier("loadTunnel", modifyTunnel)
        --addModifier("loadConstruction", modifyConstruction)
    end
} 
end


