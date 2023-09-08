/**
	
 */

delai = 60 + (random 60);

liste = [
	"exemple_mission.sqf"
	//"SPET_AA",
	//"SPET_Artillerie",
	//"SPET_Coms"
	//"LDF_Detruire_tour_com",
	//"FIA_Armement"
	//"CSAT_NeutraliserOfficier"
];

while { true } do {
	// Lancement mission aléatoire dans la liste
	mission = execVM format ["scripts\missions\destruction\%1.sqf", selectRandom liste];

	waitUntil {
		// On attend que la mission se finisse
		scriptDone mission
	};
 
	// On attend un délai et tout recommence
	sleep delai;
};