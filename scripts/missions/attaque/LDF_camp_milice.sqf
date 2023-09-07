/*
Last modified: 

	10 Novembre 2022 by [MF] Ricky

Description:

	Mission Camp LDF

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

//================Create camp

CAMPObj = "Land_Cargo_HQ_V3_F" createVehicle _objPos;
{_x addCuratorEditableObjects [[CAMPObj], false];} forEach allCurators;

_barrier1 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) - 12.625, (_objPos select 1) - 1.625, 0], [], 0, "CAN_COLLIDE"];
_barrier1 setDir 90;
_barrier2 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) + 2.766, (_objPos select 1) - 11.22, 0], [], 0, "CAN_COLLIDE"];
_barrier3 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) + 17.01, (_objPos select 1) - 5.105, 0], [], 0, "CAN_COLLIDE"];
_barrier3 setDir 90;
_barrier4 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) + 16.738, (_objPos select 1) + 3.014, 0], [], 0, "CAN_COLLIDE"];
_barrier4 setDir 90;
_barrier5 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) + 0.62, (_objPos select 1) + 18.057, 0], [], 0, "CAN_COLLIDE"];
_barrier5 setDir 60;
sleep 1;
_barrier6 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) - 4.782, (_objPos select 1) + 21.032, 0], [], 0, "CAN_COLLIDE"];
_barrier6 setDir 162;
_barrier7 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) - 12.57, (_objPos select 1) + 18.481, 0], [], 0, "CAN_COLLIDE"];
_barrier7 setDir 162;
_barrier8 = createVehicle ["Land_HBarrier_Big_F", [(_objPos select 0) - 14.374, (_objPos select 1) + 12.748, 0], [], 0, "CAN_COLLIDE"];
_barrier8 setDir 255;
_barrier9 = createVehicle ["Land_HBarrier_5_F", [(_objPos select 0) + 3.57, (_objPos select 1) + 7.178, 0], [], 0, "CAN_COLLIDE"];
_barrier10 = createVehicle ["Land_HBarrier_5_F", [(_objPos select 0) + 11.142, (_objPos select 1) - 8.235, 0], [], 0, "CAN_COLLIDE"];
sleep 1;
_barrier11 = createVehicle ["Land_HBarrier_3_F", [(_objPos select 0) + 6.848, (_objPos select 1) + 6.113, 0], [], 0, "CAN_COLLIDE"];
_barrier11 setDir 90;
_barrier12 = createVehicle ["Land_HBarrier_3_F", [(_objPos select 0) - 9.506, (_objPos select 1) - 9.955, 0], [], 0, "CAN_COLLIDE"];
_barrier13 = createVehicle ["Land_HBarrier_3_F", [(_objPos select 0) + 12.816, (_objPos select 1) + 6.364, 0], [], 0, "CAN_COLLIDE"];
_barrier14 = createVehicle ["Land_HBarrier_3_F", [(_objPos select 0) + 1.576, (_objPos select 1) + 13.223, 0], [], 0, "CAN_COLLIDE"];
_barrier14 setDir 90;
_barrier15 = createVehicle ["Land_BagBunker_Small_F", [(_objPos select 0) - 11.095, (_objPos select 1) - 8.489, 0], [], 0, "CAN_COLLIDE"];
_barrier15 setDir 90;
sleep 1;
_barrier16 = createVehicle ["Land_BagBunker_Small_F", [(_objPos select 0) + 8.978, (_objPos select 1) - 10, 0], [], 0, "CAN_COLLIDE"];
_barrier17 = createVehicle ["Land_BagFence_Round_F", [(_objPos select 0) - 2.529, (_objPos select 1) - 12.673, 0], [], 0, "CAN_COLLIDE"];
_barrier18 = createVehicle ["Land_BagFence_Round_F", [(_objPos select 0) - 14.844, (_objPos select 1) + 1.233, 0], [], 0, "CAN_COLLIDE"];
_barrier18 setDir 37;
_barrier19 = createVehicle ["Land_BagFence_Round_F", [(_objPos select 0) - 16.423, (_objPos select 1) + 7.477, 0], [], 0, "CAN_COLLIDE"];
_barrier19 setDir 105;
_barrier20 = createVehicle ["Land_BagFence_Round_F", [(_objPos select 0) + 9.622, (_objPos select 1) + 12.51, 0], [], 0, "CAN_COLLIDE"];
_barrier20 setDir 196;
sleep 1;
_barrier21 = createVehicle ["Land_BagFence_Round_F", [(_objPos select 0) + 12.416, (_objPos select 1) + 9.819, 0], [], 0, "CAN_COLLIDE"];
_barrier21 setDir 241;
_barrier22 = createVehicle ["Land_BagFence_Short_F", [(_objPos select 0) - 4.383, (_objPos select 1) - 11.332, 0], [], 0, "CAN_COLLIDE"];
_barrier22 setDir 226;
_barrier23 = createVehicle ["Land_BagFence_Short_F", [(_objPos select 0) - 15.739, (_objPos select 1) + 3.055, 0], [], 0, "CAN_COLLIDE"];
_barrier23 setDir 260;
_barrier24 = createVehicle ["Land_BagFence_Short_F", [(_objPos select 0) - 14.979, (_objPos select 1) + 9.164, 0], [], 0, "CAN_COLLIDE"];
_barrier24 setDir 339;
_barrier25 = createVehicle ["Land_BagFence_Short_F", [(_objPos select 0) + 11.198, (_objPos select 1) + 11.652, 0], [], 0, "CAN_COLLIDE"];
_barrier25 setDir 46;
sleep 1;
_barrier26 = createVehicle ["Land_BagFence_Short_F", [(_objPos select 0) + 12.653, (_objPos select 1) + 7.985, 0], [], 0, "CAN_COLLIDE"];
_barrier26 setDir 91;
_barrier27 = createVehicle ["Land_Cargo_House_V3_F", [(_objPos select 0) - 8.893, (_objPos select 1) + 11.7, 0], [], 0, "CAN_COLLIDE"];
_barrier27 setDir 345;
_barrier28 = createVehicle ["Land_Cargo_Patrol_V3_F", [(_objPos select 0) - 3.722, (_objPos select 1) + 16.215, 0], [], 0, "CAN_COLLIDE"];
_barrier28 setDir 241;
_barrier29 = createVehicle ["Land_Cargo20_orange_F", [(_objPos select 0) + 13.832, (_objPos select 1) - 3.72, 0], [], 0, "CAN_COLLIDE"];
_barrier29 setDir 90;
sleep 1;

_spawnedObjects = [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8,_barrier9,_barrier10,_barrier11,_barrier12,_barrier13,_barrier14,_barrier15];
_spawnedObjects2 = [_barrier16,_barrier17,_barrier18,_barrier19,_barrier20,_barrier21,_barrier22,_barrier23_barrier24,_barrier25,_barrier26,_barrier27,_barrier28,_barrier29];

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
private _PAXGroup = createGroup Independent;

_PAX1 = _PAXGroup createUnit ["I_E_Soldier_LAT_F", [(_objPos select 0) + 9.224, (_objPos select 1) + 11.495, 0], [], 0, "CAN_COLLIDE"];
_PAX2 = _PAXGroup createUnit ["I_E_Soldier_A_F", [(_objPos select 0) - 11.201, (_objPos select 1) - 8.09, 0], [], 0, "CAN_COLLIDE"];
_PAX3 = _PAXGroup createUnit ["I_E_Soldier_SL_F", [(_objPos select 0) - 14.664, (_objPos select 1) + 2.788, 0], [], 0, "CAN_COLLIDE"];
_PAX4 = _PAXGroup createUnit ["I_E_Soldier_AR_F", [(_objPos select 0) - 15.09, (_objPos select 1) + 6.686, 0], [], 0, "CAN_COLLIDE"];
_PAX5 = _PAXGroup createUnit ["I_E_RadioOperator_F", [(_objPos select 0) + 9.223, (_objPos select 1) - 10.475, 0], [], 0, "CAN_COLLIDE"];
sleep 1;
_PAX6 = _PAXGroup createUnit ["I_E_Medic_F", [(_objPos select 0) + 11.656, (_objPos select 1) + 9.194, 0], [], 0, "CAN_COLLIDE"];
_PAX7 = _PAXGroup createUnit ["I_E_soldier_M_F", [(_objPos select 0) + 2.768, (_objPos select 1) + 11.345, 0], [], 0, "CAN_COLLIDE"];

_PAX8 = _PAXGroup createUnit ["I_E_Soldier_SL_F", [(_objPos select 0) - 9.764, (_objPos select 1) + 13.025, 0.6], [], 0, "CAN_COLLIDE"];
_PAX9 = _PAXGroup createUnit ["I_E_Soldier_TL_F", [(_objPos select 0) - 2.437, (_objPos select 1) + 15.473, 4.5], [], 0, "CAN_COLLIDE"];
_PAX10 = _PAXGroup createUnit ["I_E_Soldier_AR_F", [(_objPos select 0) - 3.529, (_objPos select 1) + 17.418, 4.5], [], 0, "CAN_COLLIDE"];
sleep 1;
_PAX11 = _PAXGroup createUnit ["I_E_RadioOperator_F", [(_objPos select 0) - 1.45, (_objPos select 1), 0.7], [], 0, "CAN_COLLIDE"];
_PAX12 = _PAXGroup createUnit ["I_E_Medic_F", [(_objPos select 0) + 4.872, (_objPos select 1) + 3.1, 0.7], [], 0, "CAN_COLLIDE"];
_PAX13 = _PAXGroup createUnit ["I_E_Soldier_LAT_F", [(_objPos select 0) - 1.572, (_objPos select 1) - 4.65, 3.2], [], 0, "CAN_COLLIDE"];
_PAX14 = _PAXGroup createUnit ["I_E_Soldier_A_F", [(_objPos select 0) - 2.064, (_objPos select 1) + 1.141, 3.2], [], 0, "CAN_COLLIDE"];
_PAX15 = _PAXGroup createUnit ["I_E_Soldier_TL_F", [(_objPos select 0) + 2.59, (_objPos select 1) + 2.788, 3.2], [], 0, "CAN_COLLIDE"];
_PAX16 = _PAXGroup createUnit ["I_E_soldier_M_F", [(_objPos select 0) + 5.646, (_objPos select 1) - 0.407, 3.2], [], 0, "CAN_COLLIDE"];
[_PAX1,_PAX2,_PAX3,_PAX4,_PAX5,_PAX6,_PAX7,_PAX8,_PAX9,_PAX10,_PAX11,_PAX12,_PAX13,_PAX14,_PAX15,_PAX16] joinSilent _PAXGroup;
sleep 1;

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
	INVASIONMarkerText = "Camp LDF"; publicVariable "INVASIONMarkerText";
	"INVASIONMarker" setMarkerText "Camp LDF"; publicVariable "INVASIONMarker";
	publicVariable "CAMPObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Camp LDF</t><br/>____________________<br/>Un drône de l'OTAN a repéré un possible camp LDF dans le coin<br/>...Rendez-vous sur zone et nettoyez le camp.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Camp LDF"]; publicVariable "showNotification";
	INVASIONMarkerText = "Camp LDF"; publicVariable "INVASIONMarkerText";
	[west,["CAMPMILICE"],["Un drône de l'OTAN a repéré un possible camp dans le coin.<br/>...Rendez-vous sur zone et nettoyez le camp.", "Camp LDF", "Camp LDF","INVASIONMarker"],_fuzzyPos,"Created",0,true,"target",true] call BIS_fnc_taskCreate;

	_marqueur = createMarker ["marqueur_attaque_ldf_milice", _fuzzyPos];
	_marqueur setMarkerType "selector_selectedMission";
	"marqueur_attaque_ldf_milice" setMarkerSize [2, 2];
	"marqueur_attaque_ldf_milice" setMarkerColor "ColorBlue";

 private _noSpawning = 500;

		_barrage_mission = [] execVM "mission\barrage\CAMP\SYN_barrage.sqf";
		_barrage_mission2 = [] execVM "mission\barrage\CAMP\SYN_barrage_1.sqf";
		_barrage_mission3 = [] execVM "mission\barrage\CAMP\SYN_barrage_2.sqf";

//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos CAMPObj,50 + random 200] call BIS_fnc_taskPatrol;
	CAMPunits = CAMPunits + (units _spawnGroup);
	
	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos CAMPObj,50 + random 200] call BIS_fnc_taskPatrol;
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);
	
	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 2) + 2);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSentry")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos CAMPObj,50 + random 200] call BIS_fnc_taskPatrol;
	CAMPunits = CAMPunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;	
	_spawnGroup_squad setBehaviour "COMBAT";	
	CAMPunits_squad = CAMPunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

private _enemiesArray = [objNull];

	
	
	//=====defining vehicles=========
	_Randomvehicle = ["I_E_Heli_light_03_dynamicLoadout_F","I_E_APC_tracked_03_cannon_F","I_E_UGV_01_rcws_F","I_G_Offroad_01_armed_F","I_G_Offroad_01_AT_F"];	

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
	
	 _infunits= ["I_E_soldier_Mine_F","I_E_Soldier_MP_F","I_E_RadioOperator_F","I_E_Soldier_A_F","I_E_Soldier_AA_F","I_E_Soldier_AAA_F","I_E_Soldier_AAR_F","I_E_Soldier_AAT_F","I_E_Soldier_AR_F","I_E_Soldier_AT_F","I_E_Soldier_CBRN_F","I_E_Soldier_Exp_F","I_E_Soldier_F","I_E_Soldier_GL_F","I_E_Soldier_LAT_F","I_E_Soldier_LAT2_F","I_E_Soldier_lite_F","I_E_soldier_M_F","I_E_Soldier_Repair_F","I_E_Soldier_SL_F","I_E_Soldier_TL_F"];
	
	
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
	private _Randomstatic = ["I_static_AA_F","I_static_AT_F","I_HMG_01_high_F"];
	
	for "_i" from 0 to (2 + (random 2)) do {
		_randomPos = [_fuzzyPos,random 10,40, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
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
		deleteMarker "marqueur_attaque_aaf";
	};	
};