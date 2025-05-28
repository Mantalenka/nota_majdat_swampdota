local sensorInfo = {
  name = "ComputeAtlasPoint",
  desc = "Compute atlas landing point based on previous trajectory",
  author = "MajdaT_ChatGPT",
  date = "2025-05-27",
  license = "none"
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetUnitPosition = Spring.GetUnitPosition

-- @description: Computes a landing point 500 units backwards from given target position
-- @argument atlasID [number] - ID atlas
-- @argument targetPos [table] - Vec3-like {x, y, z}
-- @return atlasPoint [table] - position 500 units before targetPos on previous trajectory
return function(atlasID, targetPos)
  -- Spring.Echo("Hello, atlasID: ", atlasID)
  if not atlasID or not targetPos then return nil end
  --Spring.Echo("Hello, atlasID: ", atlasID)
  local sx, sy, sz = Spring.GetUnitPosition(atlasID)
  if not sx then return nil end
  
  local ex = targetPos.x or targetPos[1]
  local ey = targetPos.y or targetPos[2]
  local ez = targetPos.z or targetPos[3]

  -- Vektor směru letu
  local dx = ex - sx
  local dy = ey - sy
  local dz = ez - sz

  local length = math.sqrt(dx*dx + dy*dy + dz*dz)
  if length == 0 then return nil end

  local normX = dx / length
  local normY = dy / length
  local normZ = dz / length

  -- Krok zpět o 500 bodů
  local backX = ex - normX * 500
  local backY = ey - normY * 500
  local backZ = ez - normZ * 500
  -- Spring.Echo("backX: ", backX, " backY: ", backY, " backZ: ", backZ)

  return { x = backX, y = backY, z = backZ }
end
