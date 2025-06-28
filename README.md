nota_majdat_swampdota 8.0.0
====

* [dependencies](./dependencies.json)


Behaviours
---

* OneWayBoxDelivery

Transports a non-movable unit to a specified drop-off location using an atlas unit.
After unloading, the atlas retreats 1200 units back along its previous approach path.
Ensures clean delivery and repositioning without redundant waiting.
In behaviour use this nodes: nota_kahlan_ttdr.loadUnit, nota_kahlan_ttdr.moveUnitTo, nota_majdat_swampdota.unloadUnit_repair_kahlan
- argument: position_for_box (position)
- argument: atlasID (UnitID)
- argument: box_of_deathID (UnitID)
- argument: only_one (variable, boolean)		- if true is only one use this behaviour (this node) in all project


* find_atlas_and_box_then_move

Find one idle atlas and type_of_unit (in version 1.0 only box_of_death) nearest metal storage and moved tu target position
if there is no idle atlas, it will wait for it
- argument: position_for_box (position)
- argument: type_of_unit (variable, string)
- argument: only_one (variable, boolean)		- if true is only one use this behaviour (this node) in all project


* buy_unit_safely

Check if the player has enough metal and if so, use hlaa_nota_zivnusmEXAM.buyUnit
- argument: type_of_unit (variable, string)
- argument: only_one (variable, boolean)		- if true is only one use this behaviour (this node) in all project


* find_unit_in_base_or_buy
Use FindIdleUnitInBase, if not exist buy unit
- argument: type_of_unit
- argument: inBase (variable, boolean) 			- if true, search only in base, otherwise also outside
- return(output): unitID


* MoveBoxOfDeath_toStaticPredefinedPosition

Predefine static position for box (store) and use find_atlas_and_box_then_move 


* MoveSeer_toStaticPredefinedPosition

Predefine static position for seer (store) and use find_atlas_and_box_then_move 


* root

Runs all relevant trees, in this order:
> buy 1 armseer (use buy_unit_safely)
> buy 1 armbox  (use buy_unit_safely)
> parallel - all succes:
>> move one (random) armbox (use find_atlas_and_box_then_move)
>> move one (random) armseer (use find_atlas_and_box_then_move)
>> move one (random) armbox (use find_atlas_and_box_then_move)
> repeat:
>> find or buy armfark (use find_unit_in_base_or_buy)
>> nota_mestek_labs.collectMetal (go to fight, and collect metal, if he died -> buy new fark and repeat)


* root_automatickly

Implement "while cyklus" from elements in table (generate by DefinitionOfPositionForAllUnits)
item in table is numbering tables: 1 = {"variant = "type_of_unit", position = Vec3(position_x, position_y, position_z) }
Iterate from this teble, find unit in base or buy unit, and transported to define position.
ONLY SEQUENTLY TRANSPORED UNIT (not use more then 1 atlas at the same time)
!(Use lua_condition node with checkbox repeat before repeat node, then implement "while cyklus")


* root_with_maverick

This is an enhanced version of the root behavior with additional Maverick logic for the late game.
- Whenever a new StrongPoint is captured or 380 seconds have passed since the last wave, a Maverick wave is triggered.
- Available Maverick units are positioned near the center of the map.
- After the first StrongPoint is captured, the script waits 70 seconds, then moves the Box of Death units further along the battle path.


Commands
---

* unloadUnit_repair_kahlan

She take not existing MissionInfo.safeArea in unloadUnit, chatGPT repair this bug in my command.


* moveCustomGroup_dynamically_swith_pivot

Is moveCustomGroup, but if die pivot, then dynamically use other unit and go to position.


* fightToPosition_oneUnit

Is not corect code


* MoveSingleUnit

Moves single unit to given position with optional fight mode. 
Returns SUCCESS if unit arrives close enough, or after increasing threshold timeout.


Sensors
---

* ComputeAtlasPoint
- argument: atlasID
- argument: targetPos
- argument: distance 	-- count of points (backward)
Calculates the return of the atlas back along its original trajectory by <distance> points


* FindIdleAtlas


* FindNearestBoxOfDeath

Find type_of_unit (in version 1.0 only box_of_death) and move this unit.
It nearest from Metal Storage
- argument: type_of_unit (variable, string)


* FindIdleUnitInBase

Find unit in base (is z left down corner (x > 249 and x < 2513) & (z > 7640 and z < 9978))
- argument: type_of_unit
- argument: inBase (boolean)		- if true, search only in base, otherwise also outside


* FindAllArmMav


* WrapToArray 				

convert to Array (Number or Array with only one number (1 = number),
because manually entering the position generates an array of one element)
- argument: input 		- number or table input


* DefinitionOfPositionForAllUnits

Return static table, that define static position for unit types


* ComputeAtlasReturnToBase

- argument: atlasID
- argument: targetPos
- argument: distance		- how far to move back toward base


* formation_3lines

- argument: listOfUnits

* RandomUnitPosition

Returns uniform random position from static line (default values configured)


* WaveTrigegerCondition

Returns true if:
new strongpoint conquered (mlinfo.goodStrongpoints > strongPoint)
or more than 380s passed since last waveTime
- argument: strongPoint 	- number of strongPoints captured during the previous wave
- argument: waveTime		- time of my last Maverick wave
- argument: mlinfo			- core.MissionInfo


* StrongpointAreaSensor_FARK

Returns static areas for metal collection based on strongpoint count.
- argument: goodStrongpoints (count of my strongPoint)