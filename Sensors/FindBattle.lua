-- FindEnemyNearBase: Returns position of nearest enemy unit within radius of base center

local sensorInfo = {
  name = "FindEnemyNearBase",
  desc = "Finds the closest enemy unit near our base center (within a fixed radius)",
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

local SpringGetTeamList = Spring.GetTeamList
local SpringGetTeamUnits = Spring.GetTeamUnits
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGetUnitAllyTeam = Spring.GetUnitAllyTeam
local SpringGetMyAllyTeamID = Spring.GetMyAllyTeamID

local Vec3 = Vec3

local hardcodePos = Vec3(5560, 0, 4560)
local radius = 2800
local radiusSq = radius * radius

return function()
  local myAllyTeam = SpringGetMyAllyTeamID()
  local teams = SpringGetTeamList()

  local bestUnitPos = nil
  local bestDistSq = math.huge

  for i = 1, #teams do
    local teamID = teams[i]
    if SpringGetUnitAllyTeam(teamID) ~= myAllyTeam then
      local units = SpringGetTeamUnits(teamID)
      for j = 1, #units do
        local unitID = units[j]
        local x, y, z = SpringGetUnitPosition(unitID)
        if x and z then
          local dx = x - hardcodePos.x
          local dz = z - hardcodePos.z
          local distSq = dx*dx + dz*dz
          if distSq < radiusSq and distSq < bestDistSq then
            bestDistSq = distSq
            bestUnitPos = Vec3(x, y or 0, z)
          end
        end
      end
    end
  end

  local pos = bestUnitPos or hardcodePos

  Spring.Echo("Battle position:", pos.x, pos.y, pos.z, " bestUnitPos: ", bestUnitPos.x, bestUnitPos.y, bestUnitPos.z)
  
    if (Script.LuaUI('exampleDebug_update')) then
    Script.LuaUI.exampleDebug_update(
      "battle", -- key
      {	-- data
        startPos = pos, 
        endPos = pos + Vec3(150,0,-150)
      }
    )
  end
  return pos
end
