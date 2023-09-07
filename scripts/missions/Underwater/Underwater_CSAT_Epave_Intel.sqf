/*
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_unitsArray","_nposition","_spawnGroup","_Target","_Building","_randomPos","_randomPosBuilding","_aliveInZone"];

UnderwaterUWunits = [];
UnderwaterUWunits_veh = [];
UnderwaterUWunits_squad = [];
_buildingToDelete = [];


//-------------------- FIND POSITION FOR OBJECTIVE

_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_position = [[[] call BIS_fnc_worldArea],[]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [2,0,0.3,1,2,true];
	while {(count _flatPos) < 2} do {
		_position = [[[] call BIS_fnc_worldArea],[]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [2,0,0.3,1,2,true];
	};
	if ((_flatPos distance (getMarkerPos "respawn_west")) > 700) then {
		_accepted = true;
	};
};


// Spawn Objective Epave ---------------------------------

_Target = [
"Land_Wreck_Plane_Transport_01_F",
"Land_UWreck_MV22_F",
"Land_UWreck_FishingBoat_F"
];


_Building = _Target call BIS_fnc_selectRandom;
_randomPosBuilding = [[[_flatPos, 100],[]],[]] call BIS_fnc_randomPos;
if !(_randomPosBuilding isEqualTo [0,0,0]) then {
	waterObjBuilding = _Building createVehicle _randomPosBuilding;
} else {
	_accepted = false;
	while {!_accepted} do {
		_randomPosBuilding = [[[_flatPos, 100],[]],[]] call BIS_fnc_randomPos;
		if !(_randomPosBuilding isEqualTo [0,0,0]) then {
			waterObjBuilding = _Building createVehicle _randomPosBuilding;
			_accepted = true;
		};
	};
};




	//setup for deletion
	

	waterObjBuilding enableSimulationGlobal true;
	waterObjBuilding enableSimulation true;
	_buildingToDelete pushBack waterObjBuilding;



//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["UnderwaterMarker", "UnderwaterCircle"];
	UnderwaterMarkerText = "Sécuriser la zone de l'épave"; publicVariable "UnderwaterMarkerText";
	"UnderwaterMarker" setMarkerText "Sécuriser la zone de l'épave"; publicVariable "UnderwaterMarker";
	publicVariable "UnderwaterObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Sécuriser la zone de l'épave</t><br/>____________________<br/>Un aéronef s'est écrasé dans cette zone.<br/>Partez à sa recherche et sécurisez la zone...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Sécuriser la zone de l'épave"]; publicVariable "showNotification";
	UnderwaterMarkerText = "Sécuriser la zone de l'épave"; publicVariable "UnderwaterMarkerText";
	[west,["Underwaterintel"],["Un aéronef s'est écrasé dans cette zone.<br/>Partez à sa recherche et sécurisez la zone......", "Sécuriser la zone de l'épave", "Sécuriser la zone de l'épave","UnderwaterMarker"],(getMarkerPos "UnderwaterMarker"),"Created",0,true,"intel",true] call BIS_fnc_taskCreate; 


	
	
//-------------------- SPAWN FORCE PROTECTION


_infteamPatrol = createGroup east;

for "_x" from 0 to (3 + (random 4)) do {
	_randomPos = [[[_flatPos, 5],[]],[]] call BIS_fnc_randomPos;
	if !(_randomPos isEqualTo [0,0,0]) then {
		_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
			UnderwaterUWunits = UnderwaterUWunits + (units _infteamPatrol);
			sleep 1;
			{_x addCuratorEditableObjects [units _infteamPatrol, false];} forEach allCurators;
	
	} else {
		_accepted = false;
		while {!_accepted} do {
			_randomPos = [[[_flatPos, 5],[]],[]] call BIS_fnc_randomPos;
			if !(_randomPos isEqualTo [0,0,0]) then {
				_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
					UnderwaterUWunits = UnderwaterUWunits + (units _infteamPatrol);
					sleep 1;
					{_x addCuratorEditableObjects [units _infteamPatrol, false];} forEach allCurators;
				_accepted = true;
			};
		};
	};

	for "_x" from 0 to (4 + (random 4)) do {
		_pos = [0,0,0];

		_randomPos = [[[_randomPosBuilding, 100],[]],[]] call BIS_fnc_randomPos;
		if !(_randomPos isEqualTo [0,0,0]) then {
			hpad = "Land_HelipadEmpty_F" createVehicle _randomPos;
		} else {
			_accepted = false;
			while {!_accepted} do {
				_randomPos = [[[_randomPosBuilding, 100],[]],[]] call BIS_fnc_randomPos;
				if !(_randomPos isEqualTo [0,0,0]) then {
					hpad = "Land_HelipadEmpty_F" createVehicle _randomPos;
					_accepted = true;
				};
			};
		};
		_hpadPos = getPos hpad;
		_maxDepth = _hpadPos select 2;
		_xCord = _hpadPos select 0;
		_yCord = _hpadPos select 1;
		_depth = 0 + (random _maxDepth);
		_uWp = _infteamPatrol addWaypoint [[_xCord,_yCord,_depth],0];
		_uWp setWaypointType "MOVE";
		_uWp setWaypointCompletionRadius 5;

		deleteVehicle hpad;
	};
	_wp = _infteamPatrol addwaypoint [_randomPos,0];
	_wp setWaypointType "CYCLE";

};

// Unités sur l'épave

_infteamPatrol = createGroup east;

for "_x" from 0 to (1 + (random 2)) do {
	_randomPos = [[[_flatPos, 5],[]],[]] call BIS_fnc_randomPos;
	if !(_randomPos isEqualTo [0,0,0]) then {
				_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
			UnderwaterUWunits = UnderwaterUWunits + (units _infteamPatrol);
			sleep 1;
			{_x addCuratorEditableObjects [units _infteamPatrol, false];} forEach allCurators;
	
	} else {
		_accepted = false;
		while {!_accepted} do {
			_randomPos = [[[_flatPos, 5],[]],[]] call BIS_fnc_randomPos;
			if !(_randomPos isEqualTo [0,0,0]) then {
				_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
					UnderwaterUWunits = UnderwaterUWunits + (units _infteamPatrol);
					sleep 1;
					{_x addCuratorEditableObjects [units _infteamPatrol, false];} forEach allCurators;
				_accepted = true;
			};
		};
	};

	for "_x" from 0 to (4 + (random 4)) do {
		_pos = [0,0,0];

		_randomPos = [[[_randomPosBuilding, 30],[]],[]] call BIS_fnc_randomPos;
		if !(_randomPos isEqualTo [0,0,0]) then {
			hpad = "Land_HelipadEmpty_F" createVehicle _randomPos;
		} else {
			_accepted = false;
			while {!_accepted} do {
				_randomPos = [[[_randomPosBuilding, 30],[]],[]] call BIS_fnc_randomPos;
				if !(_randomPos isEqualTo [0,0,0]) then {
					hpad = "Land_HelipadEmpty_F" createVehicle _randomPos;
					_accepted = true;
				};
			};
		};
		_hpadPos = getPos hpad;
		_maxDepth = _hpadPos select 2;
		_xCord = _hpadPos select 0;
		_yCord = _hpadPos select 1;
		_depth = 0 + (random _maxDepth);
		_uWp = _infteamPatrol addWaypoint [[_xCord,_yCord,_depth],0];
		_uWp setWaypointType "MOVE";
		_uWp setWaypointCompletionRadius 5;

		deleteVehicle hpad;
	};
	_wp = _infteamPatrol addwaypoint [_randomPos,0];
	_wp setWaypointType "CYCLE";

};

//=====Spawn vehicles=========

private _enemiesArray = [objNull];

for "_x" from 0 to (random 3) do {
	_randomPos = [[[_flatPos, 300],[]],[]] call BIS_fnc_randomPos;
	if !(_randomPos isEqualTo [0,0,0]) then {
		_boat = "O_Boat_Armed_01_hmg_F" createVehicle (_randomPos);
		_boat setDir (random 360);
		[_boat,_infteamPatrol] call BIS_fnc_spawnCrew;
		{_x addCuratorEditableObjects [[_boat] + units _infteamPatrol, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _infteamPatrol) + [_boat];
		UnderwaterUWunits_veh = UnderwaterUWunits_veh + (units _infteamPatrol);
	} else {
		_accepted = false;
		while {!_accepted} do {
			_randomPos = [[[_flatPos, 300],[]],[]] call BIS_fnc_randomPos;
			if !(_randomPos isEqualTo [0,0,0]) then {
				_boat = "O_Boat_Armed_01_hmg_F" createVehicle (_randomPos);
				_boat setDir (random 360);
				[_boat,_infteamPatrol] call BIS_fnc_spawnCrew;
				{_x addCuratorEditableObjects [[_boat] + units _infteamPatrol, false];} foreach allCurators;
				_enemiesArray = _enemiesArray + (units _infteamPatrol) + [_boat];
				UnderwaterUWunits_veh = UnderwaterUWunits_veh + (units _infteamPatrol);
				_accepted = true;
			};
		};
	};

};

		
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	UnderwaterMissionUp = true; publicVariable "UnderwaterMissionUp";
	Underwater_SUCCESS = false; publicVariable "Underwater_SUCCESS";

//--------------------------------------------- TRIGGER TO COUNT UNITS ALIVE
	
	_trg = createTrigger ["EmptyDetector", (getMarkerPos "UnderwaterMarker")];
	_trg setTriggerArea [250, 250, 0, false];
	_trg setTriggerActivation [EAST, "PRESENT", true];
	_trg setTriggerStatements ["this", "hint 'Civilian near player'", "hint 'no civilian near'"];
	
	
while { UnderwaterMissionUp } do {
	
	//--------------------------------------------- COUNT UNITS ALIVE
	
	_aliveInZone = {[_trg,_x] call bis_fnc_inTrigger && side _x == EAST  && alive _x} count AllUnits;  	
	
	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]
	 if (_aliveInZone < 5) then {

		//-------------------- DE-BRIEFING
		
		sleep 5;
		UnderwaterMissionUp = false; publicVariable "UnderwaterMissionUp";
		Underwater_SUCCESS = true;
		_CompleteText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Zone sécurisée! Bravo!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _CompleteText; publicVariable "GlobalHint"; hint parseText _CompleteText;
		showNotification = ["CompletedMission", UnderwaterMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["UnderwaterMarker", "UnderwaterCircle"]; publicVariable "UnderwaterMarker";
		_null = ["Underwaterintel", "SUCCEEDED"] spawn BIS_fnc_taskSetState;

		sleep 5;
		["Underwaterintel"] call BIS_fnc_deleteTask; 
		
			
		
		//--------------------- DELETE
		
		sleep 30;

		{deletevehicle _x} foreach UnderwaterUWunits;
		{deletevehicle _x} foreach UnderwaterUWunits_veh;
		{deletevehicle _x} foreach UnderwaterUWunits_squad;
		UnderwaterUWunits = [];
		UnderwaterUWunits_veh = [];
		UnderwaterUWunits_squad = [];
		{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;	
		{ deleteVehicle _x } forEach _buildingToDelete;


	};
	
};