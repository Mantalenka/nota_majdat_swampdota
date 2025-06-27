local sensorInfo = {
  name = "StrongpointAreaSensor_FARK",
  desc = "Returns area definition based on number of good strongpoints",
  author = "MajdaT + CodeCopilot",
  date = "2025-06-27",
  license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

-- @description: Returns area based on strongpoint count
-- @argument goodStrongpoints [number] - current count of good strongpoints
-- @return area [table] - {center = Vec3, radius = number} or nil
return function(goodStrongpoints)
  if goodStrongpoints == 9 then
    return { center = Vec3(4900, 40, 5000), radius = 1000 }
  elseif goodStrongpoints == 10 then
    return { center = Vec3(5700, 45, 4250), radius = 1000 }
  else
    return { center = Vec3(6641, 45, 3347), radius = 1000 }
  end
end
