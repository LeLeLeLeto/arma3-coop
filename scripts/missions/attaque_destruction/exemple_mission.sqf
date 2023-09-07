/**
	Exemple de mission de destruction
	Fait apparaitre un AA à détruire et des patrouilles CSAT
 */

// Stockage des unités apparues
vehicules = [];
groupes = [];

// Position de la mission
position = [[10000, 20000, 130], 0, 20000, 1, 0, 0.2, 0, []] call BIS_fnc_findSafePos;

// Objectif à détruire
objectif_class = "O_T_APC_Tracked_02_AA_ghex_F";

// Type Véhicule
objectif = [position, 0, objectif_class, east] call BIS_fnc_spawnVehicle select 0;
objectif engineOn true;

// Type Batiment
// TODO

// Template base
// TODO

// Briefing / Marqueurs
// A terme utiliser des classes de tâches !
tache_texte = [
	"Une mission d'exemple.", // Description
	"Mission exemple", // Titre
	"Destroy_And_EliminateMarker" // Type de marqueur
];

[true, "destruction_exemple", tache_texte, position, "CREATED", 0, true] call BIS_fnc_taskCreate;

marqueur = createMarker ["destruction_exemple", position];
marqueur setMarkerType "selector_selectedMission";
marqueur setMarkerSize [2, 2];
marqueur setMarkerColor "ColorRed";

// ----- Unités de défense
// Groupes
nombre_groupes = 6 + round(random(3));

liste_groupes = [
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")
];

for "i" from 0 to nombre_groupes do {
	// Création du groupe
	groupe = [
		[position, 50, 200, -1, 0, 0.2] call BIS_fnc_findSafePos,
		east,
		selectRandom liste_groupes
	]  call BIS_fnc_spawnGroup;
	[groupe, position, 50 + random(250)] call BIS_fnc_taskPatrol;

	groupes pushBack groupe;
}

// Véhicules
nombre_vehicules = 1 + floor(random(3));

liste_vehicules = [
	"O_G_Offroad_01_armed_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"O_APC_Tracked_02_AA_F",
	"O_Heli_Attack_02_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_black_F",
	"O_Heli_Light_02_F",
	"O_Heli_Light_02_v2_F",
	"O_MBT_04_command_F",
	"O_MBT_04_cannon_F"
]

for "i" from 0 to nombre_vehicules do {
	vehicule = [
		[position, 50, 200, -1, 0, 0.2] call BIS_fnc_findSafePos,
		0,
		selectRandom liste_vehicules,
		east
	] call BIS_fnc_spawnVehicle;
	[vehicule, position, 100 + random(250)] call BIS_fnc_taskPatrol;

	vehicules pushBack vehicule;
}

// Unités dans les batiments
batiments = nearestObjects [position, ["house", "building"], 400];

if (count batiments > 0){
	batiment = selectRandom batiments;
	batiments = batiments - [batiment];

	
}