local sensorInfo = {
  name = "FindIdleUnitInBase",
  desc = "Returns ID of stationary unit of given type either in base or anywhere, depending on input",
  author = "MajdaT + CodeCopilot",
  date = "2025-06-27",
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
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGetUnitIsTransported = Spring.GetUnitIsTransporting
local SpringGetUnitVelocity = Spring.GetUnitVelocity
local myTeamID = Spring.GetMyTeamID

local function IsInBase(x, z)
  return (x > 249 and x < 2513) and (z > 7640 and z < 9978)
end

local function IsStationary(unitID)
  local vx, vy, vz = SpringGetUnitVelocity(unitID)
  local speedSqr = vx*vx + vz*vz
  return speedSqr < 1
end

-- @description: Returns ID of idle unit of specific type, filtered by inBase
-- @argument type_of_unit [string] - unit type to look for
-- @argument inBase [boolean] - if true, restrict search to base only
-- @return [number] - unit ID or 0 if none found
return function(type_of_unit, inBase)
  local units = SpringGetTeamUnits(myTeamID())

  for i = 1, #units do
    local unitID = units[i]
    local defID = SpringGetUnitDefID(unitID)
    if defID and UnitDefs[defID].name == type_of_unit then
      if not SpringGetUnitIsTransported(unitID) then
        local x, y, z = SpringGetUnitPosition(unitID)
        if IsStationary(unitID) and (not inBase or IsInBase(x, z)) then
          return unitID
        end
      end
    end
  end

  return 0
end
