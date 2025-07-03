local sensorInfo = {
  name = "FindUnit",
  desc = "Returns ID of any unit of given type (not transported)",
  author = "MajdaT + CodeCopilot",
  date = "2025-07-03",
  license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetTeamUnits = Spring.GetTeamUnits
local SpringGetUnitDefID = Spring.GetUnitDefID
local SpringGetUnitIsTransported = Spring.GetUnitIsTransporting
local myTeamID = Spring.GetMyTeamID
local SpringValidUnitID = Spring.ValidUnitID

-- @description: Returns ID of any unit of specific type that is not transported
-- @argument type_of_unit [string] - unit type to look for
-- @return [number] - unit ID or 0 if none found
return function(type_of_unit)
  local units = SpringGetTeamUnits(myTeamID())

  for i = 1, #units do
    local unitID = units[i]
    if SpringValidUnitID(unitID) then
      local defID = SpringGetUnitDefID(unitID)
      if defID and UnitDefs[defID].name == type_of_unit then
        if not SpringGetUnitIsTransported(unitID) then
          return unitID
        end
      end
    end
  end

  return 0
end
