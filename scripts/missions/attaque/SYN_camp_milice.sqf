/*
Last modified: 

	01/11/2022 by [MF] Ricky

Description:

	Mission Camp SYN

*/

private ["_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_aliveInZone"];
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

//----Spawn obj
private _objective = selectRandom ["Land_Cargo_HQ_V2_F"];
CAMPObj = createVehicle [_objective, _flatPos, [], 0, "CAN_COLLIDE"];

//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["INVASIONMarker", "INVASIONCircle"];
	INVASIONMarkerText = "Camp Syndicate"; publicVariable "INVASIONMarkerText";
	"INVASIONMarker" setMarkerText "Camp Syndicate"; publicVariable "INVASIONMarker";
	publicVariable "CAMPObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Camp Syndicate</t><br/>____________________<br/>Un drône de l'OTAN a repéré un possible camp Syndicate dans le coin<br/>...Rendez-vous sur zone et nettoyez le camp.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Camp Syndicate"]; publicVariable "showNotification";
	INVASIONMarkerText = "Camp Syndicate"; publicVariable "INVASIONMarkerText";

	[west,["CAMPMILICE"],["Un drône de l'OTAN a repéré un possible camp Syndicate dans le coin.<br/>...Rendez-vous sur zone et nettoyez le camp.", "Camp Syndicate", "Camp Syndicate","INVASIONMarker"],_fuzzyPos,"Created",0,true,"target",true] call BIS_fnc_taskCreate;

	_marqueur = createMarker ["marqueur_attaque_syndicate_milice", _fuzzyPos];
	_marqueur setMarkerType "selector_selectedMission";
	"marqueur_attaque_syndicate_milice" setMarkerSize [2, 2];
	"marqueur_attaque_syndicate_milice" setMarkerColor "ColorBlue";

private _noSpawning = 500;

		_barrage_mission = [] execVM "mission\barrage\CAMP\SYN_barrage.sqf";
		_barrage_mission2 = [] execVM "mission\barrage\CAMP\SYN_barrage_1.sqf";
		_barrage_mission3 = [] execVM "mission\barrage\CAMP\SYN_barrage_2.sqf";
		
		
//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "ParaShockTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos CAMPObj,50 + random 200] call BIS_fnc_taskPatrol;
	CAMPunits = CAMPunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "BanditCombatGroup")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos CAMPObj,50 + random 200] call BIS_fnc_taskPatrol;
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};




private _enemiesArray = [objNull];

	
	
	//=====defining vehicles=========
	_Randomvehicle = ["I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F","I_C_Offroad_02_unarmed_brown_F","I_G_Offroad_01_armed_F","I_G_Offroad_01_AT_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_flatPos, 10, 300, 5, 0, 0.3, 0, [], (getPos CAMPObj)] call BIS_fnc_findSafePos;
		_Vehiclegroup1 = createGroup Independent;
		_vehicletype = selectRandom _Randomvehicle;
		_vehicle1 = _vehicletype createVehicle _randomPos;
		createvehiclecrew _vehicle1;
		(crew _vehicle1) join _Vehiclegroup1;
		_vehpatrolgroupamount = _vehpatrolgroupamount + 1;
		_Vehiclegroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _vehpatrolgroupamount]];
		_vehicle1 lock 3;
		[_Vehiclegroup1, _flatPos, 200 + (random 200)] call BIS_fnc_taskPatrol;
		{_x addCuratorEditableObjects [[_vehicle1] + units _Vehiclegroup1, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _Vehiclegroup1) + [_vehicle1];
		CAMPunits_veh = CAMPunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	 _infunits= ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_3_F"];
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [CAMPObj, ["house","building"], 100];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;


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
			CAMPunits_squad = CAMPunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};
	
		private _staticgroupamount = 0;
	
	//=====defining static=========
	private _Randomstatic = ["I_HMG_01_high_F"];
	
	for "_i" from 0 to (1 + (random 2)) do {
		_randomPos = [_fuzzyPos,random 20,10, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
		_staticgroup1 = createGroup Independent;
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
	_trg setTriggerActivation [Independent, "PRESENT", true];
	_trg setTriggerStatements ["this", "hint 'Civilian near player'", "hint 'no civilian near'"];

while { CAMPMissionUp } do {
	//--------------------------------------------- COUNT UNITS ALIVE
	
	_aliveInZone = {[_trg,_x] call bis_fnc_inTrigger && side _x == Independent  && alive _x} count AllUnits;  	  

	//--------------------------------------------- NO UNITS OK
	
	if (_aliveInZone < 5) then
	{
		//-------------------- DE-BRIEFING
		sleep 10;
		CAMPMissionUp = false; publicVariable "CAMPMissionUp";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", INVASIONMarkerText]; publicVariable "showNotification";
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

		deleteMarker "marqueur_attaque_syndicate_milice";			
	};	
};