/**
	Ajoute les unités sur la carte à l'interface Zeus
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
    } forEach vehicles;
  };
	sleep 20;
};