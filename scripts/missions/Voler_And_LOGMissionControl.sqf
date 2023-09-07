/*
Author: 

	Yanoukovytsch

Last modified: 

	10 Novembre 2022 by [MF] Ricky

Description:

	Controle des missions voler & LOG

*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

_delay = 240 + (random 60);
_loopTimeout = 10 + (random 10);


_missionList = [	

	"SYN_vol_vehicule_rare",
	"CSAT_vol_vehicule_rare",
	"SPET_vol_vehicule_rare",
	"AAF_vol_vehicule_rare",
	"OTAN_vol_vehicule_rare",
	"SPET_PROTO",
	"AAF_PROTO",
	"OTAN_PROTO",
	"LOGlivrermedicaments",
	"LOGlivreressence",
	"LOGlivrertechnologie"

];

Voler_And_LOG_SWITCH = true; publicVariable "Voler_And_LOG_SWITCH";
	
while { true } do {

	if (Voler_And_LOG_SWITCH) then {
	
		sleep 3;
	
		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["mission\Voler_And_LOG\%1.sqf", _mission];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};
	
		sleep _delay;
		
		Voler_And_LOG_SWITCH = true; publicVariable "Voler_And_LOG_SWITCH";
	};
	sleep _loopTimeout;
};


	
