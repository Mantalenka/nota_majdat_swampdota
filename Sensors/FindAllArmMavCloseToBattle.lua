local sensorInfo = {
  name = "FindAllArmMavCloseToBattle",
  desc = "Returns a list of all existing armmav unit IDs for current team.",
  author = "MajdaT_ChatGPT",
  date = "2025-06-06",
  license = "notAlicense"
}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

local EVAL_PERIOD_DEFAULT = 1 -- update every frame

function getInfo()
  return {
    period = EVAL_PERIOD_DEFAULT
  }
end

local SpringGetTeamUnits = Spring.GetTeamUnits
local SpringGetUnitDefID = Spring.GetUnitDefID
local SpringValidUnitID = Spring.ValidUnitID
local UnitDefs = UnitDefs

-- @description: Returns list of unit IDs of all alive "armmav" units
-- @return [table<number>] - list of unitIDs
return function(position, radius)
  local myTeamID = Spring.GetMyTeamID()
  local units = SpringGetTeamUnits(myTeamID)
  local result = {}

  for i = 1, #units do
    local unitID = units[i]
    if SpringValidUnitID(unitID) then
      local defID = SpringGetUnitDefID(unitID)
      local x,y,z = Spring.GetUnitPosition(unitID)
      local unitPosition = Vec3(x,y,z)
      if 
        defID and 
        UnitDefs[defID].name == "armmav" and
        position:Distance(unitPosition) < radius
      then
        result[#result+1] = unitID
      end
    end
  end
  
  local topLeftCorner = position + Vec3(-radius, 0, - radius) 
  local topRightCorner = position + Vec3(radius, 0, - radius) 
  local bottomRightCorner = position + Vec3(radius, 0, radius) 
  local bottomLeftCorner = position + Vec3(-radius, 0, radius) 
  if (Script.LuaUI('exampleDebug_update')) then
    Script.LuaUI.exampleDebug_update(
      "top", -- key
      {	-- data
        startPos = topLeftCorner, 
        endPos = topRightCorner
      }
    )
    Script.LuaUI.exampleDebug_update(
      "right", -- key
      {	-- data
        startPos = topRightCorner, 
        endPos = bottomRightCorner
      }
    )
    Script.LuaUI.exampleDebug_update(
      "bottom", -- key
      {	-- data
        startPos = bottomRightCorner, 
        endPos = bottomLeftCorner
      }
    )
    Script.LuaUI.exampleDebug_update(
      "left", -- key
      {	-- data
        startPos = bottomLeftCorner, 
        endPos = topLeftCorner
      }
    )
  end

  return result
end
