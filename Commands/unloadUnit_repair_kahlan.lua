local commandInfo = {
  name = "unloadUnit_repair_kahlan",
  desc = "Unload given unit at current transporter position",
  author = "MajdaT_ChatGPT_kahlan",
  date = "2025-05-28",
  license = "notAlicense"
}

function getInfo()
  return {
    onNoUnits = SUCCESS,
    tooltip = "Unload given unit",
    parameterDefs = {
      {
        name = "transporter",
        variableType = "expression",
        componentType = "editBox",
        defaultValue = "",
      },
      {
        name = "unit",
        variableType = "expression",
        componentType = "editBox",
        defaultValue = "",
      }
    }
  }
end

local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringValidUnitID = Spring.ValidUnitID
local SpringGetUnitTransporter = Spring.GetUnitTransporter

function Run(self, units, parameter)
  local transporter = parameter.transporter
  local unit = parameter.unit

  if not SpringValidUnitID(unit) or not SpringValidUnitID(transporter) then
    return FAILURE
  end

  if SpringGetUnitTransporter(unit) == nil then
    return SUCCESS
  end

  if not self.init then
    local x, y, z = SpringGetUnitPosition(transporter)
    if not x then return FAILURE end
    SpringGiveOrderToUnit(transporter, CMD.UNLOAD_UNITS, {x, y, z, 64}, {})
    self.init = true
  end

  return RUNNING
end

function Reset(self)
  self.init = false
end
