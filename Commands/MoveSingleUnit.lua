local commandInfo = {
  name = "MoveSingleUnit",
  desc = "Move a single unit to given position with optional fight flag",
  author = "MajdaT_ChatGPT",
  date = "2025-06-27",
  license = "notAlicense",
}

function getInfo()
  return {
    onNoUnits = SUCCESS,
    tooltip = "Move one unit to defined position, optionally using fight command",
    parameterDefs = {
      {
        name = "unitID",
        variableType = "expression",
        componentType = "editBox",
        defaultValue = "",
      },
      {
        name = "position",
        variableType = "expression",
        componentType = "editBox",
        defaultValue = "",
      },
      {
        name = "fight",
        variableType = "expression",
        componentType = "checkBox",
        defaultValue = "false",
      }
    }
  }
end

-- speed-ups
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringValidUnitID = Spring.ValidUnitID

local BASE_THRESHOLD = 10
local MAX_GRACE_TICKS = 5
local GRACE_STEP = 5

function Run(self, units, parameter)
  local unitID = parameter.unitID
  local targetPos = parameter.position
  local fight = parameter.fight

  if not SpringValidUnitID(unitID) then
    return FAILURE
  end

  local cmdID = CMD.MOVE
  if fight then cmdID = CMD.FIGHT end

  local ux, uy, uz = SpringGetUnitPosition(unitID)
  if not ux then return FAILURE end

  self.graceTick = (self.graceTick or 0) + 1
  local graceThreshold = BASE_THRESHOLD + (self.graceTick - 1) * GRACE_STEP

  local distSq = (targetPos.x - ux)^2 + (targetPos.z - uz)^2
  if distSq < graceThreshold * graceThreshold or self.graceTick > MAX_GRACE_TICKS then
    return SUCCESS
  end

  SpringGiveOrderToUnit(unitID, cmdID, targetPos:AsSpringVector(), {})
  return RUNNING
end

function Reset(self)
  self.graceTick = 0
end
