private ["_mission","_missionList","_currentMission","_delay"];

_delay = 60 + (random 60);

_missionList = [
	"SPET_AA",
	"SPET_Artillerie",
	"SPET_Coms"
	//"LDF_Detruire_tour_com",
	//"FIA_Armement"
	//"CSAT_NeutraliserOfficier"
];
	
while { true } do {
	// Choix de la mission
	_mission = selectRandom _missionList;

	// Choix du fichier correspondant
	_currentMission = execVM format ["scripts\missions\attaque_destruction\%1.sqf", _mission];

	waitUntil {
		// On attend que la mission se finisse
		scriptDone _currentMission
	};

	// On attend un délai et tout recommence
	sleep _delay;
};