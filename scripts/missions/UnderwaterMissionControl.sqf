/*
Author: 

	Yanoukovytsch

Last modified: 

	5 Novembre 2022 by [MF] Ricky

Description:

	Controle des missions Underwater

*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

_delay = 900 + (random 60);
_loopTimeout = 10 + (random 10);


_missionList = [	

	//"Underwater_CSAT_Epave_Intel",
	//"Underwater_AAF_Epave_Intel",
	"CSAT_Attaquer_bateau"

];

Underwater_SWITCH = true; publicVariable "Underwater_SWITCH";
	
while { true } do {

	if (Underwater_SWITCH) then {
	
		sleep 3;
	
		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["mission\Underwater\%1.sqf", _mission];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};
	
		sleep _delay;
		
		Underwater_SWITCH = true; publicVariable "Underwater_SWITCH";
	};
	sleep _loopTimeout;
};


	
