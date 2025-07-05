-- FindBattle: Returns the position of the nearest enemy unit (not in my allyTeam) close to the middle corridor

local sensorInfo = {
  name = "FindBattle",
  desc = "Finds closest enemy unit (non-ally) in middle lane corridor toward our base",
  author = "MajdaT + CodeCopilot",
  date = "2025-06-30",
  license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = 15

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetAllUnits = Spring.GetAllUnits
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGetUnitAllyTeam = Spring.GetUnitAllyTeam
local SpringGetMyAllyTeamID = Spring.GetMyAllyTeamID

local Vec3 = Vec3

local baseCenter = Vec3(1381, 0, 8809)
local middleCorridorCenter = Vec3(5560, 0, 4560)
local corridorRadius = 2800

return function()
  local myAllyTeam = SpringGetMyAllyTeamID()
  local allUnits = SpringGetAllUnits()

  local closestDist = math.huge
  local bestPos = nil

  for i = 1, #allUnits do
    local unitID = allUnits[i]
    local unitAllyTeam = SpringGetUnitAllyTeam(unitID)
    if unitAllyTeam and unitAllyTeam ~= myAllyTeam then
      local x, y, z = SpringGetUnitPosition(unitID)
      if x and z then
        local unitPos = Vec3(x, y or 0, z)
        local distToCorridor = unitPos:Distance(middleCorridorCenter)
        if distToCorridor <= corridorRadius then
          local distToBase = unitPos:Distance(baseCenter)
          if distToBase < closestDist then
            closestDist = distToBase
            bestPos = unitPos
          end
        end
      end
    end
  end

  local fallback = middleCorridorCenter
  local pos = bestPos or fallback

  if (Script.LuaUI('exampleDebug_update')) then
    Script.LuaUI.exampleDebug_update(
      "battle",
      {
        startPos = pos,
        endPos = pos + Vec3(150, 0, -150)
      }
    )
  end

  return pos
end
