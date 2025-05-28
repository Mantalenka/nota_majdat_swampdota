swampdota
====

* [dependencies](./dependencies.json)


Behaviours
---

* OneWayBoxDelivery

Transports a non-movable unit to a specified drop-off location using an atlas unit. After unloading, the atlas retreats 250 units back along its previous approach path. Ensures clean delivery and repositioning without redundant waiting.
- argument: position_for_box (position)
- argument: atlasID (UnitID)
- argument: box_of_deathID (UnitID)



Commands
---

* unloadUnit_repair_kahlan

She take not existing MissionInfo.safeArea in unloadUnit, chatGPT repair this bug in my command.

Sensors
---

* ComputeAtlasPoint

Calculates the return of the atlas back along its original trajectory by 250 points
