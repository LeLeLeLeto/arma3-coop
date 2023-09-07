/**
	Ajoute les unités sur la carte à l'interface Zeus toutes les 60 secondes (1 minute)
 */

while {true} do {
    if (isServer) then {
      {
        _x addCuratorEditableObjects [allUnits,true];
        _x addCuratorEditableObjects [vehicles,true];
        _x addCuratorEditableObjects [allMissionObjects "All",true];
      } forEach allCurators;            
    };
	sleep 60;
};