/*
Author: 

	Quiksilver

Last modified: 

	28 Novembre 2022 by [MF] Ricky

Description:

	Mission Tour de com

*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_unitsArray"];

DetruireTourDeComunits = [];
DetruireTourDeComunits_veh = [];
DetruireTourDeComunits_squad = [];




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
	_flatPos1 = [(_flatPos select 0) , (_flatPos select 1) , (_flatPos select 2)];
	
	//-------------------- SPAWN OBJECTIVE

DetruireTourDeComObj = "Land_TTowerBig_2_F" createVehicle _flatPos1;
waitUntil {alive DetruireTourDeComObj};
DetruireTourDeComObj setVectorUp [0,0,1];
DetruireTourDeComObj setDir 0;
_flatPos1 = getPos DetruireTourDeComObj;
{_x addCuratorEditableObjects [[DetruireTourDeComObj], false];} forEach allCurators;

_barrier1 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 6.508, (_flatPos1 select 1) - 4.124, 0], [], 0, "CAN_COLLIDE"];
_barrier1 setDir 90;
_barrier2 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 6.678, (_flatPos1 select 1) + 4.285, 0], [], 0, "CAN_COLLIDE"];
_barrier2 setDir 90;
_barrier3 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 18.477, (_flatPos1 select 1) - 5.442, 0], [], 0, "CAN_COLLIDE"];
_barrier3 setDir 90;
_barrier4 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 15.252, (_flatPos1 select 1) - 10.621, 0], [], 0, "CAN_COLLIDE"];
_barrier5 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 15.092, (_flatPos1 select 1) - 0.379, 0], [], 0, "CAN_COLLIDE"];
_barrier6 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 1.244, (_flatPos1 select 1) - 7.363, 0], [], 0, "CAN_COLLIDE"];
_barrier7 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 1.698, (_flatPos1 select 1) + 7.647, 0], [], 0, "CAN_COLLIDE"];
_barrier8 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 6.467, (_flatPos1 select 1) + 7.871, 0], [], 0, "CAN_COLLIDE"];
_barrier9 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 14.842, (_flatPos1 select 1) + 7.871, 0], [], 0, "CAN_COLLIDE"];
_barrier10 = createVehicle ["Land_HBarrier_3_F", [(_flatPos1 select 0) + 8.299, (_flatPos1 select 1) - 10.632, 0], [], 0, "CAN_COLLIDE"];
sleep 1;
_barrier11 = createVehicle ["Land_HBarrier_3_F", [(_flatPos1 select 0) + 3.69, (_flatPos1 select 1) - 6.859, 0], [], 0, "CAN_COLLIDE"];
_barrier12 = createVehicle ["Land_HBarrier_3_F", [(_flatPos1 select 0) + 8.342, (_flatPos1 select 1) - 0.254, 0], [], 0, "CAN_COLLIDE"];
_barrier13 = createVehicle ["Land_HBarrier_1_F", [(_flatPos1 select 0) + 12.842, (_flatPos1 select 1) + 3.996, 0], [], 0, "CAN_COLLIDE"];
_barrier14 = createVehicle ["Land_HBarrier_1_F", [(_flatPos1 select 0) + 18.467, (_flatPos1 select 1) + 3.496, 0], [], 0, "CAN_COLLIDE"];
_barrier15 = createVehicle ["Land_BagFence_Long_F", [(_flatPos1 select 0) + 18.342, (_flatPos1 select 1) + 1.996, 0], [], 0, "CAN_COLLIDE"];
_barrier15 setDir 270;
_barrier16 = createVehicle ["Land_BagFence_Long_F", [(_flatPos1 select 0) + 8.217, (_flatPos1 select 1) + 0.996, 0], [], 0, "CAN_COLLIDE"];
_barrier16 setDir 270;
_barrier17 = createVehicle ["Land_BagFence_Long_F", [(_flatPos1 select 0) + 8.217, (_flatPos1 select 1) + 6.371, 0], [], 0, "CAN_COLLIDE"];
_barrier17 setDir 90;
_barrier18 = createVehicle ["Land_BagFence_Long_F", [(_flatPos1 select 0) + 12.842, (_flatPos1 select 1) + 5.746, 0], [], 0, "CAN_COLLIDE"];
_barrier18 setDir 90;
_barrier19 = createVehicle ["Land_Cargo_House_V1_F", [(_flatPos1 select 0) + 12.366, (_flatPos1 select 1) - 4.802, 0], [], 0, "CAN_COLLIDE"];
_barrier19 setDir 90;
_spawnedObjects = [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8,_barrier9,_barrier10,_barrier11,_barrier12,_barrier13,_barrier14,_barrier15,_barrier16,_barrier17,_barrier18,_barrier19];
sleep 1;
//
{_x addCuratorEditableObjects [_spawnedObjects, false];} forEach allCurators;
//	
{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects;



//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"];
	Destroy_And_EliminateMarkerText = "Détruire la tour de communications"; publicVariable "Destroy_And_EliminateMarkerText";
	"Destroy_And_EliminateMarker" setMarkerText "Détruire la tour de communications"; publicVariable "Destroy_And_EliminateMarker";
	publicVariable "DetruireTourDeComObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Détruire la tour de communications</t><br/>____________________<br/>Les forces LDF protègent une tour de transmissions dans cette zone.<br/>Partez à sa recherche et détruisez la tour de transmission...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Détruire la tour de communications"]; publicVariable "showNotification";
	Destroy_And_EliminateMarkerText = "Détruire la tour de communications"; publicVariable "Destroy_And_EliminateMarkerText";
	[west,["DETRUIRETOUR"],["Les forces LDF protègent une tour de transmissions dans cette zone.<br/>Partez à sa recherche et détruisez la tour de transmission...", "Détruire la tour de communications", "Détruire la tour de communications","Destroy_And_EliminateMarker"],(getMarkerPos "Destroy_And_EliminateMarker"),"Created",0,true,"mine",true] call BIS_fnc_taskCreate; 

private _noSpawning = 500;

		_barrage_mission = [] execVM "mission\barrage\TourDeCom\SYN_barrage.sqf";
		_barrage_mission2 = [] execVM "mission\barrage\TourDeCom\SYN_barrage_1.sqf";
		_barrage_mission3 = [] execVM "mission\barrage\TourDeCom\SYN_barrage_2.sqf";
	
	
//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos DetruireTourDeComObj,50 + random 200] call BIS_fnc_taskPatrol;
	DetruireTourDeComunits = DetruireTourDeComunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos DetruireTourDeComObj,50 + random 200] call BIS_fnc_taskPatrol;
	DetruireTourDeComunits_squad = DetruireTourDeComunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSentry")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos DetruireTourDeComObj,50 + random 200] call BIS_fnc_taskPatrol;
	DetruireTourDeComunits_squad = DetruireTourDeComunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;	
	_spawnGroup_squad setBehaviour "COMBAT";	
	DetruireTourDeComunits_squad = DetruireTourDeComunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

	private _enemiesArray = [objNull];

	
	
	//=====defining vehicles=========
	_Randomvehicle = ["I_E_Heli_light_03_dynamicLoadout_F","I_E_APC_tracked_03_cannon_F","I_E_UGV_01_rcws_F","I_G_Offroad_01_armed_F","I_G_Offroad_01_AT_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_fuzzyPos, 10, 300, 5, 0, 0.3, 0, [], (getPos DetruireTourDeComObj)] call BIS_fnc_findSafePos;
		_Vehiclegroup1 = createGroup Independent;
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
		DetruireTourDeComunits_veh = DetruireTourDeComunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	

	_infunits = ["I_E_soldier_Mine_F","I_E_Soldier_MP_F","I_E_RadioOperator_F","I_E_Soldier_A_F","I_E_Soldier_AA_F","I_E_Soldier_AAA_F","I_E_Soldier_AAR_F","I_E_Soldier_AAT_F","I_E_Soldier_AR_F","I_E_Soldier_AT_F","I_E_Soldier_CBRN_F","I_E_Soldier_Exp_F","I_E_Soldier_F","I_E_Soldier_GL_F","I_E_Soldier_LAT_F","I_E_Soldier_LAT2_F","I_E_Soldier_lite_F","I_E_soldier_M_F","I_E_Soldier_Repair_F","I_E_Soldier_SL_F","I_E_Soldier_TL_F"];
	
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [DetruireTourDeComObj, ["house","building"], 400];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;
		if (_infBuildingAmount > 20 ) then {_GarrisonedBuildings = _infBuildingAmount*3/4;};
		if (_infBuildingAmount > 40 ) then {_GarrisonedBuildings = _infBuildingAmount/2;};
		if (_infBuildingAmount > 60 ) then {_GarrisonedBuildings = 30;};

		for "_i" from 0 to _GarrisonedBuildings do {
			_garrisongroup = createGroup Independent;
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
			_enemiesArray = _enemiesArray + (units _garrisongroup);
			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
			DetruireTourDeComunits_squad = DetruireTourDeComunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};

		// Spawn a CAS jet to patrol the Radio.
		 
		#define PLANE_TYPE "O_Plane_CAS_02_dynamicLoadout_F","O_Plane_Fighter_02_F","I_Plane_Fighter_04_F"
		 
		_plane = createVehicle [([PLANE_TYPE] call BIS_fnc_selectRandom), [0,0,0], [], 0, "FLY"];
		 
		_plane addEventHandler ["Fired",{
			(_this select 0) setVehicleAmmo 1
		}];
		 
		_pilotguy = [[0,0,0], EAST, ["O_Fighter_Pilot_F"],[],[],[],[],[],232] call BIS_fnc_spawnGroup;
		 
		((units _pilotguy) select 0) moveInDriver _plane;
		 
		_wpcas = _pilotguy addWaypoint [getmarkerPos "Destroy_And_EliminateMarker", 500];
		_wpcas setWaypointType "LOITER";
		_wpcas setWaypointLoiterRadius 3500;
		_wpcas setWaypointLoiterType "CIRCLE_L";
		_wpcas setWaypointBehaviour "AWARE";
		_wpcas setWaypointCombatMode "RED";
		[_pilotguy, _fuzzyPos, 1000 + (random 4000)] call BIS_fnc_taskPatrol;
		sleep 20;
		
		_plane = createVehicle [([PLANE_TYPE] call BIS_fnc_selectRandom), [0,0,0], [], 0, "FLY"];
		 
		_plane addEventHandler ["Fired",{
			(_this select 0) setVehicleAmmo 1
		}];
		 
		_pilotguy = [[0,0,0], EAST, ["O_Fighter_Pilot_F"],[],[],[],[],[],232] call BIS_fnc_spawnGroup;
		 
		((units _pilotguy) select 0) moveInDriver _plane;
		 
		_wpcas = _pilotguy addWaypoint [getmarkerPos "Destroy_And_EliminateMarker", 500];
		_wpcas setWaypointType "LOITER";
		_wpcas setWaypointLoiterRadius 3500;
		_wpcas setWaypointLoiterType "CIRCLE_L";
		_wpcas setWaypointBehaviour "AWARE";
		_wpcas setWaypointCombatMode "RED";
		[_pilotguy, _fuzzyPos, 1000 + (random 4000)] call BIS_fnc_taskPatrol;
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	DetruireTourDeComMissionUp = true; publicVariable "DetruireTourDeComMissionUp";
	DetruireTourDeCom_SUCCESS = false; publicVariable "DetruireTourDeCom_SUCCESS";


	
while { DetruireTourDeComMissionUp } do {
	

	
	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]
	 if (!alive DetruireTourDeComObj) exitWith {
	
		//-------------------- DE-BRIEFING
		sleep 5;
		DetruireTourDeComMissionUp = false; publicVariable "DetruireTourDeComMissionUp";
		DetruireTourDeCom_SUCCESS = true;
		_CompleteText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>REUSSIE</t><br/>____________________<br/>La Tour est détruite! Bravo!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _CompleteText; publicVariable "GlobalHint"; hint parseText _CompleteText;
		showNotification = ["CompletedMission", Destroy_And_EliminateMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"]; publicVariable "Destroy_And_EliminateMarker";
		_null = ["DETRUIRETOUR", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["DETRUIRETOUR"] call BIS_fnc_deleteTask; 
		
		//--------------------- DELETE
		
		sleep 120;

		{deletevehicle _x} foreach DetruireTourDeComunits;
		{deletevehicle _x} foreach DetruireTourDeComunits_veh;
		{deletevehicle _x} foreach DetruireTourDeComunits_squad;
		DetruireTourDeComunits = [];
		DetruireTourDeComunits_veh = [];
		DetruireTourDeComunits_squad = [];
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;	
	[_flatPos, _spawnedObjects]spawn {
		
		deleteVehicle nearestObject[(_this select 0), "Land_TTowerBig_2_ruins_F"];
		{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
		} foreach (_this select 1);
		};	
	};

};