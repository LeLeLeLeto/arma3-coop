/*
Last modified: 

	12 Novembre 2022 by [MF] Ricky

Description:

	Mission Arty

*/
private ["_flatPos","_accepted","_position","_fuzzyPos","_x","_briefing","_completeText","_PTdir","_dir","_pos","_flatPos1","_flatPos2","_flatPos3","_c","_radius","_unit","_targetPos","_firingMessages","_ArtyMan1","_ArtyMan2"];

Artyunits = [];
Artyunits_veh = [];
Artyunits_squad = [];



//-------------------- FIND POSITION FOR OBJECTIVE

	_flatPos = [[9938,18283,131],random 1000,10000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];
		};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700) then {
			_accepted = true;
		};
	};

private _objPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

	_flatPos1 = [(_flatPos select 0) - 30, (_flatPos select 1) - 30, (_flatPos select 2)];
	_flatPos2 = [(_flatPos select 0) + 30, (_flatPos select 1) + 30, (_flatPos select 2)];
	_flatPos3 = [(_flatPos select 0) + 5, (_flatPos select 1) + random 5, (_flatPos select 2)];

//-------------------- 2. SPAWN OBJECTIVES

	_PTdir = random 360;
	
	sleep 1;
	
	ArtyObj1 = "O_MBT_02_arty_F" createVehicle _flatPos1;
	waitUntil {!isNull ArtyObj1};
	ArtyObj1 setDir _PTdir;
	
	sleep 1;
	
	ArtyObj2 = "O_MBT_02_arty_F" createVehicle _flatPos2;
	waitUntil {!isNull ArtyObj2};
	ArtyObj2 setDir _PTdir;
	
	sleep 1;

	ArtyObj1 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyObj1)) then { ArtyObj1 setVehicleAmmo 1; };}];
	ArtyObj2 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyObj2)) then { ArtyObj2 setVehicleAmmo 1; };}];
	
	//----- SPAWN AMMO TRUCK (for ambiance and plausibiliy of unlimited ammo)
	
	ammoTruck = "O_Truck_03_ammo_F" createVehicle _flatPos3;
	waitUntil {!isNull ammoTruck};
	ammoTruck setDir random 360;
	
	{_x lock 3;_x allowCrewInImmobile true;} forEach [ArtyObj1,ArtyObj2,ammoTruck];
	
//-------------------- 3. SPAWN CREW
	
	_unitsArray = [objNull]; 			// for crew and h-barriers
	
	_AAAGroup = createGroup east;
	
		"O_officer_F" createUnit [_flatPos, _AAAGroup];
		"O_officer_F" createUnit [_flatPos, _AAAGroup];
		"O_engineer_F" createUnit [_flatPos, _AAAGroup];
		"O_engineer_F" createUnit [_flatPos, _AAAGroup];
		
		((units _AAAGroup) select 0) assignAsCommander ArtyObj1;
		((units _AAAGroup) select 0) moveInCommander ArtyObj1;
		((units _AAAGroup) select 1) assignAsCommander ArtyObj2;
		((units _AAAGroup) select 1) moveInCommander ArtyObj2;
		((units _AAAGroup) select 2) assignAsGunner ArtyObj1;
		((units _AAAGroup) select 2) moveInGunner ArtyObj1;
		((units _AAAGroup) select 3) assignAsGunner ArtyObj2;
		((units _AAAGroup) select 3) moveInGunner ArtyObj2;
	
		Artyunits_veh = Artyunits_veh + (units _AAAGroup);

	{
		_x addCuratorEditableObjects [[ArtyObj1, ArtyObj2, ammoTruck] + (units _AAAGroup), false];
	} foreach adminCurators;

	
	//---------- Engines on baby
	
	sleep 0.1;
	ArtyObj1 engineOn true;
	sleep 0.1;
	ArtyObj2 engineOn true;

	

_barrier1 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) + 13.233, (_flatPos1 select 1) - 12.807, 0], [], 0, "CAN_COLLIDE"];
_barrier1 setDir 314.723;
_barrier2 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) + 12.742, (_flatPos1 select 1) + 12.758, 0], [], 0, "CAN_COLLIDE"];
_barrier2 setDir 226.771;
_barrier3 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) - 13.345, (_flatPos1 select 1) + 12.662, 0], [], 0, "CAN_COLLIDE"];
_barrier3 setDir 137.039;
_barrier4 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) - 12.795, (_flatPos1 select 1) - 13.303, 0], [], 0, "CAN_COLLIDE"];
_barrier4 setDir 44.675;
_barrier5 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 5.283, (_flatPos1 select 1) - 15.125, 0], [], 0, "CAN_COLLIDE"];
_barrier6 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 5.646, (_flatPos1 select 1) - 15.002, 0], [], 0, "CAN_COLLIDE"];
_barrier7 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 5.817, (_flatPos1 select 1) + 14.726, 0], [], 0, "CAN_COLLIDE"];
_barrier8 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 5.295, (_flatPos1 select 1) + 14.918, 0], [], 0, "CAN_COLLIDE"];
_barrier9 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 15.173, (_flatPos1 select 1) - 5.375, 0], [], 0, "CAN_COLLIDE"];
_barrier9 setDir 90;
_barrier10 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 14.929, (_flatPos1 select 1) + 5.271, 0], [], 0, "CAN_COLLIDE"];
_barrier10 setDir 90;
_barrier11 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 15.381, (_flatPos1 select 1) + 5.256, 0], [], 0, "CAN_COLLIDE"];
_barrier11 setDir 90;
_barrier12 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 14.958, (_flatPos1 select 1) - 5.785, 0], [], 0, "CAN_COLLIDE"];
_barrier12 setDir 90;
_barrier13 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0), (_flatPos1 select 1) - 8.75, 0], [], 0, "CAN_COLLIDE"];
_barrier13 setDir 358.5;
_barrier14 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) + 9, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
_barrier14 setDir 268;
_barrier15 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0), (_flatPos1 select 1) + 8.402, 0], [], 0, "CAN_COLLIDE"];
_barrier15 setDir 178;
_barrier16 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) - 9.475, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
_barrier16 setDir 88.5;
_spawnedObjects = [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8,_barrier9,_barrier10,_barrier11,_barrier12,_barrier13,_barrier14,_barrier15,_barrier16];

//
{_x addCuratorEditableObjects [_spawnedObjects, false];} forEach allCurators;
//	
{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects;

sleep 1;

ArtyTourelle1 = createVehicle ["O_GMG_01_high_F", [(_flatPos1 select 0) + 8.685, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle1 setDir 90;
ArtyTourelle2 = createVehicle ["O_HMG_02_high_F", [(_flatPos1 select 0), (_flatPos1 select 1) + 8.863, 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle3 = createVehicle ["O_GMG_01_high_F", [(_flatPos1 select 0) - 9.297, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle3 setDir 270;
ArtyTourelle4 = createVehicle ["O_HMG_02_high_F", [(_flatPos1 select 0), (_flatPos1 select 1) - 9.137, 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle4 setDir 180;

ArtyTourelle1 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle1)) then { ArtyTourelle1 setVehicleAmmo 1; };}];
ArtyTourelle2 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle2)) then { ArtyTourelle2 setVehicleAmmo 1; };}];
ArtyTourelle3 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle3)) then { ArtyTourelle3 setVehicleAmmo 1; };}];
ArtyTourelle4 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle4)) then { ArtyTourelle4 setVehicleAmmo 1; };}];

{_x lock 3;_x allowCrewInImmobile true;} forEach [ArtyTourelle1,ArtyTourelle2,ArtyTourelle3,ArtyTourelle4];

sleep 1;

	_ArtyTourelleGroup = createGroup EAST;
		
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup];

		
		((units _ArtyTourelleGroup) select 0) assignAsGunner ArtyTourelle1;
		((units _ArtyTourelleGroup) select 0) moveInGunner ArtyTourelle1;
		((units _ArtyTourelleGroup) select 1) assignAsGunner ArtyTourelle2;
		((units _ArtyTourelleGroup) select 1) moveInGunner ArtyTourelle2;
		((units _ArtyTourelleGroup) select 2) assignAsGunner ArtyTourelle3;
		((units _ArtyTourelleGroup) select 2) moveInGunner ArtyTourelle3;
		((units _ArtyTourelleGroup) select 3) assignAsGunner ArtyTourelle4;
		((units _ArtyTourelleGroup) select 3) moveInGunner ArtyTourelle4;

		
		Artyunits_veh = Artyunits_veh + (units _ArtyTourelleGroup);
	{
		_x addCuratorEditableObjects [[ArtyTourelle1,ArtyTourelle2,ArtyTourelle3,ArtyTourelle4] + (units _ArtyTourelleGroup), false];
	} foreach adminCurators;

sleep 1;

//create Hostile forces:
private ["_PAX1","_PAX2","_PAX3","_PAX4","_PAX5","_PAX6","_PAX7","_PAX8"];	
private _PAXGroup = createGroup EAST;

_PAX1 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) - 12.453, (_flatPos1 select 1) - 14.131, 2.4], [], 0, "CAN_COLLIDE"];
_PAX1 setDir 162;
_PAX2 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) - 13.44, (_flatPos1 select 1) - 13.369, 2.4], [], 0, "CAN_COLLIDE"];
_PAX2 setDir 266;
_PAX3 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) + 14.21, (_flatPos1 select 1) - 12.809, 2.4], [], 0, "CAN_COLLIDE"];
_PAX3 setDir 77;
_PAX4 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) + 13.353, (_flatPos1 select 1) - 13.772, 2.4], [], 0, "CAN_COLLIDE"];
_PAX4 setDir 182;
_PAX5 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) + 12.783, (_flatPos1 select 1) + 13.549, 2.4], [], 0, "CAN_COLLIDE"];
_PAX5 setDir 348;
_PAX6 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) + 13.608, (_flatPos1 select 1) + 12.765, 2.4], [], 0, "CAN_COLLIDE"];
_PAX6 setDir 93;
_PAX7 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) - 14.234, (_flatPos1 select 1) + 12.533, 2.4], [], 0, "CAN_COLLIDE"];
_PAX7 setDir 255;
_PAX8 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) - 13.372, (_flatPos1 select 1) + 13.503, 2.4], [], 0, "CAN_COLLIDE"];
_PAX8 setDir 0;

{	_x disableAI "PATH";
	_spawnedUnits = _spawnedUnits + [_x];
} forEach (units _PAXGroup);
_groupsArray = _groupsArray + [_PAXGroup];
_PAXGroup setGroupIdGlobal [format ['rescue-HostageTakers']];

		Artyunits = Artyunits + (units _PAXGroup);

{_x addCuratorEditableObjects [units _PAXGroup, false];} foreach allCurators;	
sleep 1;

_barrier17 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) + 13.233, (_flatPos2 select 1) - 12.807, 0], [], 0, "CAN_COLLIDE"];
_barrier17 setDir 314.723;
_barrier18 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) + 12.742, (_flatPos2 select 1) + 12.758, 0], [], 0, "CAN_COLLIDE"];
_barrier18 setDir 226.771;
_barrier19 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) - 13.345, (_flatPos2 select 1) + 12.662, 0], [], 0, "CAN_COLLIDE"];
_barrier19 setDir 137.039;
_barrier20 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) - 12.795, (_flatPos2 select 1) - 13.303, 0], [], 0, "CAN_COLLIDE"];
_barrier20 setDir 44.675;
_barrier21 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 5.283, (_flatPos2 select 1) - 15.125, 0], [], 0, "CAN_COLLIDE"];
_barrier22 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 5.646, (_flatPos2 select 1) - 15.002, 0], [], 0, "CAN_COLLIDE"];
_barrier23 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 5.817, (_flatPos2 select 1) + 14.726, 0], [], 0, "CAN_COLLIDE"];
_barrier24 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 5.295, (_flatPos2 select 1) + 14.918, 0], [], 0, "CAN_COLLIDE"];
_barrier25 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 15.173, (_flatPos2 select 1) - 5.375, 0], [], 0, "CAN_COLLIDE"];
_barrier25 setDir 90;
_barrier26 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 14.929, (_flatPos2 select 1) + 5.271, 0], [], 0, "CAN_COLLIDE"];
_barrier26 setDir 90;
_barrier27 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 15.381, (_flatPos2 select 1) + 5.256, 0], [], 0, "CAN_COLLIDE"];
_barrier27 setDir 90;
_barrier28 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 14.958, (_flatPos2 select 1) - 5.785, 0], [], 0, "CAN_COLLIDE"];
_barrier28 setDir 90;
_barrier29 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0), (_flatPos2 select 1) - 8.75, 0], [], 0, "CAN_COLLIDE"];
_barrier29 setDir 358.5;
_barrier30 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0) + 9, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
_barrier30 setDir 268;
_barrier31 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0), (_flatPos2 select 1) + 8.402, 0], [], 0, "CAN_COLLIDE"];
_barrier31 setDir 178;
_barrier32 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0) - 9.475, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
_barrier32 setDir 88.5;
_spawnedObjects2 = [_barrier17,_barrier18,_barrier19,_barrier20,_barrier21,_barrier22,_barrier23,_barrier24,_barrier25,_barrier26,_barrier27,_barrier28,_barrier29,_barrier30,_barrier31,_barrier32];

//
{_x addCuratorEditableObjects [_spawnedObjects2, false];} forEach allCurators;
//	
{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects2;

sleep 1;

ArtyTourelle5 = createVehicle ["O_GMG_01_high_F", [(_flatPos2 select 0) + 8.685, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle5 setDir 90;
ArtyTourelle6 = createVehicle ["O_HMG_02_high_F", [(_flatPos2 select 0), (_flatPos2 select 1) + 8.863, 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle7 = createVehicle ["O_GMG_01_high_F", [(_flatPos2 select 0) - 9.297, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle7 setDir 270;
ArtyTourelle8 = createVehicle ["O_HMG_02_high_F", [(_flatPos2 select 0), (_flatPos2 select 1) - 9.137, 0], [], 0, "CAN_COLLIDE"];
ArtyTourelle8 setDir 180;

ArtyTourelle5 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle5)) then { ArtyArtyTourelle5 setVehicleAmmo 1; };}];
ArtyTourelle6 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle6)) then { ArtyTourelle6 setVehicleAmmo 1; };}];
ArtyTourelle7 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle7)) then { ArtyTourelle7 setVehicleAmmo 1; };}];
ArtyTourelle8 addEventHandler ["Fired",{if (!isPlayer (gunner ArtyTourelle8)) then { ArtyTourelle8 setVehicleAmmo 1; };}];

{_x lock 3;_x allowCrewInImmobile true;} forEach [ArtyTourelle5,ArtyTourelle6,ArtyTourelle7,ArtyTourelle8];

sleep 1;

sleep 1;

	_ArtyTourelleGroup2 = createGroup EAST;
		
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup2];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup2];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup2];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _ArtyTourelleGroup2];

		
		((units _ArtyTourelleGroup2) select 0) assignAsGunner ArtyTourelle5;
		((units _ArtyTourelleGroup2) select 0) moveInGunner ArtyTourelle5;
		((units _ArtyTourelleGroup2) select 1) assignAsGunner ArtyTourelle6;
		((units _ArtyTourelleGroup2) select 1) moveInGunner ArtyTourelle6;
		((units _ArtyTourelleGroup2) select 2) assignAsGunner ArtyTourelle7;
		((units _ArtyTourelleGroup2) select 2) moveInGunner ArtyTourelle7;
		((units _ArtyTourelleGroup2) select 3) assignAsGunner ArtyTourelle8;
		((units _ArtyTourelleGroup2) select 3) moveInGunner ArtyTourelle8;

		
		Artyunits_veh = Artyunits_veh + (units _ArtyTourelleGroup2);
	{
		_x addCuratorEditableObjects [[ArtyTourelle5,ArtyTourelle6,ArtyTourelle7,ArtyTourelle8] + (units _ArtyTourelleGroup2), false];
	} foreach adminCurators;

sleep 1;

//create Hostile forces:
private ["_PAX9","_PAX10","_PAX11","_PAX12","_PAX13","_PAX14","_PAX15","_PAX16"];	
private _PAXGroup2 = createGroup EAST;

_PAX9 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) - 12.453, (_flatPos2 select 1) - 14.131, 2.4], [], 0, "CAN_COLLIDE"];
_PAX9 setDir 162;
_PAX10 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) - 13.44, (_flatPos2 select 1) - 13.369, 2.4], [], 0, "CAN_COLLIDE"];
_PAX10 setDir 266;
_PAX11 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) + 14.21, (_flatPos2 select 1) - 12.809, 2.4], [], 0, "CAN_COLLIDE"];
_PAX11 setDir 77;
_PAX12 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) + 13.353, (_flatPos2 select 1) - 13.772, 2.4], [], 0, "CAN_COLLIDE"];
_PAX12 setDir 182;
_PAX13 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) + 12.783, (_flatPos2 select 1) + 13.549, 2.4], [], 0, "CAN_COLLIDE"];
_PAX13 setDir 348;
_PAX14 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) + 13.608, (_flatPos2 select 1) + 12.765, 2.4], [], 0, "CAN_COLLIDE"];
_PAX14 setDir 93;
_PAX15 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) - 14.234, (_flatPos2 select 1) + 12.533, 2.4], [], 0, "CAN_COLLIDE"];
_PAX15 setDir 255;
_PAX16 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) - 13.372, (_flatPos2 select 1) + 13.503, 2.4], [], 0, "CAN_COLLIDE"];
_PAX16 setDir 0;

{	_x disableAI "PATH";
	_spawnedUnits2 = _spawnedUnits2 + [_x];
} forEach (units _PAXGroup2);
_groupsArray2 = _groupsArray2 + [_PAXGroup2];
_PAXGroup2 setGroupIdGlobal [format ['rescue-HostageTakers']];

		Artyunits = Artyunits + (units _PAXGroup2);

{_x addCuratorEditableObjects [units _PAXGroup2, false];} foreach allCurators;	
	
sleep 1;

//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"];
	Destroy_And_EliminateMarkerText = "Détruire l'artillerie"; publicVariable "Destroy_And_EliminateMarkerText";
	"Destroy_And_EliminateMarker" setMarkerText "Détruire l'artillerie"; publicVariable "Destroy_And_EliminateMarker";
	publicVariable "ArtyObj1";publicVariable "ArtyObj2";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Détruire l'artillerie</t><br/>____________________<br/>Les forces Russes ont déployé une artillerie dans cette zone.<br/>Partez à sa recherche et détruisez l'artillerie...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Détruire l'artillerie"]; publicVariable "showNotification";
	Destroy_And_EliminateMarkerText = "Détruire l'artillerie"; publicVariable "Destroy_And_EliminateMarkerText";
	[west,["DETRUIREARTY"],["Les forces Russes ont déployé une artillerie dans cette zone.<br/>Partez à sa recherche et détruisez l'artillerie...", "Détruire l'artillerie", "Détruire l'artillerie","Destroy_And_EliminateMarker"], _fuzzyPos,"Created",0,true,"mine",true] call BIS_fnc_taskCreate; 

	_marqueur = createMarker ["marqueur_artillerie_spetsnaz", _fuzzyPos];
	_marqueur setMarkerType "selector_selectedMission";
	"marqueur_artillerie_spetsnaz" setMarkerSize [2, 2];
	"marqueur_artillerie_spetsnaz" setMarkerColor "ColorRed";

	_firingMessages = [
		"Thermal scans are picking up those enemy Artillery firing! Heads down!",
		"Enemy Artillery rounds incoming! Advise you seek cover immediately.",
		"OPFOR Artillery rounds incoming! Seek cover immediately!",
		"The Artillery team's firing, boys! Down on the ground!",
		"Get that damned Artillery team down; they're firing right now! Seek cover!",
		"They're zeroing in! Incoming Artillery fire; heads down!"
	];
	
	
//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos ArtyObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Artyunits = Artyunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArtyObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Artyunits_squad = Artyunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArtyObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Artyunits_squad = Artyunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


	private _enemiesArray = [objNull];
	
	
	//=====defining vehicles=========
	_Randomvehicle = ["O_G_Offroad_01_armed_F","O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F","O_Heli_Attack_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_black_F","O_Heli_Light_02_F","O_Heli_Light_02_v2_F","O_MBT_04_command_F","O_MBT_04_cannon_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_fuzzyPos, 10, 300, 5, 0, 0.3, 0, [], (getPos ArtyObj1)] call BIS_fnc_findSafePos;
		_Vehiclegroup1 = createGroup EAST;
		_vehicletype = selectRandom _Randomvehicle;
		_vehicle1 = _vehicletype createVehicle _randomPos;
		createvehiclecrew _vehicle1;
		(crew _vehicle1) join _Vehiclegroup1;
		_vehpatrolgroupamount = _vehpatrolgroupamount + 1;
		_Vehiclegroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _vehpatrolgroupamount]];
		_vehicle1 lock 3;
		[_Vehiclegroup1, _fuzzyPos, 200 + (random 200)] call BIS_fnc_taskPatrol;
		{_x addCuratorEditableObjects [[_vehicle1] + units _Vehiclegroup1, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _Vehiclegroup1) + [_vehicle1];
		Artyunits_veh = Artyunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	

	_infunits = ["O_R_Soldier_TL_F","O_R_Soldier_AR_F","O_R_soldier_exp_F","O_R_Soldier_GL_F","O_R_Soldier_LAT_F","O_R_soldier_M_F","O_R_Patrol_Soldier_M_F","O_R_Patrol_Soldier_Medic","O_R_Patrol_Soldier_Engineer_F"];
	
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [ArtyObj1, ["house","building"], 400];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;
		if (_infBuildingAmount > 20 ) then {_GarrisonedBuildings = _infBuildingAmount*3/4;};
		if (_infBuildingAmount > 40 ) then {_GarrisonedBuildings = _infBuildingAmount/2;};
		if (_infBuildingAmount > 60 ) then {_GarrisonedBuildings = 30;};

		for "_i" from 0 to _GarrisonedBuildings do {
			_garrisongroup = createGroup EAST;
			_garrisongroupamount = _garrisongroupamount + 1;
			_garrisongroup setGroupIdGlobal [format ['Side-GarrisonGroup-%1', _garrisongroupamount]];
			_infBuilding = selectRandom _infBuildingArray;
			_infBuildingArray = _infBuildingArray - [_infBuilding];
			_infbuildingpos = _infBuilding buildingPos -1;
			
			_buildingposcount = count _infbuildingpos;
			_Garrisonpos = _buildingposcount/2;
			
			for "_i" from 1 to _Garrisonpos do {
				_unitpos = selectRandom _infbuildingpos;
				_infbuildingpos = _infbuildingpos - _unitpos;
				_unittype = selectRandom _infunits;
				_unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
				_unit disableAI "PATH";
			};

			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
			Artyunits_squad = Artyunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};


//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	ArtyMissionUp = true; publicVariable "ArtyMissionUp";
	Arty_SUCCESS = false; publicVariable "Arty_SUCCESS";

_radius = 80;
	
	//-------------------- FIRING SEQUENCE LOOP
	/*/
	Explications: il s'agit d'une boucle (while...do...) tant que l'arti peut tirer alors il fait...
	/*/
		while {((canFire ArtyObj1) || (canFire ArtyObj2))} do {
			_shouldSearchTargets = true; //recherche des cibles est vrai.
			_targetUnit = objNull; //pour le moment pas de cible.
			_targetPos = [0, 0, 0]; //...et donc pas de position de cible.

			while {_shouldSearchTargets} do { //deuxième boucle dans la boucle -> tant que la recherche de cibles est vrai alors il fait...
			
				if (!(canFire ArtyObj1) || !(canFire ArtyObj2)) exitWith {_shouldSearchTargets = false; }; //si l'arti ne peut tirer (canon endommagé pas besoin de chercher des cibles), on ne cherche pas la cible.
				
				_playerCount = count playableUnits; //on compte le nombre de joueurs présents.
				
				if (_playerCount >= 0) then { //si il y a un joueur sur le serveur alors...
				
					_targetUnit = selectRandom playableUnits; //on sélectionne un joueur qui va devenir la cible.
					sleep 5;
					
					if ( !(isNull _targetUnit) && (vehicle _targetUnit == _targetUnit) && (side _targetUnit == WEST)) then {//si le joueur est vivant && si le joueur est en dehors d'un véhicule && si le joueur est du côté Ouest alors...
						
						_targetPos = getPos _targetUnit; //le joueur devient la cible et sa position est ciblée.

						if ((East knowsAbout _targetUnit) > 3.5) then { //si la cible est détectée (valeur dtection de 0 à 4 - 4 étant vraiment bien détecté...) par la faction East (on est sur une artillerie Spetznaz) alors..
							if (!(canFire ArtyObj1) || !(canFire ArtyObj2)) exitWith {_shouldSearchTargets = false;}; //si l'arti ne peut tirer (canon endommagé toujours pas besoin de chercher des cibles), on ne cherche toujours pas la cible.
							{if (alive _x) then {[_x, _targetPos] call AW_fnc_artyStrike;};} forEach [ArtyObj1,ArtyObj2]; //l'arti fait feu (en appelant la fonction fnc_artyStrike qui est une fonction d'Ahoy World, toujours donner le crédit quand on emprunte des fonctions, donc bien mettre Ahoy World dans vos crédits!)
							sleep 60;
						};
					};
				};
			};
			if !(canFire ArtyObj1) exitWith{};
		};

	
	while {alive ArtyObj1 || alive ArtyObj2} do { sleep 10; };
			

	//-------------------- DE-BRIEFING
	sleep 5;
	ArtyMissionUp = false; publicVariable "ArtyMissionUp";
	Arty_SUCCESS = true;
	_CompleteText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>REUSSIE</t><br/>____________________<br/>l'artillerie est détruite! Bravo!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
	GlobalHint = _CompleteText; publicVariable "GlobalHint"; hint parseText _CompleteText;
	showNotification = ["CompletedMission", Destroy_And_EliminateMarkerText]; publicVariable "showNotification";
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"]; publicVariable "Destroy_And_EliminateMarker";
	_null = ["DETRUIREARTY", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
	sleep 5;
	["DETRUIREARTY"] call BIS_fnc_deleteTask; 
	
//--------------------- DELETE

sleep 60;
{deletevehicle _x} foreach Artyunits;
{deletevehicle _x} foreach Artyunits_veh;
{deletevehicle _x} foreach Artyunits_squad;
{deletevehicle _x} foreach [ArtyTourelle1,ArtyTourelle2,ArtyTourelle3,ArtyTourelle4,ArtyTourelle5,ArtyTourelle6,ArtyTourelle7,ArtyTourelle8];

{_x removeEventHandler ["Fired", 0];} forEach [ArtyObj1,ArtyObj2];
{_x removeEventHandler ["HandleDamage",1];} forEach [ArtyObj1,ArtyObj2];
Artyunits = [];
Artyunits_veh = [];
Artyunits_squad = [];
[_flatPos, _spawnedObjects]spawn {

	deleteVehicle nearestObject[(_this select 0), "O_Truck_03_ammo_F"];
	{
	if (!(isNull _x) && {alive _x}) then {
		deleteVehicle _x;
	};
	} foreach (_this select 1);
		
};	
[_flatPos, _spawnedObjects2]spawn {

	deleteVehicle nearestObject[(_this select 0), "O_Truck_03_ammo_F"];
	{
	if (!(isNull _x) && {alive _x}) then {
		deleteVehicle _x;
	};
	} foreach (_this select 1);
		
};	
{deleteVehicle _x;} forEach [ammoTruck];
{deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;		
deleteMarker "marqueur_artillerie_spetsnaz";