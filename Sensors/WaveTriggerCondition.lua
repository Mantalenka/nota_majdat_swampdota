local sensorInfo = {
  name = "WaveTriggerCondition",
  desc = "Trigger wave if a strongpoint was conquered or 7s passed since last wave",
  author = "MajdaT_ChatGPT",
  date = "2025-06-27",
  license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetGameFrame = Spring.GetGameFrame

-- @description Checks whether to trigger new wave
-- @argument strongPoint [number] - number of conquered points in last wave
-- @argument waveTime [number|nil] - time (s) of last wave
-- @argument mlinfo [table] - current info with field `goodStrongpoints`
-- @return boolean - true if new wave should be triggered
return function(strongPoint, waveTime, mlinfo)
  if mlinfo.goodStrongpoints > strongPoint then
    return true
  end

  if waveTime == nil then
    return false
  end

  local currentTime = SpringGetGameFrame() / 30
  return (currentTime - waveTime) > 380
end
