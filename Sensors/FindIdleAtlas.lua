local sensorInfo = {
  name = "FindIdleAtlas",
  desc = "Returns the ID of one idle armatlas unit (not moving, not transporting). Returns 0 if none available.",
  author = "MajdaT_ChatGPT",
  date = "2025-05-28",
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
local SpringGetUnitVelocity = Spring.GetUnitVelocity
local SpringGetUnitIsTransporting = Spring.GetUnitIsTransporting
local SpringValidUnitID = Spring.ValidUnitID
local UnitDefs = UnitDefs

-- @description: Returns the ID of one idle armatlas (not moving, not transporting)
-- @return [number] - unitID or 0 if none available
return function()
  local myTeamID = Spring.GetMyTeamID()
  local units = SpringGetTeamUnits(myTeamID)

  for i = 1, #units do
    local unitID = units[i]
    if SpringValidUnitID(unitID) then
      local defID = SpringGetUnitDefID(unitID)
      if defID and UnitDefs[defID].name == "armatlas" then
        local vx, vy, vz = SpringGetUnitVelocity(unitID)
        local speedSq = (vx or 0)^2 + (vy or 0)^2 + (vz or 0)^2
        local transporting = SpringGetUnitIsTransporting(unitID)
        if speedSq < 0.1 and #transporting == 0 then
          return unitID
        end
      end
    end
  end

  return 0 -- no idle atlas found
end
