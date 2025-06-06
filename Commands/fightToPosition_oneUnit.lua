local commandInfo = {
  name = "fightMoveToPosition",
  desc = "Move a single unit to a position using FIGHT command",
  author = "MajdaT_ChatGPT",
  date = "2025-06-06",
  license = "notAlicense"
}

function getInfo()
  return {
    onNoUnits = FAILURE,
    tooltip = "FIGHT move single unit to endPos",
    parameterDefs = {
      {
        name = "unitID",
        variableType = "expression",
        componentType = "editBox",
        defaultValue = ""
      },
      {
        name = "endPos",
        variableType = "expression",
        componentType = "editBox",
        defaultValue = ""
      }
    }
  }
end

local SpringValidUnitID = Spring.ValidUnitID
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

local CMD_FIGHT = CMD.FIGHT
local DISTANCE_THRESHOLD = 100

function Run(self, units, parameter)
  local unitID = parameter.unitID
  local endPos = parameter.endPos
  
  if not SpringValidUnitID(unitID) then
    return FAILURE
  end

  local ux, uy, uz = SpringGetUnitPosition(unitID)
  if not ux then
    return FAILURE
  end

  local dx = (endPos.x or endPos[1]) - ux
  local dz = (endPos.z or endPos[3]) - uz
  local distSq = dx * dx + dz * dz

  if distSq < DISTANCE_THRESHOLD then
    return SUCCESS
  end

  SpringGiveOrderToUnit(unitID, CMD_FIGHT, {endPos.x or endPos[1], endPos.y or endPos[2], endPos.z or endPos[3]}, {})
  return RUNNING
end

function Reset(self)
end
