local sensorInfo = {
  name = "FindBattle",
  desc = "Finds where is the battle",
  author = "MajdaT_ChatGPT",
  date = "2025-06-06",
  license = "notAlicense"
}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load


local EVAL_PERIOD_DEFAULT = -1

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetTeamUnits = Spring.GetTeamUnits
local SpringGetUnitDefID = Spring.GetUnitDefID
local SpringValidUnitID = Spring.ValidUnitID
local UnitDefs = UnitDefs

-- @description: Returns position of the battle
return function(missionInformation)
  
	local position = Vec3(5560,0,4560)
  if (Script.LuaUI('exampleDebug_update')) then
    Script.LuaUI.exampleDebug_update(
      "battle", -- key
      {	-- data
        startPos = position, 
        endPos = position + Vec3(100,0,-100)
      }
    )
  end

  return position
end
