/**
	S'applique à toutes les unités périodiquement
 */

while {true} do {
  if (isServer) then {
    {
      _x addCuratorEditableObjects [allUnits,true];
      _x addCuratorEditableObjects [vehicles,true];
      _x addCuratorEditableObjects [allMissionObjects "All",true];
    } forEach allCurators;
  };

  // Déverrouille tous les véhicules sur la map
  if (isServer) then {
    {
      _x setVehicleLock "UNLOCKED";
      if (fuel _x < 0.1) then { _x setFuel 1; };
    } forEach vehicles;
  };
	sleep 20;
};