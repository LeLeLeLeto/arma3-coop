/*
Author: 

	Yanoukovytsch

Last modified: 

	5 Novembre 2022 by [MF] Ricky

Description:

	Controle des missions rescue

To do:

	
______________________________________________*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

_delay = 240 + (random 60);
_loopTimeout = 10 + (random 10);


_missionList = [	
	
	"policeProtection",
	"PilotRescue",
	"FreeCivs",
	"SauverJournaliste",
	"AAF_EnleverOfficier",
	"CSAT_EnleverOfficier"

];

Rescue_SWITCH = true; publicVariable "Rescue_SWITCH";
	
while { true } do {

	if (Rescue_SWITCH) then {
	
		sleep 3;
	
		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["mission\Rescue\%1.sqf", _mission];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};
	
		sleep _delay;
		
		Rescue_SWITCH = true; publicVariable "Rescue_SWITCH";
	};
	sleep _loopTimeout;
};


	
