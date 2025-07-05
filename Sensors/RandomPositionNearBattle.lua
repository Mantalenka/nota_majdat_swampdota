-- RandomPositionNearBattle: returns random position near offset battle zone

local sensorInfo = {
  name = "RandomPositionNearBattle",
  desc = "Returns a uniformly random position offset from the battle location",
  author = "MajdaT + CodeCopilot",
  date = "2025-06-30",
  license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1 -- No caching

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

-- @argument battlePos [Vec3] - battle position
-- @return Vec3 - randomized position around offset area
return function(battlePos)
  if not battlePos or not battlePos.x then return {x=0, y=0, z=0} end

  local baseOffset = Vec3(-1000, 0, 1000)
  local center = battlePos + baseOffset

  local offsetX = math.random(-513, 513)
  local offsetZ = math.random(-961, 961)

  return {
    x = center.x + offsetX,
    y = center.y,
    z = center.z + offsetZ
  }
end
