/**
	
 */
_simultanees = 4;
_nombre_en_cours = 0;

missions_disponibles = [
	"scripts\missions\mission_destruction_spetsnaz_aa.sqf",
	"scripts\missions\mission_destruction_spetsnaz_artillerie.sqf",
	"scripts\missions\mission_destruction_spetsnaz_com.sqf",
	"scripts\missions\mission_destruction_spetsnaz_officier.sqf",
	"scripts\missions\mission_destruction_fia_armement.sqf",
	"scripts\missions\mission_destruction_fia_com.sqf"
];
missions_en_cours = [];
positions_blacklist = [
	[[14000, 16000], 2000] // Base principale
	// TODO autres bases
];

publicVariableServer "missions_disponibles";
publicVariableServer "missions_en_cours";
publicVariableServer "positions_blacklist";

for "_n" from 0 to _simultanees - 1 do {
	0 spawn {
		while { true } do {
			// Choix de la mission
			_mission = selectRandom missions_disponibles;
			missions_disponibles = missions_disponibles - [_mission];
			missions_en_cours pushBack _mission;

			// Position de la mission
			_mission_position = call MFW_fn_findMissionPosition;
			positions_blacklist pushBack [_mission_position, 2000];

			// Exécution de la mission
			_handle = [_mission_position] execVM _mission;

			// On attend qu'elle finisse
			waitUntil { scriptDone _handle; };

			// On la remet dans la liste des missions disponibles
			missions_disponibles pushBack _mission;
			missions_en_cours = missions_en_cours - [_mission];

			// On enlève la position de la blacklist
			positions_blacklist = positions_blacklist - [_mission_position, 2000];

			// Prochaine mission après le délai
			sleep 60;
		};
	};
	sleep 30;
};