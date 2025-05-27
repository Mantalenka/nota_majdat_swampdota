local sensorInfo = {
  name = "ComputeAtlasPoint",
  desc = "Compute atlas landing point based on previous trajectory",
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

local SpringGetUnitPosition = Spring.GetUnitPosition

-- @description: Computes a landing point 250 units backwards from safeArea along trajectory
-- @argument atlasID [number] - ID atlas
-- @argument safeArea [table] - table { center = {x, y, z}, radius = number }
-- @return atlasPoint [table] - position of arrive (250 points before safeArea)
return function(atlasID, safeArea)
  -- if not atlasID or not safeArea or not safeArea.center then return nil end
  -- Spring.Echo("atlasID: ", atlasID, " safeArea.center: ", safeArea.center, " safeArea.radius: ", safeArea.radius)
  return {safeArea.center} end

  -- local sx, sy, sz = SpringGetUnitPosition(atlasID)
  -- if not sx then return nil end

  -- local ex, ey, ez = safeArea.center.x, safeArea.center.y, safeArea.center.z

  -- Vektor směru letu
  -- local dx = ex - sx
  -- local dy = ey - sy
  -- local dz = ez - sz

  -- local length = math.sqrt(dx*dx + dy*dy + dz*dz)
  -- if length == 0 then return nil end

  -- local normX = dx / length
  -- local normY = dy / length
  -- local normZ = dz / length

  -- Krok zpět o 250 bodů
  -- local backX = ex - normX * 250
  -- local backY = ey - normY * 250
  -- local backZ = ez - normZ * 250

  -- return { backX, backY, backZ }
-- end
