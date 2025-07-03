local sensorInfo = {
  name = "TripleLineFormation",
  desc = "Three-line formation with pivot unit in the back",
  author = "MajdaT + CodeCopilot",
  date = "2025-06-06",
  license = "MIT",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

-- @description: Create a triple-row formation. Pivot (first unit) is in the rear row.
-- @param listOfUnits [array of unitIDs]
-- @return table with keys `group` (unitID => index) and `formation` (array of Vec3)
return function(listOfUnits)
  local groupDefinition = {}
  local formation = {}

  local spacingX = 1  -- horizontal spacing between columns
  local spacingZ = 1  -- spacing between rows
  local rows = 2
  local columns = math.ceil(#listOfUnits / rows)

  local rowOffsets = { spacingZ, 0, -spacingZ }  -- back, middle, front
  local unitIndex = 1

  for row = 1, rows do
    for col = 1, columns do
      if unitIndex > #listOfUnits then break end

      local unitID = listOfUnits[unitIndex]
      groupDefinition[unitID] = unitIndex
      formation[unitIndex] = Vec3((col - 1) * spacingX, 0, rowOffsets[row])

      unitIndex = unitIndex + 1
    end
  end

  return {
    group = groupDefinition,
    formation = formation
  }
end
