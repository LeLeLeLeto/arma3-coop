/*
Author: 

	Ryan Rodrigo

Last modified: 

	09/08/2022 by [MF] Ricky

Description:

	Boat Attack

*/


_boatpos = [[5523,6500], 0, 6000, 0, 2, 60 * (pi / 180), 0, [], [0,0,0]] call BIS_fnc_findSafePos;


_boatGroup = [];

_boat = createVehicle ["Land_Destroyer_01_base_F", _boatpos, [], 0, "CAN_COLLIDE"];
_boat setPosWorld [getPosWorld _boat select 0, getPosWorld _boat select 1, 0];
_boat setDir 90;

[_boat] call BIS_fnc_destroyer01PosUpdate;

_boatGroup = _boatGroup + [_boat];


//------------------Set Objective-------------------------------
	sleep 2;
	[west, ["ATTAQUERLEBATEAU"], ["Un bateau CSAT a jeté l'ancre le long des côtes de Malden. Prenez le d'assault et neutralisez l'équipage avant qu'il ne puisse nous attaquer.", "Attaquer le bateau"], getPos _boat,"Created",0,true,"boat",true] call BIS_fnc_taskCreate;
	BATEAUMissionUp = true; publicVariable "BATEAUMissionUp";
	BATEAU_SUCCESS = false; publicVariable "BATEAU_SUCCESS";
//------------------Spawn Marine Protection---------------------

_divergroup = [];
_random = 0;
_random2 = 0;
// Diver Teams
for "_i" from 0 to 2 do {	
	_random = (round(random 100) + 100);
	sleep 0.2;
	_random2 = (round(random 100) + 100);
	_patrolMarineLocation = [getPos _boat, 0, 250, 1, 2, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_patrolMarineGroup = [_patrolMarineLocation, OPFOR, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
	_patrolMarineGroup setFormation "DIAMOND";
	_patrolMarineGroup setBehaviour "SAFE";
	_patrolMarineGroup setSpeedMode "LIMITED";
	_wp1 =_patrolMarineGroup addWaypoint [[(getPos _boat select 0) + _random, (getPos _boat select 1) - _random], 200];
	_wp2 =_patrolMarineGroup addWaypoint [[(getPos _boat select 0) - _random2, (getPos _boat select 1) + _random2], 200];
	_wp4 =_patrolMarineGroup addWaypoint [_patrolMarineLocation, 140];
	_wp4 setWaypointType "CYCLE";
	_divergroup = _divergroup + ( units _patrolMarineGroup);
	{_x addCuratorEditableObjects [units _patrolMarineGroup, false];} forEach allCurators;
};

//---------------------ArmedBoat Teams--------------------
_patrolBoatGroup = [];


for "_i" from 0 to 1 do {
	
	_random = (round(random 500) + 500);
	sleep 0.2;
	_random2 = (round(random 500) + 500);
	_patrolBoatLocation = [getPos _boat, 500, 1000, 1, 2, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_patrolBoat = "O_Boat_Armed_01_hmg_F" createVehicle _patrolBoatLocation;
	_patrolBoat limitSpeed 40;
	_patrolBoatCrew = createVehicleCrew _patrolBoat;
	_patrolBoatCrew setBehaviour "SAFE";
	_patrolBoatCrew setSpeedMode "LIMITED";
	_wp1 =_patrolBoatCrew addWaypoint [[(getPos _boat select 0) + _random, (getPos _boat select 1) - _random], 100];
	_wp2 =_patrolBoatCrew addWaypoint [[(getPos _boat select 0) - _random2, (getPos _boat select 1) + _random2], 100];
	_wp4 =_patrolBoatCrew addWaypoint [_patrolBoatLocation, 140];
	_wp4 setWaypointType "CYCLE";
	_patrolBoatGroup = _patrolBoatGroup + (units _patrolBoatCrew);
	_boatGroup = _boatGroup + [_patrolBoat];
	{_x addCuratorEditableObjects [units _patrolBoatCrew, false];} forEach allCurators;	
};
//-----------------------Heli Patrol---------------------
_heliPatrolLocation = [getPos _boat, 0, 250, 1, 2, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
_heliPatrol = createVehicle ["O_Heli_Light_02_dynamicLoadout_F", _heliPatrolLocation, [], 0, "FLY"];
_heliGroup = createVehicleCrew _heliPatrol;
_heliGroup setBehaviour "SAFE";
_heliGroup setSpeedMode "LIMITED";

_random = (round(random 600) + 600);
_wp1H =_heliGroup addWaypoint [[(getPos _boat select 0) + _random, (getPos _boat select 1) - _random], 800];
_wp2H =_heliGroup addWaypoint [[(getPos _boat select 0) - _random2, (getPos _boat select 1) + _random2], 800];
_wp4H =_heliGroup addWaypoint [_heliPatrolLocation, 800];
_wp5H =_heliGroup addWaypoint [_heliPatrolLocation, 1200];
_wp6H =_heliGroup addWaypoint [_heliPatrolLocation, 1200];
_wp6H setWaypointType "CYCLE";
_marinegroup = _marinegroup + (units _heliGroup);
_boatGroup = _boatGroup + [_heliPatrol];
	
{_x addCuratorEditableObjects [units _heliGroup, false];} forEach allCurators;
{_x addCuratorEditableObjects [_boatGroup, false];} foreach allCurators;
//----------------------Boat Garrison--------------------

_MarineUnits = ["O_soldierU_medic_F","O_soldierU_AR_F","O_soldierU_M_F","O_soldierU_F","O_SoldierU_SL_F","O_soldierU_LAT_F","O_soldierU_TL_F","O_soldierU_A_F"];	
_Marinegroup = createGroup EAST;

_MarineLocation1 = [(getPos _boat select 0) + 90, (getPos _boat select 1) + 10, (getPos _boat select 2) + 10];
_MarineUnit1 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation1, [], 0, "NONE"];
_MarineUnit1 disableAI "PATH";
_MarineUnit1 setUnitPos "UP";


_MarineLocation2 = [(getPos _boat select 0) + 90, (getPos _boat select 1) - 10, (getPos _boat select 2) + 10];
_MarineUnit2 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation2, [], 0, "NONE"];
_MarineUnit2 disableAI "PATH";
_MarineUnit2 setUnitPos "UP";


_MarineLocation3 = [(getPos _boat select 0) + 61, (getPos _boat select 1) + 13, (getPos _boat select 2) + 10];
_MarineUnit3 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation3, [], 0, "NONE"];
_MarineUnit3 disableAI "PATH";
_MarineUnit3 setUnitPos "UP";

_MarineLocation4 = [(getPos _boat select 0) + 68, (getPos _boat select 1) - 7, (getPos _boat select 2) + 10];
_MarineUnit4 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation4, [], 0, "NONE"];
_MarineUnit4 disableAI "PATH";
_MarineUnit4 setUnitPos "UP";

_MarineLocation5 = [(getPos _boat select 0) + 53, (getPos _boat select 1) + 14, (getPos _boat select 2) + 10];
_MarineUnit5 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation5, [], 0, "NONE"];
_MarineUnit5 disableAI "PATH";
_MarineUnit5 setUnitPos "UP";

_MarineLocation6 = [(getPos _boat select 0) + 53, (getPos _boat select 1) - 8, (getPos _boat select 2) + 10];
_MarineUnit6 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation6, [], 0, "NONE"];
_MarineUnit6 disableAI "PATH";
_MarineUnit6 setUnitPos "UP";	

_MarineLocation7 = [(getPos _boat select 0) + 46, (getPos _boat select 1) -2, (getPos _boat select 2) + 10];
_MarineUnit7 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation7, [], 0, "NONE"];
_MarineUnit7 disableAI "PATH";
_MarineUnit7 setUnitPos "UP";

_MarineLocation8 = [(getPos _boat select 0) + 40, (getPos _boat select 1) + 8, (getPos _boat select 2) + 12];
_MarineUnit8 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation8, [], 0, "NONE"];
_MarineUnit8 disableAI "PATH";
_MarineUnit8 setUnitPos "UP";

_MarineLocation9 = [(getPos _boat select 0) + 23, (getPos _boat select 1), (getPos _boat select 2) + 10];
_MarineUnit9 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation9, [], 0, "NONE"];
_MarineUnit9 disableAI "PATH";
_MarineUnit9 setUnitPos "UP";

_MarineLocation10 = [(getPos _boat select 0) + 13, (getPos _boat select 1), (getPos _boat select 2) + 7];
_MarineUnit10 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation10, [], 0, "NONE"];
_MarineUnit10 disableAI "PATH";
_MarineUnit10 setUnitPos "UP";

_MarineLocation11 = [(getPos _boat select 0) + 17, (getPos _boat select 1) - 10, (getPos _boat select 2) + 7];
_MarineUnit11 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation11, [], 0, "NONE"];
_MarineUnit11 disableAI "PATH";
_MarineUnit11 setUnitPos "UP";	

_MarineLocation12 = [(getPos _boat select 0) + 10, (getPos _boat select 1) - 12, (getPos _boat select 2) + 7];
_MarineUnit12 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation12, [], 0, "NONE"];
_MarineUnit12 disableAI "PATH";
_MarineUnit12 setUnitPos "UP";

_MarineLocation13 = [(getPos _boat select 0) + 17, (getPos _boat select 1) + 10, (getPos _boat select 2) + 7];
_MarineUnit13 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation13, [], 0, "NONE"];
_MarineUnit13 disableAI "PATH";
_MarineUnit13 setUnitPos "UP";	

_MarineLocation14 = [(getPos _boat select 0) + 10, (getPos _boat select 1) + 13, (getPos _boat select 2) + 7];
_MarineUnit14 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation14, [], 0, "NONE"];
_MarineUnit14 disableAI "PATH";
_MarineUnit14 setUnitPos "UP";

_MarineLocation15 = [(getPos _boat select 0), (getPos _boat select 1), (getPos _boat select 2) + 7];
_MarineUnit15 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation15, [], 0, "NONE"];
_MarineUnit15 disableAI "PATH";
_MarineUnit15 setUnitPos "UP";

_MarineLocation16 = [(getPos _boat select 0) - 14, (getPos _boat select 1) - 1, (getPos _boat select 2) + 7];
_MarineUnit16 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation16, [], 0, "NONE"];
_MarineUnit16 disableAI "PATH";
_MarineUnit16 setUnitPos "UP";

_MarineLocation17 = [(getPos _boat select 0) - 21, (getPos _boat select 1) - 1, (getPos _boat select 2) + 12];
_MarineUnit17 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation17, [], 0, "NONE"];
_MarineUnit17 disableAI "PATH";
_MarineUnit17 setUnitPos "UP";

_MarineLocation18 = [(getPos _boat select 0) - 35, (getPos _boat select 1), (getPos _boat select 2) + 12];
_MarineUnit18 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation18, [], 0, "NONE"];
_MarineUnit18 disableAI "PATH";
_MarineUnit18 setUnitPos "UP";

_MarineLocation19 = [(getPos _boat select 0) - 39, (getPos _boat select 1) + 6, (getPos _boat select 2) + 12];
_MarineUnit19 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation19, [], 0, "NONE"];
_MarineUnit19 disableAI "PATH";
_MarineUnit19 setUnitPos "UP";

_MarineLocation20 = [(getPos _boat select 0) - 41, (getPos _boat select 1) - 8, (getPos _boat select 2) + 12];
_MarineUnit20 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation20, [], 0, "NONE"];
_MarineUnit20 disableAI "PATH";
_MarineUnit20 setUnitPos "UP";

_MarineLocation21 = [(getPos _boat select 0) - 80, (getPos _boat select 1), (getPos _boat select 2) + 16];
_MarineUnit21 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation21, [], 0, "NONE"];
_MarineUnit21 disableAI "PATH";
_MarineUnit21 setUnitPos "UP";

_MarineLocation22 = [(getPos _boat select 0) - 108, (getPos _boat select 1), (getPos _boat select 2) + 17];
_MarineUnit22 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation22, [], 0, "NONE"];
_MarineUnit22 disableAI "PATH";
_MarineUnit22 setUnitPos "UP";
				
_MarineLocation23 = [(getPos _boat select 0) - 31, (getPos _boat select 1) - 5, (getPos _boat select 2) + 20];
_MarineUnit23 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation23, [], 0, "NONE"];
_MarineUnit23 disableAI "PATH";
_MarineUnit23 setUnitPos "UP";

_MarineLocation24 = [(getPos _boat select 0) - 27, (getPos _boat select 1) - 4, (getPos _boat select 2) + 18];
_MarineUnit24 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation24, [], 0, "NONE"];
_MarineUnit24 disableAI "PATH";
_MarineUnit24 setUnitPos "UP";

_MarineLocation23 = [(getPos _boat select 0) - 31, (getPos _boat select 1) - 5, (getPos _boat select 2) + 15];
_MarineUnit23 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation23, [], 0, "NONE"];
_MarineUnit23 disableAI "PATH";
_MarineUnit23 setUnitPos "UP";

_MarineLocation23 = [(getPos _boat select 0) - 42, (getPos _boat select 1) - 4, (getPos _boat select 2) + 20];
_MarineUnit23 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation23, [], 0, "NONE"];
_MarineUnit23 disableAI "PATH";
_MarineUnit23 setUnitPos "UP";


_MarineLocation24 = [(getPos _boat select 0) - 37, (getPos _boat select 1) - 2, (getPos _boat select 2) + 20];
_MarineUnit24 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation24, [], 0, "NONE"];
_MarineUnit24 disableAI "PATH";
_MarineUnit24 setUnitPos "UP";


_MarineLocation25 = [(getPos _boat select 0) - 37, (getPos _boat select 1) + 4, (getPos _boat select 2) + 20];
_MarineUnit25 = _Marinegroup createUnit [selectRandom _MarineUnits, _MarineLocation25, [], 0, "NONE"];
_MarineUnit25 disableAI "PATH";
_MarineUnit25 setUnitPos "UP";
				
{_x addCuratorEditableObjects [units _MarineGroup, false];} forEach allCurators;
{_x addCuratorEditableObjects [_boatGroup, false];} foreach allCurators;

//----------------Task State + Wrecks Deleting-----------------------
while { BATEAUMissionUp } do {
	
	if ({alive _x} count units _Marinegroup < 1) then {
		BATEAUMissionUp = false; publicVariable "BATEAUMissionUp";
		["ATTAQUERLEBATEAU", "SUCCEEDED"] call BIS_fnc_taskSetState;
		sleep 3;
		["ATTAQUERLEBATEAU"] call BIS_fnc_deleteTask;
		sleep 900;
		_boat call bis_fnc_Destroyer01EdenDelete;
		{ deleteVehicle _x; sleep 0.1;} forEach units _heliGroup;
		{ deleteVehicle _x; sleep 0.1;} forEach _boatGroup;
		{ deleteVehicle _x; sleep 0.1;} forEach units _Marinegroup;
		{ deleteVehicle _x; sleep 0.1;} forEach _divergroup;
		{ deleteVehicle _x; sleep 0.1;} forEach _patrolBoatGroup;
		
	};
};









