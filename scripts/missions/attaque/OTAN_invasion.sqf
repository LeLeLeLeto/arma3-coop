/*
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_aliveInZone","_aoUnderAttack"];
INVASIONunits = [];
INVASIONunits_veh = [];
INVASIONunits_squad = [];



//==================== PREPARE MISSION =======================
//----Pick town
private _towns = nearestLocations [(getMarkerPos "Base"), ["CityCenter","NameCity","NameCityCapital","NameLocal"], 25000];

private _accepted = false;
private ["_RandomTownPosition"];
while {!_accepted} do {
	_RandomTownPosition = position (selectRandom _towns);	
	_accepted = true;
	{
		private _NearBaseLoc = _RandomTownPosition distance (getMarkerPos "Base");
		if (_NearBaseLoc < 1000) then {_accepted = false;};
	} 
};

//----Spawn obj
private _objective = selectRandom ["Land_HelipadEmpty_F"];
INVASIONObj = createVehicle [_objective, _RandomTownPosition, [], 0, "CAN_COLLIDE"];



//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_RandomTownPosition select 0) - 50) + (random 100),((_RandomTownPosition select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["INVASIONMarker", "INVASIONCircle"];
	INVASIONMarkerText = "Libérer la zone"; publicVariable "INVASIONMarkerText";
	"INVASIONMarker" setMarkerText "Libérer la zone"; publicVariable "INVASIONMarker";
	publicVariable "INVASIONObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Libérer la zone</t><br/>____________________<br/>Des civils nous ont signalé la présence de forces hostiles dans cette zone.<br/>C'est l'occasion de lâcher quelques balles...Rendez-vous sur zone et libérer la ville.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Libérer la zone"]; publicVariable "showNotification";
	INVASIONMarkerText = "Libérer la zone"; publicVariable "INVASIONMarkerText";
	[west,["REPRENDRELAVILLE"],["Des civils nous ont signalé la présence de forces hostiles dans cette zone.<br/>C'est l'occasion de lâcher quelques balles...Rendez-vous sur zone et libérer la ville.", "Libérer la zone", "Libérer la zone","INVASIONMarker"],_fuzzyPos,"Created",0,true,"attack",true] call BIS_fnc_taskCreate;

	_marqueur = createMarker ["marqueur_attaque_otan", _fuzzyPos];
	_marqueur setMarkerType "selector_selectedMission";
	"marqueur_attaque_otan" setMarkerSize [2, 2];
	"marqueur_attaque_otan" setMarkerColor "ColorBlue";

//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos INVASIONObj,50 + random 200] call BIS_fnc_taskPatrol;
	INVASIONunits = INVASIONunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AA")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos INVASIONObj,50 + random 200] call BIS_fnc_taskPatrol;
	INVASIONunits_squad = INVASIONunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AT")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos INVASIONObj,50 + random 200] call BIS_fnc_taskPatrol;
	INVASIONunits_squad = INVASIONunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_SniperTeam")] call BIS_fnc_spawnGroup;
	_spawnGroup_squad setBehaviour "COMBAT";	
	INVASIONunits_squad = INVASIONunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

	private _enemiesArray = [objNull];

	
	
	//=====defining vehicles=========
	_Randomvehicle = ["B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_MBT_01_TUSK_F","B_Heli_Attack_01_dynamicLoadout_F","B_APC_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F","B_T_APC_Tracked_01_AA_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_RandomTownPosition, 10, 300, 5, 0, 0.3, 0, [], (getPos INVASIONObj)] call BIS_fnc_findSafePos;
		_Vehiclegroup1 = createGroup EAST;
		_vehicletype = selectRandom _Randomvehicle;
		_vehicle1 = _vehicletype createVehicle _randomPos;
		createvehiclecrew _vehicle1;
		(crew _vehicle1) join _Vehiclegroup1;
		_vehpatrolgroupamount = _vehpatrolgroupamount + 1;
		_Vehiclegroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _vehpatrolgroupamount]];
		_vehicle1 lock 3;
		[_Vehiclegroup1, _RandomTownPosition, 200 + (random 200)] call BIS_fnc_taskPatrol;
		{_x addCuratorEditableObjects [[_vehicle1] + units _Vehiclegroup1, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _Vehiclegroup1) + [_vehicle1];
		INVASIONunits_veh = INVASIONunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	

	_infunits = ["B_Engineer_F","B_Medic_F","B_Soldier_A_F","B_Soldier_AA_F","B_Soldier_AAA_F","B_Soldier_AAR_F","B_Soldier_AAT_F","B_Soldier_AR_F","B_Soldier_AT_F","B_Soldier_Exp_F","B_Soldier_F","B_Soldier_GL_F","B_Soldier_LAT_F","B_Soldier_LAT2_F","B_soldier_M_F","B_Soldier_Repair_F","B_Soldier_SL_F","B_Soldier_TL_F"];
	
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [INVASIONObj, ["house","building"], 400];
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
				[_unit] join _garrisongroup;
			};
			_enemiesArray = _enemiesArray + (units _garrisongroup);
			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
			INVASIONunits_squad = INVASIONunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	INVASIONMissionUp = true; publicVariable "INVASIONMissionUp";
	INVASION_SUCCESS = false; publicVariable "INVASION_SUCCESS";

	//--------------------------------------------- TRIGGER TO COUNT UNITS ALIVE
	
	_trg = createTrigger ["EmptyDetector", _fuzzyPos];
	_trg setTriggerArea [350, 350, 0, false];
	_trg setTriggerActivation [EAST, "PRESENT", true];
	_trg setTriggerStatements ["this", "hint 'Civilian near player'", "hint 'no civilian near'"];
	
while { INVASIONMissionUp } do {
	//--------------------------------------------- COUNT UNITS ALIVE
	
	_aliveInZone = {[_trg,_x] call bis_fnc_inTrigger && side _x == EAST  && alive _x} count AllUnits;  	  

	//--------------------------------------------- NO UNITS OK
	
	if (_aliveInZone < 10) then
	{
		//-------------------- DE-BRIEFING

		INVASIONMissionUp = false; publicVariable "INVASIONMissionUp";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", INVASIONMarkerText]; publicVariable "showNotification";
		// _aoUnderAttack = [] execVM "mission\Defense\OTAN_Invasion_Defend.sqf";
		sleep 8;		
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["INVASIONMarker", "INVASIONCircle"]; publicVariable "INVASIONMarker";
		_null = ["REPRENDRELAVILLE", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["REPRENDRELAVILLE"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;

		{deletevehicle _x} foreach INVASIONunits;
		{deletevehicle _x} foreach INVASIONunits_veh;
		{deletevehicle _x} foreach INVASIONunits_squad;
		INVASIONunits = [];
		INVASIONunits_veh = [];
		INVASIONunits_squad = [];
		deleteVehicle INVASIONObj;
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;		

		deleteMarker "marqueur_attaque_otan";
	};	
};