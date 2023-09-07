/*
Author: 

	Yanoukovytsch

Last modified: 

	5 Novembre 2022 by [MF] Ricky

Description:

	Controle des missions d'Invasion

*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

_delay = 60 + (random 60);
_loopTimeout = 10 + (random 10);


_missionList = [	

	"CSAT_invasion",
	"AAF_invasion",
	"SPET_invasion",
	"LDF_invasion",
	"OTAN_invasion",
	"SYN_invasion"
	//"SYN_camp_milice",
	//"LDF_camp_milice",
	//"OTAN_camp_milice"

];

while { true } do {
	// Choix de la mission
	_mission = selectRandom _missionList;

	// Choix du fichier correspondant
	_currentMission = execVM format ["scripts\missions\attaque\%1.sqf", _mission];

	waitUntil {
		// On attend que la mission se finisse
		scriptDone _currentMission
	};

	// On attend un délai et tout recommence
	sleep _delay;
};