/*
Author:

	Quiksilver
	
Last modified:

	28 Novembre By [MF] Ricky
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_enemiesArray","_x","_briefing","_completeText","_aliveInZone"];
BARRAGEunits = [];
BARRAGEunits_veh = [];
BARRAGEunits_squad = [];
private _spawnedUnits = [];
private _groupsArray = [];


//==================== PREPARE MISSION =======================


private "_pos";
private "_nearRoad";
    _pos = [getMarkerPos "Voler_And_LOGCircle", 500, 500, 10, 0, 10, 0]  call BIS_fnc_findSafePos;
    _nearRoad = [_pos, 500] call BIS_fnc_nearestRoad;


//----Spawn obj
private _objective = selectRandom ["Land_Barricade_01_10m_F"];
BARRAGEObj = createVehicle [_objective, _nearRoad, [], 0, "CAN_COLLIDE"];
BARRAGEBidonObj = createVehicle ["MetalBarrel_burning_F", _nearRoad modelToWorld [0,2,0], [], 0, "CAN_COLLIDE"];
BARRAGEBidon2Obj = createVehicle ["MetalBarrel_burning_F", _nearRoad modelToWorld [0,-2,0], [], 0, "CAN_COLLIDE"];



//-------------------- SPAWN FORCE PROTECTION


_random = (round(random 0) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_nearRoad,5,5, 5, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "BanditShockTeam")] call BIS_fnc_spawnGroup;	
	_spawnGroup_squad setBehaviour "safe";	
	BARRAGEunits_squad = BARRAGEunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


private _enemiesArray = [objNull];


	
	//=====defining vehicles=========
	_Randomvehicle = ["I_C_Offroad_02_LMG_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (1 + (random 1)) do {
		private _randomPos = [_nearRoad, 10, 10, 10, 0, 0.3, 0, [], (getPos BARRAGEObj)] call BIS_fnc_findSafePos;
		private _Vehiclegroup1 = createGroup Independent;
		private _vehicletype = selectRandom _Randomvehicle;
		private _vehicle1 = _vehicletype createVehicle _randomPos;
		createvehiclecrew _vehicle1;
		(crew _vehicle1) join _Vehiclegroup1;
		_vehpatrolgroupamount = _vehpatrolgroupamount + 1;
		_Vehiclegroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _vehpatrolgroupamount]];
		_vehicle1 lock 3;
		{_x addCuratorEditableObjects [[_vehicle1] + units _Vehiclegroup1, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _Vehiclegroup1) + [_vehicle1];
		BARRAGEunits_veh = BARRAGEunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	//=====defining vehicles=========
_Randomvehicle = ["I_static_AA_F","I_static_AT_F","I_HMG_01_high_F"];

//vehicles
private _RandomVicAmount = 0;
for "_x" from 1 to 3 do {
	private _randomPos = [_nearRoad, 15, 15, 15, 0, 0.3, 0, [], (getPos BARRAGEObj)] call BIS_fnc_findSafePos;
	private _grp1 = createGroup resistance;
	_RandomVicAmount = _RandomVicAmount + 1;
	_grp1 setGroupIdGlobal [format ['rescue-RandVic-%1', _RandomVicAmount]];
	private _vehicletype = selectRandom _Randomvehicle;
	private _vehc =  _vehicletype createVehicle _randompos;
	_vehc allowCrewInImmobile true;
	_vehc lock 2;

	private _grpMember = _grp1 createUnit ["I_C_Soldier_Bandit_8_F", _nearRoad, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (random 360);

	_groupsArray = _groupsArray + [_grp1];
	_spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];
	{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} forEach allCurators;
};
	
	sleep 0.1;
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	BARRAGEMissionUp = true; publicVariable "BARRAGEMissionUp";
	BARRAGE_SUCCESS = false; publicVariable "BARRAGE_SUCCESS";

	//--------------------------------------------- TRIGGER TO COUNT UNITS ALIVE
	
	_trg = createTrigger ["EmptyDetector", (getMarkerPos "Voler_And_LOGCircle")];
	_trg setTriggerArea [300, 300, 0, false];
	_trg setTriggerActivation [Independent, "PRESENT", true];
	_trg setTriggerStatements ["this", "hint 'Civilian near player'", "hint 'no civilian near'"];
	
while { BARRAGEMissionUp } do {
	//--------------------------------------------- COUNT UNITS ALIVE
	
	_aliveInZone = {[_trg,_x] call bis_fnc_inTrigger && side _x == Independent  && alive _x} count AllUnits;  	  

	//--------------------------------------------- NO UNITS OK
	
	if (_aliveInZone < 1) then
	{
		//-------------------- DE-BRIEFING
		sleep 10;
		BARRAGEMissionUp = false; publicVariable "BARRAGEMissionUp";

		//--------------------- DELETE
		
		sleep 20;

		{deletevehicle _x} foreach BARRAGEunits;
		{deletevehicle _x} foreach BARRAGEunits_veh;
		{deletevehicle _x} foreach BARRAGEunits_squad;
		BARRAGEunits = [];
		BARRAGEunits_veh = [];
		BARRAGEunits_squad = [];
		deleteVehicle BARRAGEObj;
		deleteVehicle BARRAGEBidonObj;
		deleteVehicle BARRAGEBidon2Obj;
		{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;	
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;
	};	
};