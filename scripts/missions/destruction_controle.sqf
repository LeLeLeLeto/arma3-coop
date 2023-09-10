/**
	
 */
_simultanees = 5;
_nombre_en_cours = 0;

missions_disponibles = [
	"scripts\missions\destruction\mission_destruction_spetsnaz_aa.sqf",
	"scripts\missions\destruction\mission_destruction_spetsnaz_artillerie.sqf",
	"scripts\missions\destruction\mission_destruction_spetsnaz_com.sqf",
	"scripts\missions\destruction\mission_destruction_spetsnaz_officier.sqf",
	"scripts\missions\destruction\mission_destruction_fia_armement.sqf"
];
missions_en_cours = [];

publicVariableServer "missions_disponibles";
publicVariableServer "missions_en_cours";

for "_n" from 0 to _simultanees - 1 do {
	0 spawn {
		while { true } do {
			// Choix de la mission
			_mission = selectRandom missions_disponibles;
			missions_disponibles = missions_disponibles - [_mission];
			missions_en_cours pushBack _mission;

			// Exécution de la mission
			_handle = execVM _mission;

			// On attend qu'elle finisse
			waitUntil { scriptDone _handle; };

			// On la remet dans la liste des missions disponibles
			missions_disponibles pushBack _mission;
			missions_en_cours = missions_en_cours - [_mission];

			// Prochaine mission après le délai
			sleep 60;
		};
	};
	sleep 10;
};