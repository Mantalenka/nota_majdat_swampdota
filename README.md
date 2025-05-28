swampdota_majdaT 1.0
====

* [dependencies](./dependencies.json)


Behaviours
---

* OneWayBoxDelivery

Transports a non-movable unit to a specified drop-off location using an atlas unit.
After unloading, the atlas retreats 500 units back along its previous approach path.
Ensures clean delivery and repositioning without redundant waiting.
- argument: position_for_box (position)
- argument: atlasID (UnitID)
- argument: box_of_deathID (UnitID)


* find_atlas_and_box_then_move

Find one idle atlas and box nearest metal storage and moved tu target position
- argument: position_for_box (position)

* MoveBoxOfDeath_toStaticPredefinedPosition

Predefine static position for box (store) and use find_atlas_and_box_then_move 


Commands
---

* unloadUnit_repair_kahlan

She take not existing MissionInfo.safeArea in unloadUnit, chatGPT repair this bug in my command.

Sensors
---

* ComputeAtlasPoint

Calculates the return of the atlas back along its original trajectory by 250 points

* FindIdleAtlas

* FindNearestBoxOfDeath   	-- to my Metal Storage

* WrapToArray 				

convert to Array (Number or Array with only one number (1 = number),
because manually entering the position generates an array of one element)