local sensorInfo = {
  name = "FindAllArmMav",
  desc = "Returns a list of all existing armmav unit IDs for current team.",
  author = "MajdaT_ChatGPT",
  date = "2025-06-06",
  license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = 1 -- update every frame

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetTeamUnits = Spring.GetTeamUnits
local SpringGetUnitDefID = Spring.GetUnitDefID
local SpringValidUnitID = Spring.ValidUnitID
local UnitDefs = UnitDefs

-- @description: Returns list of unit IDs of all alive "armmav" units
-- @return [table<number>] - list of unitIDs
return function()
  local myTeamID = Spring.GetMyTeamID()
  local units = SpringGetTeamUnits(myTeamID)
  local result = {}

  for i = 1, #units do
    local unitID = units[i]
    if SpringValidUnitID(unitID) then
      local defID = SpringGetUnitDefID(unitID)
      if defID and UnitDefs[defID].name == "armmav" then
        result[#result+1] = unitID
      end
    end
  end

  return result
end
