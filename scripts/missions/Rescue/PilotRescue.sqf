/*
Author: stanhope, AW-community member
bassed off of existing AW created side missions
Description: mission in which players have to find and heal a crashed helipilot before he dies.
Bleedouttimer starts running when player get's within 3.5km of the obj.

Last modified:  23/02/18 by stanhope
modified: tweaks for perf
*/


private _bleedOutTimer = 900; //time before the pilot dies
private _triggerRange = 3500; //if players get within this radius the bleedouttimer starts running
private _spawnedUnits = [];
private _groupsArray = []; 
private ["_flatPos","_accepted","_position"];


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


// Heli-wreck Creation -----------------------
	RESCUEObj = "Land_Wreck_Heli_Attack_01_F" createVehicle _flatPos;
	waitUntil {sleep 0.1; alive RESCUEObj};
	RESCUEObj setDir 88.370;
	RESCUEObj setVectorUp surfaceNormal position RESCUEObj;
	
//Pilot Creation -----------------------

private _pilot = "C_man_pilot_F" createVehicle [(getPos RESCUEObj select 0)+4, (getPos RESCUEObj select 1)-4, ((getPos RESCUEObj select 2))];
_pilot setVectorUp surfaceNormal position _pilot;
_pilot setDir 88.370;

removeAllWeapons _pilot;
removeAllItems _pilot;
removeAllAssignedItems _pilot;
removeUniform _pilot;
removeVest _pilot;
removeBackpack _pilot;
removeHeadgear _pilot;
removeGoggles _pilot;
_pilot forceAddUniform "U_B_HeliPilotCoveralls";
_pilot addVest "V_PlateCarrier1_blk";
_pilot addHeadgear "H_PilotHelmetHeli_B";
_pilot allowDamage false;
[_pilot, "Acts_LyingWounded_loop"] remoteExec ["switchMove", 0, true];

[_pilot,"Rescue pilot",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\heal_ca.paa",
"_target distance _this <= 4","_target distance _this <= 4",
{hint "Performing first aid ...";
private _unit = _this select 1;
if ( currentWeapon _unit != "" ) then
{	_unit action ["SwitchWeapon", _unit, _unit, 99]; };
_unit playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";

},{},{

    _name = name (_this select 1);
    _RESCUEcompleted = format["<t align='center'><t size='2.2'>Rescue Mission update</t><br/>____________________<br/>%1 a soigné le pilote!  Bravo!</t>",_name];
    [_RESCUEcompleted] remoteExec ["AW_fnc_globalHint",0,false];
    sleep 4;
    RESCUE_SUCCESS = true;
	publicVariableServer "RESCUE_SUCCESS";

},
{hint "You stopped performing first aid";
private _unit = _this select 1;
_unit playMoveNow "";
},[],10, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];




//Spawn force protection
private _unittypes = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"];
private _vehicletypes = ["I_G_Offroad_01_armed_F","I_static_AA_F","I_static_AA_F","I_static_AT_F","I_HMG_01_high_F","I_G_Offroad_01_armed_F"];

//infantry
private _MainInfAmount = 0;
for "_x" from 1 to 5 do {
	private _squadPos = [_flatPos, 5, 350, 2, 0, 20, 0] call BIS_fnc_findSafePos;
	private _infantryGroup = createGroup resistance;
	_MainInfAmount = _MainInfAmount + 1;
	_infantryGroup setGroupIdGlobal [format ['rescue-MainInf-%1', _MainInfAmount]];

	for "_x" from 1 to 8 do {
		private _unit = selectRandom _unittypes;
		private _grpMember = _infantryGroup createUnit [_unit, _squadPos, [], 0, "NONE"];
	};
	[_infantryGroup, _flatPos, 275] call BIS_fnc_taskPatrol;
	_spawnedUnits = _spawnedUnits + units _infantryGroup;
	_groupsArray = _groupsArray + [_infantryGroup];	
	{_x addCuratorEditableObjects [units _infantryGroup, false];} foreach allCurators;
};

//vehicles
private _RandomVicAmount = 0;
for "_x" from 1 to 5 do {
	private _randomPos = [_flatPos, 10, 250, 5, 0, 0.3, 0, [], _flatPos] call BIS_fnc_findSafePos;
	
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
		[_grp1, _flatPos, 275] call BIS_fnc_taskPatrol;
		_grp1 setSpeedMode "LIMITED";
	}else{
	private _grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _flatpos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (random 360);
	};

	_groupsArray = _groupsArray + [_grp1];
	_spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];
	{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} forEach allCurators;
};


	
// Briefing ------------------------------------------------
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["RESCUEMarker", "RESCUECircle"];
RESCUEMarkerText = "Rescue Mission";
"RESCUEMarker" setMarkerText "Sauver le pilote";
[west,["rescueTask"],[
"Appel de détresse d'un Blackfoot dans cette zone...<br>Retrouvez le pilote à tout prix!"
,"Sauver le pilote","RESCUECircle"],(getMarkerPos "RESCUECircle"),"Created",0,true,"heal",true] call BIS_fnc_taskCreate;

//mission core
RESCUEMissionUp = true;
RESCUE_SUCCESS = false;
sideMissionSpawnComplete3 = true;
publicVariableServer "sideMissionSpawnComplete3";

//First wait till there are enough players near
while {RESCUEMissionUp} do {	

	private _numPlayersnear = 0;
    {	if ((_x distance _flatPos) < _triggerRange) then {
            _numPlayersnear = _numPlayersnear + 1;
			sleep 0.1;
        };
    } forEach allPlayers;

	if (_numPlayersnear > 0) exitWith{};
    if (!alive _pilot) exitWith{};
	sleep 10;
};
sleep 1;

while {RESCUEMissionUp} do {

	if (RESCUE_SUCCESS) exitWith {

		//-------------------- DE-BRIEFING
		[] call AW_fnc_SMhintSUCCESS;
        ["rescueTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
		RESCUEMissionUp = false;
	};
	
	if ((_bleedOutTimer <= 0) || (!alive _pilot) || !RESCUEMissionUp) exitWith {
		//-------------------- DE-BRIEFING
        ["rescueTask", "Failed",true] call BIS_fnc_taskSetState;
		RESCUEMissionUp = false;
	};
	
	_bleedOutTimer = _bleedOutTimer -5;
    sleep 5;
};

deleteVehicle _pilot;
sleep 5;
["rescueTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["RESCUEMarker", "RESCUECircle"];

//-------------------- DELETE
sleep 120;
deleteVehicle RESCUEObj;
{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;