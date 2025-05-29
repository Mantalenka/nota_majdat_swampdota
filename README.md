nota_majdat_swampdota 2.0.0
====

* [dependencies](./dependencies.json)


Behaviours
---

* OneWayBoxDelivery

Transports a non-movable unit to a specified drop-off location using an atlas unit.
After unloading, the atlas retreats 500 units back along its previous approach path.
Ensures clean delivery and repositioning without redundant waiting.
In behaviour use this nodes: nota_kahlan_ttdr.loadUnit, nota_kahlan_ttdr.moveUnitTo, nota_majdat_swampdota.unloadUnit_repair_kahlan
- argument: position_for_box (position)
- argument: atlasID (UnitID)
- argument: box_of_deathID (UnitID)


* find_atlas_and_box_then_move

Find one idle atlas and type_of_unit (in version 1.0 only box_of_death) nearest metal storage and moved tu target position
- argument: position_for_box (position)
- argument: type_of_unit (variable, string)


* buy_unit_safely

Check if the player has enough metal and if so, use hlaa_nota_zivnusmEXAM.buyUnit
- argument: type_of_unit (variable, string)


* MoveBoxOfDeath_toStaticPredefinedPosition

Predefine static position for box (store) and use find_atlas_and_box_then_move 

* MoveSeer_toStaticPredefinedPosition

Predefine static position for seer (store) and use find_atlas_and_box_then_move 

* root

Runs all relevant trees

Commands
---

* unloadUnit_repair_kahlan

She take not existing MissionInfo.safeArea in unloadUnit, chatGPT repair this bug in my command.

Sensors
---

* ComputeAtlasPoint

Calculates the return of the atlas back along its original trajectory by 250 points

* FindIdleAtlas

* FindNearestBoxOfDeath

Find type_of_unit (in version 1.0 only box_of_death) and move this unit.
It nearest from Metal Storage
- argument: type_of_unit (variable, string)


* WrapToArray 				

convert to Array (Number or Array with only one number (1 = number),
because manually entering the position generates an array of one element)