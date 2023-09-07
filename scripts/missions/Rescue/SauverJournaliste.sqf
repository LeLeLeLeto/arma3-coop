
#define OBJUNIT_TYPES_INTEL "B_Survivor_F"


private _spawnedUnits = [];
private _groupsArray = [];  

private _unittypes = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F","I_C_Soldier_Bandit_2_F"];


private ["_flatPos","_accepted","_position","_journaliste","_OtagePos","_surrenderGroup"];

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

	rescueObj3 = "Land_BagBunker_Large_F" createVehicle _flatPos;
	_spawnedUnits = _spawnedUnits + [rescueObj3];
	rescueObj3 setDir 0;
	rescueObj3 setVectorUp surfaceNormal position rescueObj3;
	rescueObj3 allowDamage false;
	_rescueObj3Pos = getPos rescueObj3;
	_rescueObj3PosX = _rescueObj3Pos select 0;
	_rescueObj3PosY = _rescueObj3Pos select 1;
	
	//-------------------- SPAWN Journaliste

	_surrenderGroup = createGroup civilian;
	[OBJUNIT_TYPES_INTEL] call BIS_fnc_selectRandom createUnit [_flatPos, _surrenderGroup];
	
	//--------- Journaliste Stuff

	sleep 0.3;
	
	_journaliste = ((units _surrenderGroup) select 0);
	removeAllWeapons _journaliste;
	removeAllItems _journaliste;
	removeAllAssignedItems _journaliste;
	removeUniform _journaliste;
	removeVest _journaliste;
	removeBackpack _journaliste;
	removeHeadgear _journaliste;
	removeGoggles _journaliste;
	_journaliste forceAddUniform "U_C_Journalist";
	_journaliste addHeadgear "H_Cap_press";
	
//--------------------------------------------------------------------------- Add action to Journaliste.
	
	sleep 0.1;
	[_journaliste,"MF_fnc_addActionRescueJournaliste",nil,true] spawn BIS_fnc_MP; 

//create Hostile forces:
private ["_hostageTaker1","_sid_hostageTaker2eObjPosX","_hostageTaker3","_hostageTaker4","_hostageTaker5","_hostageTaker6","_hostageTaker7","_hostageTaker8","_hostageTaker9","_hostageTaker10"];	
private _hostageTakerGroup = createGroup resistance;

_hostageTaker1 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY + 3.5], [], 0, "CAN_COLLIDE"];
_hostageTaker1 doWatch getPos _journaliste;
_hostageTaker2 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY + 1], [], 0, "CAN_COLLIDE"];
_hostageTaker2 doWatch getPos _journaliste;
_hostageTaker3 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY - 1], [], 0, "CAN_COLLIDE"];
_hostageTaker3 doWatch getPos _journaliste;
_hostageTaker4 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX + 2.4 , _rescueObj3PosY - 3], [], 0, "CAN_COLLIDE"];
_hostageTaker4 doWatch getPos _journaliste;
_hostageTaker5 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX , _rescueObj3PosY + 6], [], 0, "CAN_COLLIDE"];
_hostageTaker5 setDir 0;
_hostageTaker6 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX , _rescueObj3PosY - 6], [], 0, "CAN_COLLIDE"];
_hostageTaker6 setDir 90;
_hostageTaker7 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY + 4], [], 0, "CAN_COLLIDE"];
_hostageTaker7 doWatch getPos _journaliste;
_hostageTaker8 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY + 1], [], 0, "CAN_COLLIDE"];
_hostageTaker8 doWatch getPos _journaliste;
_hostageTaker9 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY - 1], [], 0, "CAN_COLLIDE"];
_hostageTaker9 doWatch getPos _journaliste;
_hostageTaker10 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_rescueObj3PosX - 2.4 , _rescueObj3PosY - 3], [], 0, "CAN_COLLIDE"];
_hostageTaker10 doWatch getPos _journaliste;

{	_x disableAI "PATH";
	_spawnedUnits = _spawnedUnits + [_x];
} forEach (units _hostageTakerGroup);
_groupsArray = _groupsArray + [_hostageTakerGroup];
_hostageTakerGroup setGroupIdGlobal [format ['rescue-HostageTakers']];

{_x addCuratorEditableObjects [units _journaliste + units _hostageTakerGroup, false];} foreach allCurators;	
	
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

//----------------task/circle/....
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["rescuemarker", "rescuecircle"];
rescuemarkertext = "Sauvez le journaliste";
"rescuemarker" setMarkerText "Sauvez le journaliste";
[west,["SauverJournaliste"],[
"Des forces rebelles ont pris en otage un journaliste non loin de cette zone! Les négociations n'ont pas abouties. Sauvez le journaliste avant qu'il ne soit exécuté..."
,"Sauvez le journaliste","rescuecircle"],(getMarkerPos "rescuecircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

	rescueMissionSpawnComplete = true;
	publicVariableServer "rescueMissionSpawnComplete";
	rescueMissionUp = true;

	waitUntil {sleep 5; !rescueMissionUp || ((alive _journaliste) && (_journaliste distance getMarkerPos "respawn_west" < 50)) || !alive _journaliste };

	if (!alive _journaliste || !rescueMissionUp ) then {
		//mission failed
		["SauverJournaliste", "Failed",true] call BIS_fnc_taskSetState;
		
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

	if ((alive _journaliste) && (_journaliste distance getMarkerPos "respawn_west" < 50)) then {
		//mission success
		 ["SauverJournaliste", "Succeeded",true] call BIS_fnc_taskSetState;
 
		 
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
	["SauverJournaliste",west] call bis_fnc_deleteTask;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["rescuemarker", "rescuecircle"];
	sleep 120;
	{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;
	{ deleteVehicle _x } forEach [_journaliste];