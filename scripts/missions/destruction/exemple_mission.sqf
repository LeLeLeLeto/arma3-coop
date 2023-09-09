/**
	Exemple de mission de destruction
	Fait apparaitre un AA à détruire et des patrouilles CSAT
 */

// Stockage des unités apparues
groupes = [];

// Position de la mission
_position = call MFW_fn_findMissionPosition;

// Briefing / Marqueurs
[
	"Mission exemple", // Titre
	"Mission exemple", // Description
	"Destroy_And_EliminateMarker", // Type
	"mission_exemple", // ID
	_position,
	"ColorRed"
] call MFW_fn_createMissionMarker;

// ----- Composition
_composition = [
	"mission_destruction_spetsnaz_artillerie", // Nom composition (composition.cfg)
	_position
] call LARs_fnc_spawnComp;

// Objectif à détruire
// Bien noter le nom de variable des objectifs !
// (Ca veut dire que 2 mêmes mission ne peuvent pas être activées en même temps... pas grave)
// IMPORTANT : Il faut gérer les objectifs après la composition. Sinon ils ne sont pas encore chargés
objectifs = [
	missionNamespace getVariable "objectif_destruction_spetsnaz_artillerie_1",
	missionNamespace getVariable "objectif_destruction_spetsnaz_artillerie_2"
];

// ----- Unités de défense
nombre_groupes = 6 + round(random(3));
liste_groupes = [
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")
];

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
];

liste_unites = [
	"O_R_Soldier_TL_F",
	"O_R_Soldier_AR_F",
	"O_R_soldier_exp_F",
	"O_R_Soldier_GL_F",
	"O_R_Soldier_LAT_F",
	"O_R_soldier_M_F",
	"O_R_Patrol_Soldier_M_F",
	"O_R_Patrol_Soldier_Medic",
	"O_R_Patrol_Soldier_Engineer_F"];

groupes append ([liste_groupes, nombre_groupes, _position] call MFW_fn_spawnGroups);
groupes append ([liste_vehicules, nombre_vehicules, _position] call MFW_fn_spawnVehicles);
groupes append ([liste_unites, _position, east] call MFW_fn_spawnUnitsInBuildings);

// Attente fin d'objectif
while { alive (objectifs select 0) || alive (objectifs select 1) } do {sleep 10; };

// Succès
["mission_exemple", "SUCCEEDED"] spawn BIS_fnc_taskSetState;

// Nettoyage
sleep 10;

{
	_y = _x; // _y : Groupe
	{
		deleteVehicle _x;
	} forEach units _y;
} forEach groupes;

// Suppression de la composition est des unités
[ _composition ] call LARs_fnc_deleteComp;
["mission_exemple"] call BIS_fnc_deleteTask;
deleteMarker "mission_exemple";
diag_log "Mission terminée";