-- modified moveCustomGroup to dynamically switch pivot on death

function getInfo()
	return {
		onNoUnits = SUCCESS,
		tooltip = "Move custom group to defined position. Group is defined by table of unitID => formationIndex.",
		parameterDefs = {
			{ name = "groupDefintion", variableType = "expression", componentType = "editBox", defaultValue = "", },
			{ name = "position", variableType = "expression", componentType = "editBox", defaultValue = "", },
			{ name = "formation", variableType = "expression", componentType = "editBox", defaultValue = "<relative formation>", },
			{ name = "fight", variableType = "expression", componentType = "editBox", defaultValue = "false", }
		}
	}
end

local THRESHOLD_STEP = 25
local THRESHOLD_DEFAULT = 0

local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringValidUnitID = Spring.ValidUnitID

local function ClearState(self)
	self.threshold = THRESHOLD_DEFAULT
	self.lastPointmanPosition = Vec3(0,0,0)
end

function Run(self, units, parameter)
	local customGroup = parameter.groupDefintion
	local position = parameter.position
	local formation = parameter.formation
	local fight = parameter.fight
	local cmdID = fight and CMD.FIGHT or CMD.MOVE

	-- choose new pivot dynamically by formation index and y position
	local pointmanID = nil
	local minIndex = math.huge
	local maxY = -math.huge

	for unitID, posIndex in pairs(customGroup) do
		if SpringValidUnitID(unitID) then
			local y = select(3, SpringGetUnitPosition(unitID))
			if posIndex < minIndex or (posIndex == minIndex and y > maxY) then
				minIndex = posIndex
				maxY = y
				pointmanID = unitID
			end
		end
	end

	if not pointmanID then return FAILURE end

	local px, py, pz = SpringGetUnitPosition(pointmanID)
	local pointmanPosition = Vec3(px, py, pz)

	if (pointmanPosition == self.lastPointmanPosition) then
		self.threshold = self.threshold + THRESHOLD_STEP
	else
		self.threshold = THRESHOLD_DEFAULT
	end
	self.lastPointmanPosition = pointmanPosition

	local pointmanOffset = formation[minIndex]
	local pointmanWantedPosition = position + pointmanOffset

	if (pointmanPosition:Distance(pointmanWantedPosition) < self.threshold) then
		return SUCCESS
	end

	SpringGiveOrderToUnit(pointmanID, cmdID, pointmanWantedPosition:AsSpringVector(), {})

	for unitID, posIndex in pairs(customGroup) do
		if unitID ~= pointmanID and SpringValidUnitID(unitID) then
			local thisUnitWantedPosition = pointmanPosition - pointmanOffset + formation[posIndex]
			SpringGiveOrderToUnit(unitID, cmdID, thisUnitWantedPosition:AsSpringVector(), {})
		end
	end

	return RUNNING
end

function Reset(self)
	ClearState(self)
end
