/*
Last modified: 

	28 Novembre 2022 by [MF] Ricky

Description:

	Voler Prototype

*/
private ["_ProtoPos","_mkr_array","_mkr_position","_fuzzyPos","_x","_briefing","_completeText","_PTdir","_dir","_pos","_spawnedObjects","_spawnedObjects2"];

PROTOunits = [];
PROTOunits_veh = [];
PROTOunits_squad = [];


private _PrototypeTypes = ["O_Plane_Fighter_02_Stealth_F","O_Plane_CAS_02_dynamicLoadout_F","O_T_VTOL_02_infantry_dynamicLoadout_F","O_T_VTOL_02_vehicle_dynamicLoadout_F"];


//-------------------- FIND POSITION FOR OBJECTIVE


	_mkr_array = ["PROTO_GUERILLA","PROTO_REBEL","PROTO_SELAKANO","PROTO_AAC","PROTO_MOLOS"];
	_mkr_position = getmarkerpos (_mkr_array select floor (random (count _mkr_array)));


//-------------------- 2. SPAWN OBJECTIVES

	_PTdir = random 360;
	
	sleep 1;
	
	PROTOOBJ = (selectRandom _PrototypeTypes) createVehicle _mkr_position;
	waitUntil {!isNull PROTOOBJ};
	PROTOOBJ setDir _PTdir;
	
	sleep 1;

	

//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_mkr_position select 0) - 50) + (random 100),((_mkr_position select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"];
	Voler_And_LOGMarkerText = "Récupérer le Prototype"; publicVariable "Voler_And_LOGMarkerText";
	"Voler_And_LOGMarker" setMarkerText "Récupérer le Prototype"; publicVariable "Voler_And_LOGMarker";
	publicVariable "PROTOOBJ";publicVariable "PROTOObj2";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Récupérer le Prototype</t><br/>____________________<br/>Les forces Russes testent un nouveau prototype.<br/>Partez à sa recherche et ramenez-le à la base...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Récupérer le Prototype"]; publicVariable "showNotification";
	Voler_And_LOGMarkerText = "Récupérer le Prototype"; publicVariable "Voler_And_LOGMarkerText";
	[west,["VOLPROTO"],["Les forces Russes testent un nouveau prototype.<br/>Partez à sa recherche et ramenez-le à la base...", "Récupérer le Prototype", "Récupérer le Prototype","Voler_And_LOGMarker"],(getMarkerPos "Voler_And_LOGMarker"),"Created",0,true,"mine",true] call BIS_fnc_taskCreate; 


	
	
//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos PROTOOBJ,50 + random 200] call BIS_fnc_taskPatrol;
	PROTOunits = PROTOunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos PROTOOBJ,50 + random 200] call BIS_fnc_taskPatrol;
	PROTOunits_squad = PROTOunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos PROTOOBJ,50 + random 200] call BIS_fnc_taskPatrol;
	PROTOunits_squad = PROTOunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


	private _enemiesArray = [objNull];
	
	
	//=====defining vehicles=========
	_Randomvehicle = ["O_G_Offroad_01_armed_F","O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F","O_Heli_Attack_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_black_F","O_Heli_Light_02_F","O_Heli_Light_02_v2_F","O_MBT_04_command_F","O_MBT_04_cannon_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_fuzzyPos, 10, 300, 5, 0, 0.3, 0, [], (getPos PROTOOBJ)] call BIS_fnc_findSafePos;
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
		PROTOunits_veh = PROTOunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	

	_infunits = ["O_R_Soldier_TL_F","O_R_Soldier_AR_F","O_R_soldier_exp_F","O_R_Soldier_GL_F","O_R_Soldier_LAT_F","O_R_soldier_M_F","O_R_Patrol_Soldier_M_F","O_R_Patrol_Soldier_Medic","O_R_Patrol_Soldier_Engineer_F"];
	
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [PROTOOBJ, ["house","building"], 400];
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
			PROTOunits_squad = PROTOunits_squad + (units _garrisongroup);
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
		 
		_wpcas = _pilotguy addWaypoint [getmarkerPos "Voler_And_LOGMarker", 500];
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
		 
		_wpcas = _pilotguy addWaypoint [getmarkerPos "Voler_And_LOGMarker", 500];
		_wpcas setWaypointType "LOITER";
		_wpcas setWaypointLoiterRadius 3500;
		_wpcas setWaypointLoiterType "CIRCLE_L";
		_wpcas setWaypointBehaviour "AWARE";
		_wpcas setWaypointCombatMode "RED";
		[_pilotguy, _fuzzyPos, 1000 + (random 4000)] call BIS_fnc_taskPatrol;
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	PROTOMissionUp = true; publicVariable "PROTOMissionUp";
	PROTO_SUCCESS = false; publicVariable "PROTO_SUCCESS";


	
while { PROTOMissionUp } do {
	

	
	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]
	if (!alive PROTOOBJ) then {
	
			//-------------------- DE-BRIEFING
			sleep 5;
			PROTOMissionUp = false; publicVariable "PROTOMissionUp";
			PROTO_SUCCESS = true;
			_CompleteText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>ECHOUEE</t><br/>____________________<br/>Portotype détruit!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
			GlobalHint = _CompleteText; publicVariable "GlobalHint"; hint parseText _CompleteText;
			showNotification = ["CompletedMission", Voler_And_LOGMarkerText]; publicVariable "showNotification";
			{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"]; publicVariable "Voler_And_LOGMarker";
			_null = ["VOLPROTO", "FAILED"] spawn BIS_fnc_taskSetState;
			sleep 5;
			["VOLPROTO"] call BIS_fnc_deleteTask; 
			
			//--------------------- DELETE
			
			sleep 120;

			{deletevehicle _x} foreach PROTOunits;
			{deletevehicle _x} foreach PROTOunits_veh;
			{deletevehicle _x} foreach PROTOunits_squad;
			{deleteVehicle _x;} forEach [PROTOOBJ];

			PROTOunits = [];
			PROTOunits_veh = [];
			PROTOunits_squad = [];


			{deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;				
	};
	
			if ((alive PROTOObj) && (PROTOObj distance getMarkerPos "respawn_west" < 100)) then {
	
			//-------------------- DE-BRIEFING
			sleep 5;
			PROTOMissionUp = false; publicVariable "PROTOMissionUp";
			PROTO_SUCCESS = true;
			_CompleteText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#0000FF'>REUSSIE</t><br/>____________________<br/>Prototype sécurisé! Bravo!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
			GlobalHint = _CompleteText; publicVariable "GlobalHint"; hint parseText _CompleteText;
			showNotification = ["CompletedMission", Voler_And_LOGMarkerText]; publicVariable "showNotification";
			{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"]; publicVariable "Voler_And_LOGMarker";
			_null = ["VOLPROTO", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
			sleep 5;
			["VOLPROTO"] call BIS_fnc_deleteTask; 
			
			//--------------------- DELETE
			
			sleep 120;

			{deletevehicle _x} foreach PROTOunits;
			{deletevehicle _x} foreach PROTOunits_veh;
			{deletevehicle _x} foreach PROTOunits_squad;


			PROTOunits = [];
			PROTOunits_veh = [];
			PROTOunits_squad = [];


			{deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;				
	};
	

};