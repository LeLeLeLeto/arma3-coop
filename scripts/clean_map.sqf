/**
	Nettoie la carte
 */

{deleteVehicle _x;} count allDead;
sleep 1;

{deleteVehicle _x;} count (allMissionObjects "CraterLong");
sleep 1;

{deleteVehicle _x;} count (allMissionObjects "WeaponHolder");
sleep 1;

{deleteVehicle _x;} count (allMissionObjects "WeaponHolderSimulated");
sleep 1;

{if ((count units _x) == 0) then {deleteGroup _x;};} count allGroups;
sleep 1;