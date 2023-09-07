/*
Last modified: 

	03 février 2023 by [MF] Ricky

Description:

	Mission Camp OTAN

*/

private ["_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_aliveInZone","_GUEUnderAttack"];
CAMPunits = [];
CAMPunits_veh = [];
CAMPunits_squad = [];


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

//================Create camp
CAMPObj = "Land_Cargo_HQ_V3_F" createVehicle _flatPos;
CAMPObj setDir 90;
{_x addCuratorEditableObjects [[CAMPObj], false];} forEach allCurators;

_barrier1 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 12.928, (_flatPos select 1) - 20.618, 0], [], 0, "CAN_COLLIDE"];
_barrier1 setDir 75;
_barrier2 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 3.374, (_flatPos select 1) - 20.642, 0], [], 0, "CAN_COLLIDE"];
_barrier2 setDir 90;
_barrier3 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 1.593, (_flatPos select 1) - 24.068, 0], [], 0, "CAN_COLLIDE"];
_barrier3 setDir 180;
_barrier4 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 6.65, (_flatPos select 1) - 20.955, 0], [], 0, "CAN_COLLIDE"];
_barrier4 setDir 270;
_barrier5 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 13.763, (_flatPos select 1) - 7.105, 0], [], 0, "CAN_COLLIDE"];
_barrier5 setDir 270;
_barrier6 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 13.998, (_flatPos select 1) + 1.31, 0], [], 0, "CAN_COLLIDE"];
_barrier6 setDir 270;
_barrier7 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 14.223, (_flatPos select 1) + 13.342, 0], [], 0, "CAN_COLLIDE"];
_barrier7 setDir 270;
_barrier8 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 9.11, (_flatPos select 1) + 16.408, 0], [], 0, "CAN_COLLIDE"];
_barrier9 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 0.984, (_flatPos select 1) + 16.614, 0], [], 0, "CAN_COLLIDE"];
_barrier10 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 16.427, (_flatPos select 1) + 13.13, 0], [], 0, "CAN_COLLIDE"];
_barrier10 setDir 270;
sleep 1;
_barrier11 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 16.721, (_flatPos select 1) + 4.891, 0], [], 0, "CAN_COLLIDE"];
_barrier11 setDir 270;
_barrier12 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 18.728, (_flatPos select 1) - 3.343, 0], [], 0, "CAN_COLLIDE"];
_barrier12 setDir 270;
_barrier13 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 15.528, (_flatPos select 1) - 6.576, 0], [], 0, "CAN_COLLIDE"];
_barrier14 = createVehicle ["Land_HBarrier_3_F", [(_flatPos select 0) + 13.213, (_flatPos select 1) - 13.75, 0], [], 0, "CAN_COLLIDE"];
_barrier15 = createVehicle ["Land_HBarrier_3_F", [(_flatPos select 0) + 10.833, (_flatPos select 1) - 14.746, 0], [], 0, "CAN_COLLIDE"];
_barrier15 setDir 270;
_barrier16 = createVehicle ["Land_HBarrier_3_F", [(_flatPos select 0) + 10.256, (_flatPos select 1) - 24.473, 0], [], 0, "CAN_COLLIDE"];
_barrier16 setDir 165;
_barrier17 = createVehicle ["Land_HBarrier_3_F", [(_flatPos select 0) + 7.706, (_flatPos select 1) + 14.242, 0], [], 0, "CAN_COLLIDE"];
_barrier17 setDir 270;
_barrier18 = createVehicle ["Land_HBarrier_5_F", [(_flatPos select 0) + 10.147, (_flatPos select 1) + 15.249, 0], [], 0, "CAN_COLLIDE"];
_barrier18 setDir 180;
_barrier19 = createVehicle ["Land_HBarrier_5_F", [(_flatPos select 0) - 13.908, (_flatPos select 1) - 12.015, 0], [], 0, "CAN_COLLIDE"];
_barrier19 setDir 180;
_barrier20 = createVehicle ["Land_HBarrier_1_F", [(_flatPos select 0) + 10.179, (_flatPos select 1) + 19.554, 0], [], 0, "CAN_COLLIDE"];
_barrier20 setDir 190;
_barrier21 = createVehicle ["Land_HBarrier_1_F", [(_flatPos select 0) + 3.617, (_flatPos select 1) + 20.816, 0], [], 0, "CAN_COLLIDE"];
_barrier21 setDir 190;
_barrier22 = createVehicle ["Land_HBarrier_1_F", [(_flatPos select 0) + 7.257, (_flatPos select 1) - 24.107, 0], [], 0, "CAN_COLLIDE"];
_barrier22 setDir 90;
_barrier23 = createVehicle ["Land_HBarrier_1_F", [(_flatPos select 0) + 7.756, (_flatPos select 1) - 18.804, 0], [], 0, "CAN_COLLIDE"];
_barrier23 setDir 90;
sleep 1;
_barrier24 = createVehicle ["Land_BagFence_Long_F", [(_flatPos select 0) + 7.273, (_flatPos select 1) + 22.753, 0], [], 0, "CAN_COLLIDE"];
_barrier24 setDir 190;
_barrier25 = createVehicle ["Land_BagFence_Long_F", [(_flatPos select 0) - 11.31, (_flatPos select 1) - 13.969, 0], [], 0, "CAN_COLLIDE"];
_barrier25 setDir 75;
_barrier26 = createVehicle ["Land_BagFence_Long_F", [(_flatPos select 0) + 19.542, (_flatPos select 1) - 8.954, 0], [], 0, "CAN_COLLIDE"];
_barrier26 setDir 90;
_barrier27 = createVehicle ["Land_BagFence_Long_F", [(_flatPos select 0) + 10.127, (_flatPos select 1) - 13.881, 0], [], 0, "CAN_COLLIDE"];
_barrier27 setDir 180;
_barrier28 = createVehicle ["Land_BagFence_Long_F", [(_flatPos select 0) + 4.743, (_flatPos select 1) - 13.881, 0], [], 0, "CAN_COLLIDE"];
_barrier29 = createVehicle ["Land_BagFence_Long_F", [(_flatPos select 0) + 9.776, (_flatPos select 1) - 18.503, 0], [], 0, "CAN_COLLIDE"];
_barrier30 = createVehicle ["Land_BagFence_Long_F", [(_flatPos select 0) + 5.731, (_flatPos select 1) - 24, 0], [], 0, "CAN_COLLIDE"];
_barrier31 = createVehicle ["Land_BagFence_Round_F", [(_flatPos select 0) + 9.636, (_flatPos select 1) + 21.351, 0], [], 0, "CAN_COLLIDE"];
_barrier31 setDir 234;
_barrier32 = createVehicle ["Land_BagFence_Round_F", [(_flatPos select 0) + 4.744, (_flatPos select 1) + 22.124, 0], [], 0, "CAN_COLLIDE"];
_barrier32 setDir 144;
_barrier33 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos select 0) - 15.884, (_flatPos select 1) + 6.878, 0], [], 0, "CAN_COLLIDE"];
_barrier33 setDir 90;
_barrier34 = createVehicle ["Land_Cargo_Patrol_V3_F", [(_flatPos select 0) - 9.737, (_flatPos select 1) + 10.964, 0], [], 0, "CAN_COLLIDE"];
_barrier34 setDir 180;
_barrier35 = createVehicle ["Land_Cargo_Patrol_V3_F", [(_flatPos select 0) + 14.47, (_flatPos select 1) - 3.629, 0], [], 0, "CAN_COLLIDE"];
_barrier35 setDir 270;
_barrier36 = createVehicle ["Land_Cargo_House_V3_F", [(_flatPos select 0) - 1.568, (_flatPos select 1) - 17.351, 0], [], 0, "CAN_COLLIDE"];
_barrier36 setDir 180;
sleep 1;
_barrier37 = createVehicle ["Land_Cargo20_grey_F", [(_flatPos select 0) + 13.807, (_flatPos select 1) + 10.875, 0], [], 0, "CAN_COLLIDE"];
_barrier37 setDir 269;
_barrier38 = createVehicle ["Land_Cargo10_military_green_F", [(_flatPos select 0) + 10.172, (_flatPos select 1) + 12.393, 0], [], 0, "CAN_COLLIDE"];
_barrier38 setDir 273;
_barrier39 = createVehicle ["Land_Cargo20_military_green_F", [(_flatPos select 0) - 10.902, (_flatPos select 1) - 7.633, 0], [], 0, "CAN_COLLIDE"];
_barrier39 setDir 88;
_barrier40 = createVehicle ["Land_HBarrier_3_F", [(_flatPos select 0) + 2.346, (_flatPos select 1) - 14.874, 0], [], 0, "CAN_COLLIDE"];
_barrier40 setDir 270;

_spawnedObjects = [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8,_barrier9,_barrier10,_barrier11,_barrier12,_barrier13,_barrier14,_barrier15,_barrier16,_barrier17,_barrier18,_barrier19,_barrier20,_barrier21,_barrier22,_barrier23];
_spawnedObjects2 = [_barrier24,_barrier25,_barrier26,_barrier27,_barrier28,_barrier29,_barrier30,_barrier31,_barrier32,_barrier33,_barrier34,_barrier35,_barrier36,_barrier37,_barrier38,_barrier39,_barrier40];

//
{_x addCuratorEditableObjects [_spawnedObjects, false];} forEach allCurators;
//	
{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects;
//
{_x addCuratorEditableObjects [_spawnedObjects2, false];} forEach allCurators;
//	
{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects2;
sleep 1;

private ["_PAX1","_PAX2","_PAX3","_PAX4","_PAX5","_PAX6","_PAX7","_PAX8","_PAX9","_PAX10","_PAX11","_PAX12","_PAX13","_PAX14","_PAX15","_PAX16"];	
private _PAXGroup = createGroup EAST;

_PAX1 = _PAXGroup createUnit ["B_Soldier_AR_F", [(_flatPos select 0) + 5.93, (_flatPos select 1) + 20.83, 0], [], 0, "CAN_COLLIDE"];
_PAX2 = _PAXGroup createUnit ["B_Soldier_AR_F", [(_flatPos select 0) - 0.112, (_flatPos select 1) - 5.854, 3.2], [], 0, "CAN_COLLIDE"];
_PAX3 = _PAXGroup createUnit ["B_soldier_M_F", [(_flatPos select 0) - 8.801, (_flatPos select 1) + 13.412, 4.4], [], 0, "CAN_COLLIDE"];
_PAX4 = _PAXGroup createUnit ["B_soldier_M_F", [(_flatPos select 0) + 15.468, (_flatPos select 1) - 2.86, 4.4], [], 0, "CAN_COLLIDE"];
_PAX5 = _PAXGroup createUnit ["B_Medic_F", [(_flatPos select 0) + 3.59, (_flatPos select 1) - 4.762, 0.7], [], 0, "CAN_COLLIDE"];
_PAX6 = _PAXGroup createUnit ["B_Medic_F", [(_flatPos select 0) - 3.401, (_flatPos select 1) + 2.74, 3.2], [], 0, "CAN_COLLIDE"];
_PAX7 = _PAXGroup createUnit ["B_Soldier_SL_F", [(_flatPos select 0) - 1.228, (_flatPos select 1) - 4.772, 0.7], [], 0, "CAN_COLLIDE"];
_PAX8 = _PAXGroup createUnit ["B_Soldier_SL_F", [(_flatPos select 0) + 2.051, (_flatPos select 1) + 1.525, 0.7], [], 0, "CAN_COLLIDE"];
_PAX9 = _PAXGroup createUnit ["B_Soldier_F", [(_flatPos select 0) + 17.974, (_flatPos select 1) - 9.268, 0], [], 0, "CAN_COLLIDE"];
_PAX10 = _PAXGroup createUnit ["B_Soldier_AAT_F", [(_flatPos select 0) + 8.178, (_flatPos select 1) + 20.537, 0], [], 0, "CAN_COLLIDE"];
_PAX11 = _PAXGroup createUnit ["B_Soldier_LAT_F", [(_flatPos select 0) + 1.912, (_flatPos select 1) + 1.677, 3.2], [], 0, "CAN_COLLIDE"];
_PAX12 = _PAXGroup createUnit ["B_Soldier_GL_F", [(_flatPos select 0) - 9.73, (_flatPos select 1) - 14.063, 0], [], 0, "CAN_COLLIDE"];
_PAX13 = _PAXGroup createUnit ["B_Soldier_TL_F", [(_flatPos select 0) - 1.376, (_flatPos select 1) - 21.106, 0], [], 0, "CAN_COLLIDE"];
_PAX14 = _PAXGroup createUnit ["B_Soldier_AT_F", [(_flatPos select 0) + 5.396, (_flatPos select 1) - 22.884, 0], [], 0, "CAN_COLLIDE"];
_PAX15 = _PAXGroup createUnit ["B_Soldier_A_F", [(_flatPos select 0) + 9.745, (_flatPos select 1) - 16.86, 0], [], 0, "CAN_COLLIDE"];
_PAX16 = _PAXGroup createUnit ["B_Soldier_A_F", [(_flatPos select 0) + 5.694, (_flatPos select 1) - 13.039, 0], [], 0, "CAN_COLLIDE"];
[_PAX1,_PAX2,_PAX3,_PAX4,_PAX5,_PAX6,_PAX7,_PAX8,_PAX9,_PAX10,_PAX11,_PAX12,_PAX13,_PAX14,_PAX15,_PAX16] joinSilent _PAXGroup;

{	_x disableAI "PATH";
	_spawnedUnits = _spawnedUnits + [_x];
} forEach (units _PAXGroup);
_groupsArray = _groupsArray + [_PAXGroup];
_PAXGroup setGroupIdGlobal [format ['rescue-HostageTakers']];

		CAMPunits = CAMPunits + (units _PAXGroup);

{_x addCuratorEditableObjects [units _PAXGroup, false];} foreach allCurators;	
sleep 1;
//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["INVASIONMarker", "INVASIONCircle"];
	INVASIONMarkerText = "Camp OTAN"; publicVariable "INVASIONMarkerText";
	"INVASIONMarker" setMarkerText "Camp OTAN"; publicVariable "INVASIONMarker";
	publicVariable "CAMPObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Camp OTAN</t><br/>____________________<br/>Un drône civil a repéré un possible camp OTAN dans le coin<br/>...Rendez-vous sur zone et nettoyez le camp discrètement.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Camp OTAN"]; publicVariable "showNotification";
	INVASIONMarkerText = "Camp OTAN"; publicVariable "INVASIONMarkerText";
	[west,["CAMPMILICE"],["Un drône civil a repéré un possible camp OTAN dans le coin.<br/>...Rendez-vous sur zone et nettoyez le camp discrètement.", "Camp OTAN", "Camp OTAN","INVASIONMarker"],_fuzzyPos,"Created",0,true,"target",true] call BIS_fnc_taskCreate;

	_marqueur = createMarker ["marqueur_attaque_otan_milice", _fuzzyPos];
	_marqueur setMarkerType "selector_selectedMission";
	"marqueur_attaque_otan_milice" setMarkerSize [2, 2];
	"marqueur_attaque_otan_milice" setMarkerColor "ColorBlue";

 private _noSpawning = 500;

		_barrage_mission = [] execVM "mission\barrage\CAMP\SYN_barrage.sqf";
		_barrage_mission2 = [] execVM "mission\barrage\CAMP\SYN_barrage_1.sqf";
		_barrage_mission3 = [] execVM "mission\barrage\CAMP\SYN_barrage_2.sqf";

//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos CAMPObj,50 + random 300] call BIS_fnc_taskPatrol;
	CAMPunits = CAMPunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AA")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos CAMPObj,50 + random 300] call BIS_fnc_taskPatrol;
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AT")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos CAMPObj,50 + random 300] call BIS_fnc_taskPatrol;
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_SniperTeam")] call BIS_fnc_spawnGroup;	
	_spawnGroup_squad setBehaviour "COMBAT";	
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 2) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos CAMPObj,50 + random 300] call BIS_fnc_taskPatrol;
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfAssault")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos CAMPObj,50 + random 300] call BIS_fnc_taskPatrol;
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

private _enemiesArray = [objNull];

	//=====defining vehicles=========
	_Randomvehicle = ["B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_MBT_01_TUSK_F","B_Heli_Attack_01_dynamicLoadout_F","B_APC_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F","B_T_APC_Tracked_01_AA_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 2)) do {
		_randomPos = [_flatPos, 10, 300, 5, 0, 0.3, 0, [], (getPos CAMPObj)] call BIS_fnc_findSafePos;
		_Vehiclegroup1 = createGroup EAST;
		_vehicletype = selectRandom _Randomvehicle;
		_vehicle1 = _vehicletype createVehicle _randomPos;
		createvehiclecrew _vehicle1;
		(crew _vehicle1) join _Vehiclegroup1;
		_vehpatrolgroupamount = _vehpatrolgroupamount + 1;
		_Vehiclegroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _vehpatrolgroupamount]];
		_vehicle1 lock 3;
		[_Vehiclegroup1, _flatPos, 200 + (random 300)] call BIS_fnc_taskPatrol;
		{_x addCuratorEditableObjects [[_vehicle1] + units _Vehiclegroup1, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _Vehiclegroup1) + [_vehicle1];
		CAMPunits_veh = CAMPunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	 _infunits= ["B_Engineer_F","B_Medic_F","B_Soldier_A_F","B_Soldier_AA_F","B_Soldier_AAA_F","B_Soldier_AAR_F","B_Soldier_AAT_F","B_Soldier_AR_F","B_Soldier_AT_F","B_Soldier_Exp_F","B_Soldier_F","B_Soldier_GL_F","B_Soldier_LAT_F","B_Soldier_LAT2_F","B_soldier_M_F","B_Soldier_Repair_F","B_Soldier_SL_F","B_Soldier_TL_F"];
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [CAMPObj, ["house","building"], 200];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;


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
				[_unit] join _garrisongroup;
			};
			_enemiesArray = _enemiesArray + (units _garrisongroup);
			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
			CAMPunits_squad = CAMPunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};
	
	private _staticgroupamount = 0;
	
	//=====defining static=========
	private _Randomstatic = ["B_static_AA_F","B_static_AT_F","B_HMG_01_high_F"];
	
	for "_i" from 0 to (2 + (random 2)) do {
		_randomPos = [_fuzzyPos,random 10,40, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
		_staticgroup1 = createGroup EAST;
		_statictype = selectRandom _Randomstatic;
		_static1 = _statictype createVehicle _randomPos;
		createvehiclecrew _static1;
		(crew _static1) join _staticgroup1;
		_staticgroupamount = _staticgroupamount + 1;
		_staticgroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _staticgroupamount]];
		_static1 lock 3;
		{_x addCuratorEditableObjects [[_static1] + units _staticgroup1, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _staticgroup1) + [_static1];
		CAMPunits_veh = CAMPunits_veh + (units _staticgroup1);
	};	
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	CAMPMissionUp = true; publicVariable "CAMPMissionUp";
	CAMP_SUCCESS = false; publicVariable "CAMP_SUCCESS";

	//--------------------------------------------- TRIGGER TO COUNT UNITS ALIVE
	
	_trg = createTrigger ["EmptyDetector", _fuzzyPos];
	_trg setTriggerArea [350, 350, 0, false];
	_trg setTriggerActivation [EAST, "PRESENT", true];
	_trg setTriggerStatements ["this", "hint 'Civilian near player'", "hint 'no civilian near'"];

while { CAMPMissionUp } do {
	//--------------------------------------------- COUNT UNITS ALIVE
	
	_aliveInZone = {[_trg,_x] call bis_fnc_inTrigger && side _x == EAST  && alive _x} count AllUnits;  	  

	//--------------------------------------------- NO UNITS OK
	
	if (_aliveInZone < 5) then
	{
		//-------------------- DE-BRIEFING
		sleep 10;
		CAMPMissionUp = false; publicVariable "CAMPMissionUp";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", INVASIONMarkerText]; publicVariable "showNotification";
		// _GUEUnderAttack = [] execVM "mission\Defense\OTAN_CAMP_Defend.sqf";
		sleep 8;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["INVASIONMarker", "INVASIONCircle"]; publicVariable "INVASIONMarker";
		_null = ["CAMPMILICE", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["CAMPMILICE"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;

		{deleteVehicle _x} forEach nearestObjects [CAMPObj, ["all"], 200];
		{deletevehicle _x; sleep 0.1;} foreach CAMPunits;
		{deletevehicle _x; sleep 0.1;} foreach CAMPunits_veh;
		{deletevehicle _x; sleep 0.1;} foreach CAMPunits_squad;
		sleep 3;
		CAMPunits = [];
		CAMPunits_veh = [];
		CAMPunits_squad = [];
		deleteVehicle CAMPObj;
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;
		[_flatPos, _spawnedObjects]spawn {
			
			{
			if (!(isNull _x) && {alive _x}) then {
				deleteVehicle _x;
			};
			} foreach (_this select 1);
					
		};	
		[_flatPos, _spawnedObjects2]spawn {
		
			{
			if (!(isNull _x) && {alive _x}) then {
				deleteVehicle _x;
			};
			} foreach (_this select 1);	
		};	
		deleteMarker "marqueur_attaque_otan_milice";
	};	
};