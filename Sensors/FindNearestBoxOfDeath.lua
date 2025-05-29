local sensorInfo = {
  name = "FindNearestBoxOfDeath",
  desc = "Finds the closest type_of_unit unit to any armmstor unit owned by the current team",
  author = "MajdaT + CodeCopilot",
  date = "2025-05-28",
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
local myTeamID = Spring.GetMyTeamID

return function(type_of_unit)
  local units = SpringGetTeamUnits(myTeamID())

  local boxUnits = {}
  local storageUnits = {}

  for i = 1, #units do
    local unitID = units[i]
    local defID = SpringGetUnitDefID(unitID)
    local defName = UnitDefs[defID].name
    if defName == type_of_unit then
      boxUnits[#boxUnits+1] = unitID
    elseif defName == "armmstor" then
      storageUnits[#storageUnits+1] = unitID
    end
  end

  if #boxUnits == 0 or #storageUnits == 0 then return 0 end

  local minDist = math.huge
  local bestBox = 0

  for _, boxID in ipairs(boxUnits) do
    local bx, by, bz = SpringGetUnitPosition(boxID)
    for _, storID in ipairs(storageUnits) do
      local sx, sy, sz = SpringGetUnitPosition(storID)
      local dx = bx - sx
      local dz = bz - sz
      local distSqr = dx*dx + dz*dz
      if distSqr < minDist then
        minDist = distSqr
        bestBox = boxID
      end
    end
  end

  return bestBox
end
