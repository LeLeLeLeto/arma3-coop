/*
Author:

	Quiksilver
	
Last modified:

	29 Novembre 2022 by [MF] Ricky
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_failedText","_aliveInZone"];

VolVehiculeunits = [];
VolVehiculeunits_veh = [];
VolVehiculeunits_squad = [];

private _missionType = selectRandom[
    ['a Strider HMG', 'I_MRAP_03_hmg_F'],
    ['a Strider GMG', 'I_MRAP_03_gmg_F'],
    ['a Nyx Canon', 'I_LT_01_cannon_F'],
    ['a Nyx AT', 'I_LT_01_AT_F'],
    ['an MBT-52 Kuma', 'I_MBT_03_cannon_F'],
    ['a Nyx AA', 'I_LT_01_AA_F'],
    ['an AFV-4 Gorgon', 'I_APC_Wheeled_03_cannon_F'],
    ['an Hellcat', 'I_Heli_light_03_F'],
    ['a Mora', 'I_APC_tracked_03_cannon_F'],
    ['a Zamak MLRS', 'I_Truck_02_MRL_F']
];

private _description = _missionType select 0;
private _assetType = _missionType select 1;



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

	//-------------------- SPAWN OBJECTIVE

	private _tentDirection = random 360;

	private _hangar = "Land_HelipadEmpty_F" createVehicle _flatPos;
	VolVehiculeObj = _assetType createVehicle _flatPos;
		
		waitUntil {!isNull VolVehiculeObj};
		VolVehiculeObj lock 0;
		{
			_x setVectorUp surfaceNormal position _x;
			_x setDir _tentDirection;
		}forEach[_hangar, VolVehiculeObj];
	


//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"];
	Voler_And_LOGMarkerText = "Voler le véhicule"; publicVariable "Voler_And_LOGMarkerText";
	"Voler_And_LOGMarker" setMarkerText "Voler le véhicule"; publicVariable "Voler_And_LOGMarker";
	publicVariable "VolVehiculeObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Voler le véhicule</t><br/>____________________<br/>Les forces AAF protègent un véhicule de valeur dans cette zone.<br/>Partez à sa recherche et ramenez-le à voter base pour pouvoir l'utiliser...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Voler le véhicule"]; publicVariable "showNotification";
	Voler_And_LOGMarkerText = "Voler le véhicule"; publicVariable "Voler_And_LOGMarkerText";
	[west,["GUERILLA"],["L'OTAN nous a informé qu'un véhicule précieux était fortement protéger dans cette zone.<br/>Récupérer le véhicule et ramener le à la base pour l'utiliser.", "Voler le véhicule", "Voler le véhicule","Voler_And_LOGMarker"],(getMarkerPos "Voler_And_LOGMarker"),"Created",0,true,"car",true] call BIS_fnc_taskCreate; 

//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos VolVehiculeObj,50 + random 200] call BIS_fnc_taskPatrol;
	VolVehiculeunits = VolVehiculeunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos VolVehiculeObj,50 + random 200] call BIS_fnc_taskPatrol;
	VolVehiculeunits_squad = VolVehiculeunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos VolVehiculeObj,50 + random 200] call BIS_fnc_taskPatrol;
	VolVehiculeunits_squad = VolVehiculeunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;	
	_spawnGroup_squad setBehaviour "COMBAT";	
	VolVehiculeunits_squad = VolVehiculeunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

private _enemiesArray = [objNull];

	
	
	//=====defining vehicles=========
	_Randomvehicle = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MBT_03_cannon_F","I_LT_01_cannon_F","I_LT_01_AT_F","I_LT_01_AA_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_fuzzyPos, 10, 300, 5, 0, 0.3, 0, [], (getPos VolVehiculeObj)] call BIS_fnc_findSafePos;
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
		VolVehiculeunits_veh = VolVehiculeunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;

	
	_infunits = ["I_soldier_F","I_officer_F","I_Soldier_lite_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_M_F","I_medic_F","I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F"];
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [VolVehiculeObj, ["house","building"], 400];
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
			VolVehiculeunits_squad = VolVehiculeunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};
	
	
	sleep 0.1;
	
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	VolVehiculeMissionUp = true; publicVariable "VolVehiculeMissionUp";
	VolVehicule_SUCCESS = false; publicVariable "VolVehicule_SUCCESS";


	
while { VolVehiculeMissionUp } do {
	
	//--------------------------------------------- IF PACKAGE AT HOME AND ALIVE [SUCCESS]
	
	if ((alive VolVehiculeObj) && (VolVehiculeObj distance getMarkerPos "respawn_west" < 100)) then
	{
		//-------------------- DE-BRIEFING
		sleep 5;
		VolVehiculeMissionUp = false; publicVariable "VolVehiculeMissionUp";
		VolVehicule_SUCCESS = true;
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedMission", Voler_And_LOGMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"]; publicVariable "Voler_And_LOGMarker";
		_null = ["GUERILLA", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["GUERILLA"] call BIS_fnc_deleteTask; 
		
		
		
		//--------------------- DELETE
		
		sleep 30;

		{deletevehicle _x} foreach VolVehiculeunits;
		{deletevehicle _x} foreach VolVehiculeunits_veh;
		{deletevehicle _x} foreach VolVehiculeunits_squad;
		VolVehiculeunits = [];
		VolVehiculeunits_veh = [];
		VolVehiculeunits_squad = [];
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;
	};
	
	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]
	 if (!alive VolVehiculeObj) exitWith {
	
		//-------------------- DE-BRIEFING
		sleep 5;
		VolVehiculeMissionUp = false; publicVariable "VolVehiculeMissionUp";
		VolVehicule_FAIL = true;
		_failedText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>ECHEC</t><br/>____________________<br/>Echec!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		showNotification = ["FailedMission", Voler_And_LOGMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"]; publicVariable "Voler_And_LOGMarker";
		_null = ["GUERILLA", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["GUERILLA"] call BIS_fnc_deleteTask; 
		
		//--------------------- DELETE
		
		sleep 120;

		{deletevehicle _x} foreach VolVehiculeunits;
		{deletevehicle _x} foreach VolVehiculeunits_veh;
		{deletevehicle _x} foreach VolVehiculeunits_squad;
		VolVehiculeunits = [];
		VolVehiculeunits_veh = [];
		VolVehiculeunits_squad = [];
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;
	};

};