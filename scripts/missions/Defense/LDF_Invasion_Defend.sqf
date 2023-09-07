/*
Author:

	Yanou
	
Last modified:

	30/12/2019
	
Description:

	Défense d'DEFENSE

____________________________________*/

private ["_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_aliveInZone","_mpos","_sizeM","_centerX","_centerY"];
DEFENSEunits = [];
DEFENSEunits_veh = [];
DEFENSEunits_squad = [];



//==================== PREPARE MISSION =======================
_mpos = getMarkerPos "INVASIONCircle";
_sizeM = getMarkerSize "INVASIONCircle"; 
_size = (_sizeM select 0); 
_centerX = _mpos select 0;
_centerY = _mpos select 1;
_enemiesArray = [grpNull];
_x = 0;

//----Spawn obj
private _objective = selectRandom ["Land_HelipadEmpty_F"];
DEFENSEObj = createVehicle [_objective, _mpos, [], 0, "CAN_COLLIDE"];



//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_mpos select 0) - 2) + (random 8),((_mpos select 1) - 2) + (random 8),0];
	
	{ _x setMarkerPos _fuzzyPos; } forEach ["DEFENSEMarker", "DEFENSECircle"];
	DEFENSEMarkerText = "Défendez la zone"; publicVariable "DEFENSEMarkerText";
	"DEFENSEMarker" setMarkerText "Défendez la zone"; publicVariable "DEFENSEMarker";
	publicVariable "DEFENSEObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Défendez la zone</t><br/>____________________<br/>Des renforts ennemis sont en approche.<br/>Défendez la zone à tout prix.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Défendez la zone"]; publicVariable "showNotification";
	DEFENSEMarkerText = "Défendez la zone"; publicVariable "DEFENSEMarkerText";

	[west,["DEFENDRELAZONE"],["Des renforts ennemis sont en approche.<br/>Défendez la zone à tout prix.", "Défendez la zone", "Défendez la zone","DEFENSEMarker"],(getMarkerPos "DEFENSEMarker"),"Created",0,true,"attack",true] call BIS_fnc_taskCreate;

//-------------------- SPAWN HELIDROP
		
		["DEFENSECircle",4,true,false,2000, "random", true, 150, 100, 10, 0.01, 75,false] execVM "scripts\HeliDrop.sqf";
		["DEFENSECircle",4,true,false,2000, "random", true, 125, 100, 10, 0.01, 75,false] execVM "scripts\HeliDrop.sqf";
		["DEFENSECircle",4,true,false,2000, "random", true, 100, 100, 10, 0.01, 75,false] execVM "scripts\HeliDrop.sqf";


	sleep 120;
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	DEFENSEMissionUp = true; publicVariable "DEFENSEMissionUp";
	DEFENSE_SUCCESS = false; publicVariable "DEFENSE_SUCCESS";

	//--------------------------------------------- TRIGGER TO COUNT UNITS ALIVE
	
	_trg = createTrigger ["EmptyDetector", (getMarkerPos "DEFENSEMarker")];
	_trg setTriggerArea [400, 400, 0, false];
	_trg setTriggerActivation [Independent, "PRESENT", true];
	_trg setTriggerStatements ["this", "hint 'Civilian near player'", "hint 'no civilian near'"];
	
while { DEFENSEMissionUp } do {
	//--------------------------------------------- COUNT UNITS ALIVE
	
	_aliveInZone = {[_trg,_x] call bis_fnc_inTrigger && side _x == Independent  && alive _x} count AllUnits;  	  

	//--------------------------------------------- NO UNITS OK
	
	if (_aliveInZone < 5) then
	{

		//-------------------- DE-BRIEFING
		sleep 10;
		DEFENSEMissionUp = false; publicVariable "DEFENSEMissionUp";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", DEFENSEMarkerText]; publicVariable "showNotification";
		_null = ["DEFENDRELAZONE", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 3;
		{{deleteVehicle _x} forEach units _x; deleteGroup _x} forEach(allGroups select {side _x == Independent and {leader _x distance getMarkerPos "DEFENSEMarker" < 500}});
		sleep 3;
		["DEFENDRELAZONE"] call BIS_fnc_deleteTask; 
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["DEFENSEMarker", "DEFENSECircle"]; publicVariable "DEFENSEMarker";

	};	
};