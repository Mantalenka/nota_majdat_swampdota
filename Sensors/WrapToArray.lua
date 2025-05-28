local sensorInfo = {
  name = "WrapToArray",
  desc = "Wraps a single value or a table with one element into a table with one element at index 1.",
  author = "MajdaT_ChatGPT",
  date = "2025-05-28",
  license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

-- @description: Ensure the output is a table with one element at [1]
-- @argument input [number or table]
-- @return table [with single element at index 1]
return function(input)
  if type(input) == "table" then
    return { input[1] }
  else
    return { input }
  end
end
