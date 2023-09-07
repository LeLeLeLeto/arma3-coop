
#define OBJUNIT_TYPES_INTEL "C_man_p_fugitive_F_afro"

private _spawnedUnits = [];
private _groupsArray = []; 
RESCUEunits = [];
RESCUEunits_veh = [];
RESCUEunits_squad = []; 

private _officierTypes = ["C_man_p_fugitive_F_afro"];

private ["_enemiesArray","_flatPos","_accepted","_position","_officier","_OfficierPos","_surrenderGroup"];

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

	//Spawn Tente
	

	private ["_rescueObj3Pos","_rescueObj3PosX","_rescueObj3PosY"];

	rescueObj3 = "Land_Dome_Small_F" createVehicle _flatPos;
	_spawnedUnits = _spawnedUnits + [rescueObj3];
	rescueObj3 setDir 0;
	rescueObj3 setVectorUp surfaceNormal position rescueObj3;
	rescueObj3 allowDamage false;
	_rescueObj3Pos = getPos rescueObj3;
	_rescueObj3PosX = _rescueObj3Pos select 0;
	_rescueObj3PosY = _rescueObj3Pos select 1;
	
	//create officier

	private ["_officier"];
	private _officierGroup = createGroup Civilian;
	_officier = _officierGroup createUnit [(selectRandom _officierTypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY + 3], [], 0, "CAN_COLLIDE"];
	sleep 0.3;
	_officier = ((units _officierGroup) select 0);
	removeAllWeapons _officier;
	removeAllItems _officier;
	removeAllAssignedItems _officier;
	removeUniform _officier;
	removeVest _officier;
	removeBackpack _officier;
	removeHeadgear _officier;
	removeGoggles _officier;
	_officier forceAddUniform "U_I_OfficerUniform";
	_officier addHeadgear "H_Beret_ocamo";

	
	
//--------------------------------------------------------------------------- Add action to Journaliste.
	
	sleep 0.1;
	[_officier,"MF_fnc_addActionSurrenderOfficer",nil,true] spawn BIS_fnc_MP; 

private _unittypes = ["I_soldier_F","I_Soldier_lite_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_M_F","I_medic_F","I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F","I_Soldier_LAT_F","I_Soldier_LAT2_F","I_Soldier_TL_F","I_Soldier_AA_F"];


//create Hostile forces:
private ["_officierEscort1","_sid_officierEscort2eObjPosX","_officierEscort3","_officierEscort4","_officierEscort5","_officierEscort6","_officierEscort7","_officierEscort8","_officierEscort9","_officierEscort10"];	
private _officierEscortGroup = createGroup Independent;

_officierEscort1 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY + 3.5], [], 0, "CAN_COLLIDE"];
_officierEscort1 doWatch getPos _officier;
_officierEscort2 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY + 1], [], 0, "CAN_COLLIDE"];
_officierEscort2 doWatch getPos _officier;
_officierEscort3 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY - 1], [], 0, "CAN_COLLIDE"];
_officierEscort3 doWatch getPos _officier;
_officierEscort4 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY - 3], [], 0, "CAN_COLLIDE"];
_officierEscort4 doWatch getPos _officier;
_officierEscort5 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX , _rescueObj3PosY + 6], [], 0, "CAN_COLLIDE"];
_officierEscort5 setDir 0;
_officierEscort6 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX , _rescueObj3PosY - 6], [], 0, "CAN_COLLIDE"];
_officierEscort6 setDir 90;
_officierEscort7 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY + 4], [], 0, "CAN_COLLIDE"];
_officierEscort7 doWatch getPos _officier;
_officierEscort8 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY + 1], [], 0, "CAN_COLLIDE"];
_officierEscort8 doWatch getPos _officier;
_officierEscort9 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY - 1], [], 0, "CAN_COLLIDE"];
_officierEscort9 doWatch getPos _officier;
_officierEscort10 = _officierEscortGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY - 3], [], 0, "CAN_COLLIDE"];
_officierEscort10 doWatch getPos _officier;

{	_x disableAI "PATH";
	_spawnedUnits = _spawnedUnits + [_x];
} forEach (units _officierEscortGroup);
_groupsArray = _groupsArray + [_officierEscortGroup];
_officierEscortGroup setGroupIdGlobal [format ['rescue-officierEscorts']];

{_x addCuratorEditableObjects [units _officier + units _officierEscortGroup, false];} foreach allCurators;	
	
//----------------task/circle/....
private _fuzzyPos = [((_flatPos select 0) - 50) + (random 250),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["rescuemarker", "rescuecircle"];
rescuemarkertext = "Enlever l'Officier AAF";
"rescuemarker" setMarkerText "Enlever l'Officier AAF";
[west,["EnleverOfficier"],[
"Un Officier importants'est réfugié non loin de cette zone! Notre client souhaite obtenir des informations de cet Officier. Enlever l'Officier AAF et ramener-le à la base..."
,"Enlever l'Officier AAF","rescuecircle"],(getMarkerPos "rescuecircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AT")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos rescueObj3,50 + random 200] call BIS_fnc_taskPatrol;
	RESCUEunits = RESCUEunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos rescueObj3,50 + random 200] call BIS_fnc_taskPatrol;
	RESCUEunits_squad = RESCUEunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AA")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos rescueObj3,50 + random 200] call BIS_fnc_taskPatrol;
	RESCUEunits_squad = RESCUEunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;	
	_spawnGroup_squad setBehaviour "COMBAT";	
	RESCUEunits_squad = RESCUEunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

private _enemiesArray = [objNull];


	//=====defining vehicles=========
	_Randomvehicle = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MBT_03_cannon_F","I_LT_01_cannon_F","I_LT_01_AT_F","I_LT_01_AA_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_fuzzyPos, 10, 300, 5, 0, 0.3, 0, [], (getPos rescueObj3)] call BIS_fnc_findSafePos;
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
		RESCUEunits_veh = RESCUEunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;

_infunits = ["I_soldier_F","I_Soldier_lite_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_M_F","I_medic_F","I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F","I_Soldier_LAT_F","I_Soldier_LAT2_F","I_Soldier_TL_F","I_Soldier_AA_F"];

	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [rescueObj3, ["house","building"], 400];
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
			RESCUEunits_squad = RESCUEunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};





	rescueMissionSpawnComplete = true;
	publicVariableServer "rescueMissionSpawnComplete";
	rescueMissionUp = true;

	waitUntil {sleep 5; !rescueMissionUp || ((alive _officier) && (_officier distance getMarkerPos "respawn_west" < 50)) || !alive _officier };

	if (!alive _officier || !rescueMissionUp ) then {
		//mission failed
		["EnleverOfficier", "Failed",true] call BIS_fnc_taskSetState;
		
		//-------------------- DE-BRIEFING
		sleep 5;
		RESCUEMissionUp = false; publicVariable "RESCUEMissionUp";
		RESCUE_FAIL = true;
		_failedText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>ECHEC</t><br/>____________________<br/>Echec!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		showNotification = ["FailedMission", RESCUEMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["RESCUEMarker", "RESCUECircle"]; publicVariable "RESCUEMarker";
		_null = ["RESCUE", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["RESCUE"] call BIS_fnc_deleteTask; 
		
		//--------------------- DELETE
		
	};

	if ((alive _officier) && (_officier distance getMarkerPos "respawn_west" < 50)) then {
		//mission success
		 ["EnleverOfficier", "Succeeded",true] call BIS_fnc_taskSetState;
 
		 
		 		//-------------------- DE-BRIEFING
		sleep 5;
		RESCUEMissionUp = false; publicVariable "RESCUEMissionUp";
		RESCUE_SUCCESS = true;
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedMission", RESCUEMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["RESCUEMarker", "RESCUECircle"]; publicVariable "RESCUEMarker";
		_null = ["RESCUE", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["RESCUE"] call BIS_fnc_deleteTask; 
		
		//--------------------- DELETE
		
	};

	rescueMissionUp = false;
	sleep 5;
	["EnleverOfficier",west] call bis_fnc_deleteTask;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["rescuemarker", "rescuecircle"];
	sleep 120;
	{deleteVehicle _x} forEach [_officier];
	{deletevehicle _x} foreach RESCUEunits;
	{deletevehicle _x} foreach RESCUEunits_veh;
	{deletevehicle _x} foreach RESCUEunits_squad;
	RESCUEunits = [];
	RESCUEunits_veh = [];
	RESCUEunits_squad = [];
	deleteVehicle rescueObj3;
	{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;
	{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;
