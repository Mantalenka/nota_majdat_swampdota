local sensorInfo = {
  name = "FindIdleUnitInBase",
  desc = "Returns ID of stationary unit of given type in base or 0 if none found",
  author = "MajdaT + CodeCopilot",
  date = "2025-05-30",
  license = "MIT"
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

return function(type_of_unit)
  local units = SpringGetTeamUnits(myTeamID())

  for i = 1, #units do
    local unitID = units[i]
    local defID = SpringGetUnitDefID(unitID)
    if defID and UnitDefs[defID].name == type_of_unit then
      if not SpringGetUnitIsTransported(unitID) then
        local x, y, z = SpringGetUnitPosition(unitID)
        if IsInBase(x, z) and IsStationary(unitID) then
          return unitID
        end
      end
    end
  end

  return 0
end
