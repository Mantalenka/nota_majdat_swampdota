local sensorInfo = {
  name = "MakeSafeArea",
  desc = "Create a safeArea object from given position",
  author = "MajdaT_ChatGPT",
  date = "2025-05-13",
  license = "none"
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

-- @description: Creates a minimal safeArea from given position
-- @argument pos [table] - table {x = number, y = number, z = number} or array-like {x, y, z}
-- @return safeArea [table] - { center = pos, radius = 1 }
return function(pos)
  if not pos then return nil end

  -- handle both {x=..,y=..,z=..} and {x, y, z} formats
  local x = pos.x or pos[1]
  local y = pos.y or pos[2]
  local z = pos.z or pos[3]
  --Spring.Echo("Debug: pozice je", x, y, z)

  if not x or not y or not z then return nil end

  return {
    center = { x = x, y = y, z = z },
    radius = 1
  }
end
