local sensorInfo = {
  name = "RandomUniformPosition",
  desc = "Returns a uniformly random position between two defined points",
  author = "MajdaT + CodeCopilot",
  date = "2025-06-27",
  license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1 -- No caching

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

-- @description: Returns a uniformly random position between two fixed corners
-- @return table with fields x, y, z
return function()
  local minX, maxX = 4865, 5892
  local minY, maxY = 45, 45
  local minZ, maxZ = 4253, 6176

  local x = math.random() * (maxX - minX) + minX
  local y = math.random() * (maxY - minY) + minY
  local z = math.random() * (maxZ - minZ) + minZ

  return {x = x, y = y, z = z}
end
