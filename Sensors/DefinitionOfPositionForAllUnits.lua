local sensorInfo = {
  name = "DefinitionOfPositionForAllUnits",
  desc = "Provides a fixed mapping of unit types to delivery positions (Vec3)",
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

-- @description: Returns fixed table defining which unit type should be delivered to which Vec3 position.
-- The order is preserved (integer keys)
-- @return table of { [index] = { unitType, Vec3(x, y, z) } }
return function()
  return {
    [1] = { variant = "armbox", position = Vec3(4683, 17, 4425) },
    [2] = { variant = "armseer", position = Vec3(4708, 41, 4051) },
    [3] = { variant = "armbox", position = Vec3(5620, 45, 5560) },
    -- další pozice můžeš doplnit dle potřeby
  }
end
