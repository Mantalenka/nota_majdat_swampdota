local sensorInfo = {
  name = "ComputeAtlasReturnToBase",
  desc = "Compute return point for Atlas back towards base",
  author = "MajdaT_ChatGPT",
  date = "2025-06-06",
  license = "none"
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetUnitPosition = Spring.GetUnitPosition

-- @description: Computes a landing point <distance> units in direction toward base
-- @argument atlasID [number] - ID atlas
-- @argument targetPos [table] - Vec3-like {x, y, z}
-- @argument distance [number] - how far to move back toward base
-- @return Vec3-like table with return point
return function(atlasID, targetPos, distance)
  if not atlasID or not targetPos then return nil end

  local sx, sy, sz = SpringGetUnitPosition(atlasID)
  if not sx then return nil end

  local ex = targetPos.x or targetPos[1]
  local ey = targetPos.y or targetPos[2]
  local ez = targetPos.z or targetPos[3]

  -- Base bounds
  local baseCenterX, baseCenterZ = (249 + 2513) / 2, (7640 + 9978) / 2

  -- Direction to base
  local dx = baseCenterX - ex
  local dy = 0 -- ignore altitude
  local dz = baseCenterZ - ez

  local length = math.sqrt(dx*dx + dz*dz)
  if length == 0 then return nil end

  local normX = dx / length
  local normZ = dz / length

  local retX = ex + normX * distance
  local retY = ey
  local retZ = ez + normZ * distance

  return { x = retX, y = retY, z = retZ }
end
