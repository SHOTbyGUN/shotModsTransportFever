local function getSpeed(data)
    if data.speedLimit then
        -- return data.speedLimit * 3.6
	return  math.pow ( data.speedLimit, 2) * 0.025	
    else
        return 300
    end
end

local function modifyTrack(fileName, data)
    -- reduce low speed tracks maintenance cost
    --if getSpeed(data) < 130 then
    --    data.maintenanceCost = getSpeed(data) * 0.01
    --else
    --    data.maintenanceCost = getSpeed(data) * 0.02
    --end
    data.maintenanceCost = getSpeed(data) * 0.01
    data.catenaryMaintenanceCost = 2 + getSpeed(data) * 0.01
    data.desc = data.desc .. "\nMaintenance: " .. data.maintenanceCost .. " $/m"
    data.desc = data.desc .. "\nMaintenance catenary: " .. data.catenaryMaintenanceCost .. " $/m"
	return data
end

local function modifyBridge(fileName, data)
    
    -- ignore roads
    if data.carriers[1] == "ROAD" then
        return data
    end
    
    data.maintenanceCost = getSpeed(data) * 0.02
    --data.desc = data.desc .. "\nMaintenance: " .. data.maintenanceCost .. " $/m"
    --data.desc = data.desc .. "\nMaintenance catenary: " .. data.catenaryMaintenanceCost .. " $/m"
	return data
end

local function modifyTunnel(fileName, data)
    
    -- ignore roads
    if data.carriers[1] == "ROAD" then
        return data
    end
    
	data.maintenanceCost = 10
    --data.desc = data.desc .. "\nMaintenance: " .. data.maintenanceCost .. " $/m"
    --data.desc = data.desc .. "\nMaintenance catenary: " .. data.catenaryMaintenanceCost .. " $/m"
	return data
end

local function modifyConstruction(fileName, data)
    if data.type == "RAIL_DEPOT" and data.description.name == _("Train depot") then
        data.maintenanceCost = data.cost * 0.02
        data.desc = data.desc .. "\nMaintenance: " .. data.maintenanceCost .. " $/m"
        data.desc = data.desc .. "\nMaintenance catenary: " .. data.catenaryMaintenanceCost .. " $/m"
    end
	return data
end

function data()
return {
	info = {
		minorVersion = 0,
		severityAdd = "NONE",
		severityRemove = "NONE",
		name = _("Railroad Maintenance Costs"),
        tags           = { "Script Mod" },
		description = _("Maintenance costs for tracks, bridges and tunnels"),
        authors = { 
                { 	name = 'SHOT(by)GUN',
                    role = 'Creator', 
                }
            },
            dependencies = {},
	},
    
	runFn = function (settings)
		addModifier("loadTrack", modifyTrack)
		addModifier("loadBridge", modifyBridge)
		addModifier("loadTunnel", modifyTunnel)
        --addModifier("loadConstruction", modifyConstruction)
	end,
}
end
