/*
Last modified: 

	28 Novembre By [MF] Ricky

Description:

	Mission LOG

*/


private ["_x","_object","_object2","_briefing","_enemiesArray","_fuzzyPos","_completeText","_failedText"];
LOGunits = [];
LOGunits_veh = [];
LOGunits_squad = [];
private _groupsArray = [];
private _spawnedUnits = [];

//==================== PREPARE MISSION =======================

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

//----Spawn obj
private _objective = selectRandom ["Land_HelipadEmpty_F"];
LOGObj = createVehicle [_objective, _flatPos, [], 0, "CAN_COLLIDE"];

	

//-------------------- SPAWN OBJECTIVE (okay okay, setPos not spawn/create)

	_object = "C_Van_01_fuel_F" createVehicle getMarkerPos "depside";
	_object2 = "C_Van_01_fuel_F" createVehicle getMarkerPos "depside4";


	
//-------------------- BRIEFING
	
	
	_fuzzyPos = [((_flatPos select 0) - 10) + (random 10),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"];
	Voler_And_LOGMarkerText = "Livrer deux camions de Gasoil"; publicVariable "Voler_And_LOGMarkerText";
	"Voler_And_LOGMarker" setMarkerText "Livrer deux camions de Gasoil"; publicVariable "Voler_And_LOGMarker";
	publicVariable "LOGObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Livrer deux camions de Gasoil</t><br/>____________________<br/>Des civils nous ont signalé la présence de forces hostiles dans cette zone.<br/>C'est l'occasion de lâcher quelques balles...Rendez-vous sur zone et libérer la ville.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Livrer deux camions de Gasoil"]; publicVariable "showNotification";
	Voler_And_LOGMarkerText = "Livrer deux camions de Gasoil"; publicVariable "Voler_And_LOGMarkerText";
	
	[west,["LIVRERGASOIL"],["Livrer deux camions de Gasoil dans cette zone.<br/>Livrer deux camions de Gasoil...Rendez-vous sur zone et Livrer deux camions de Gasoil.", "Livrer deux camions de Gasoil", "Livrer deux camions de Gasoil","Voler_And_LOGMarker"],(getMarkerPos "Voler_And_LOGMarker"),"Created",0,true,"refuel",true] call BIS_fnc_taskCreate;


private _noSpawning = 500;

		_barrage_mission = [] execVM "mission\barrage\LOG\SYN_barrage.sqf";
		_barrage_mission2 = [] execVM "mission\barrage\LOG\SYN_barrage_1.sqf";
		_barrage_mission3 = [] execVM "mission\barrage\LOG\SYN_barrage_2.sqf";

//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, resistance, (configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "ParaCombatGroup")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos LOGObj,50 + random 200] call BIS_fnc_taskPatrol;
	LOGunits = LOGunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, resistance, (configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "BanditCombatGroup")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos LOGObj,50 + random 200] call BIS_fnc_taskPatrol;
	LOGunits_squad = LOGunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

	private _enemiesArray = [objNull];

	
	
	//=====defining vehicles=========
private _vehicletypes = ["I_G_Offroad_01_armed_F","I_static_AA_F","I_static_AT_F","I_HMG_01_high_F"];

//vehicles
private _RandomVicAmount = 0;
for "_x" from 1 to 5 do {
	private _randomPos = [_fuzzyPos, 10, 75, 5, 0, 0.3, 0, [], _fuzzyPos] call BIS_fnc_findSafePos;
	
	private _grp1 = createGroup resistance;
	_RandomVicAmount = _RandomVicAmount + 1;
	_grp1 setGroupIdGlobal [format ['rescue-RandVic-%1', _RandomVicAmount]];
	private _vehicletype = selectRandom _vehicletypes;
	private _vehc =  _vehicletype createVehicle _randompos;
	_vehc allowCrewInImmobile true;
	_vehc lock 2;
	
	if (_vehicletype == "I_G_Offroad_01_armed_F") then {
	createVehicleCrew _vehc;
		(crew _vehc) join _grp1;
		[_grp1, _fuzzyPos, 275] call BIS_fnc_taskPatrol;
		_grp1 setSpeedMode "LIMITED";
	}else{
	private _grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _fuzzyPos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (random 360);
	};

	_groupsArray = _groupsArray + [_grp1];
	_spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];
	{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} forEach allCurators;
};
	
	sleep 0.1;
	
	

	_infunits = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F","I_C_Soldier_Bandit_2_F"];
	
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [LOGObj, ["house","building"], 400];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;
		if (_infBuildingAmount > 20 ) then {_GarrisonedBuildings = _infBuildingAmount*3/4;};
		if (_infBuildingAmount > 40 ) then {_GarrisonedBuildings = _infBuildingAmount*3/4;};
		if (_infBuildingAmount > 60 ) then {_GarrisonedBuildings = 30;};

		for "_i" from 0 to _GarrisonedBuildings do {
			_garrisongroup = createGroup resistance;
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
			LOGunits_squad = LOGunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};
	

	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	LOGMissionUp = true; publicVariable "LOGMissionUp";
	LOG_SUCCESS = false; publicVariable "LOG_SUCCESS";


	


	while { LOGMissionUp } do {

	sleep 0.3;

	
	//------------------------------------------ IF VEHICLE IS DESTROYED [FAIL]
	
	if ({alive _x} count [_object,_object2] < 2) exitWith {
	
		sleep 0.3;
		

		//-------------------- DE-BRIEFING

		sleep 5;
		LOGMissionUp = false; publicVariable "LOGMissionUp";
		_failedText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>ECHOUEE</t><br/>____________________<br/>Camions détruits!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		showNotification = ["CompletedSideMission", Voler_And_LOGMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"]; publicVariable "Voler_And_LOGMarker";
		_null = ["LIVRERGASOIL", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["LIVRERGASOIL"] call BIS_fnc_deleteTask; 
		
		
	
		//--------------------- DELETE, DESPAWN, HIDE and RESET
	
		LOG_SUCCESS = false; publicVariable "LOG_SUCCESS";			// reset var for next cycle
		sleep 120;

		{deletevehicle _x} foreach LOGunits;
		{deletevehicle _x} foreach LOGunits_veh;
		{deletevehicle _x} foreach LOGunits_squad;
		LOGunits = [];
		LOGunits_veh = [];
		LOGunits_squad = [];
		deleteVehicle LOGObj;
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;		
		{ deleteVehicle _x } forEach [_Object,_Object2];
		{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;			
	};
	
		//-------------------------------------------- THE INTEL WAS RECOVERED [SUCCESS]
	
	if (({alive _x} count [_object,_object2] > 0) && (_object distance getMarkerPos "Voler_And_LOGMarker" < 50) && (_object2 distance getMarkerPos "Voler_And_LOGMarker" < 50)) then
	{
	LOG_SUCCESS = true; publicVariable "LOG_SUCCESS";

	
		sleep 0.3;
		
		//-------------------- DE-BRIEFING

		sleep 10;
		LOGMissionUp = false; publicVariable "LOGMissionUp";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", Voler_And_LOGMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Voler_And_LOGMarker", "Voler_And_LOGCircle"]; publicVariable "Voler_And_LOGMarker";
		_null = ["LIVRERGASOIL", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["LIVRERGASOIL"] call BIS_fnc_deleteTask; 
		
		
	
		//--------------------- DELETE, DESPAWN, HIDE and RESET
	
		LOG_SUCCESS = false; publicVariable "LOG_SUCCESS";			// reset var for next cycle
		sleep 120;													// sleep to hide despawns from players. default 120, 1 for testing	
		{deletevehicle _x} foreach LOGunits;
		{deletevehicle _x} foreach LOGunits_veh;
		{deletevehicle _x} foreach LOGunits_squad;
		LOGunits = [];
		LOGunits_veh = [];
		LOGunits_squad = [];
		deleteVehicle LOGObj;
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;		
		{ deleteVehicle _x } forEach [_Object,_Object2];
		{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;
		
	};	
};	