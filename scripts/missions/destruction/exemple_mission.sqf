/**
	Exemple de mission de destruction
	Fait apparaitre un AA à détruire et des patrouilles CSAT
 */

// Stockage des unités apparues
vehicules = [];
groupes = [];

MFW_fn_findMissionPosition = compile preprocessFile "scripts\MissionFramework\fn_findMissionPosition.sqf";
MFW_fn_spawnGroups = compile preprocessFile "scripts\MissionFramework\fn_spawnGroups.sqf";
MFW_fn_spawnVehicles = compile preprocessFile "scripts\MissionFramework\fn_spawnVehicles.sqf";
MFW_fn_spawnUnitsInBuildings = compile preprocessFile "scripts\MissionFramework\fn_spawnUnitsInBuildings.sqf";
MFW_fn_createMissionMarker = compile preprocessFile "scripts\MissionFramework\fn_createMissionMarker.sqf";

// Position de la mission
_position = call MFW_fn_findMissionPosition;

// Objectif à détruire
objectif_class = "O_T_APC_Tracked_02_AA_ghex_F";

// Type Véhicule
objectif = [_position, 0, objectif_class, east] call BIS_fnc_spawnVehicle select 0;
objectif engineOn true;

// Type Batiment
// TODO

// Template base
// TODO

// Briefing / Marqueurs
[
	"Mission exemple", // Titre
	"Mission exemple", // Description
	"Destroy_And_EliminateMarker", // Type
	"mission_exemple", // ID
	_position
] call MFW_fn_createMissionMarker;

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

[liste_groupes, nombre_groupes, _position] call MFW_fn_spawnGroups;
[liste_vehicules, nombre_vehicules, _position] call MFW_fn_spawnVehicles;
[liste_unites, _position, east] call MFW_fn_spawnUnitsInBuildings;

// Attente fin d'objectif
while {alive objectif} do { sleep 10; };

// Succès
["mission_exemple", "SUCCEEDED"] spawn BIS_fnc_taskSetState;

// Nettoyage
// Après 5 minutes
sleep 3000;

["mission_exemple"] call BIS_fnc_deleteTask;

deleteVehicle _x foreach vehicules;
deleteVehicle _x foreach groupes;

deleteMarker "mission_exemple";
diag_log "Mission terminée";