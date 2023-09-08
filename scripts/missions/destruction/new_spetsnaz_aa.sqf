/**
	Objectif : détruire les 2 canons anti-aériens
 */

// Recherche de position
position = call MFW_fn_findMissionPosition;

// Position des 2 canon anti-aériens : 100m d'espacement
position_obj1 = position;
position_obj1 set [0, position select 0 + 50];

position_obj2 = position;
position_obj2 set [0, position select 0 + 50];

// Création des véhicules et mise en route
objectifs = [
	"O_T_APC_Tracked_02_AA_ghex_F" createVehicle position_obj1,
	"O_T_APC_Tracked_02_AA_ghex_F" createVehicle position_obj2
];
{
	_x engineOn true;
	_x allowFleeing 0;
} forEach objectifs;

// Création de la mission
[
	"Détruire la défense anti-aérienne", 
	"Les forces russes ont déployé une défense anti-aérienne dans cette zone.", 
	"Destroy_And_EliminateMarker", 
	"spetsnaz_aa", 
	position
] call MFW_fn_createMissionMarker

// Création des forces ennemies
liste_groupes = [
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")
];
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
liste_infanterie = [
	"O_R_Soldier_TL_F",
	"O_R_Soldier_AR_F",
	"O_R_soldier_exp_F",
	"O_R_Soldier_GL_F",
	"O_R_Soldier_LAT_F",
	"O_R_soldier_M_F",
	"O_R_Patrol_Soldier_M_F",
	"O_R_Patrol_Soldier_Medic",
	"O_R_Patrol_Soldier_Engineer_F"
];

nombre_groupes = 4 + random(2);
nombre_vehicules = 2 + random(2);

groupes = [liste_groupes, nombre_groupes, position] call MFW_fn_spawnGroups;
vehicules = [liste_vehicules, nombre_vehicules, position] call MFW_fn_spawnVehicles;
groupes pushBack [liste_infanterie, position, east] call MFW_fn_spawnUnitsInBuildings;

// TODO faire apparaitre des avions ennemis

// Condition de victoire
// On vérifie si les objectifs sont morts toutes les 10 secondes
while {{alive _x} count objectifs > 0} do {sleep 10;};

["spetsnaz_aa", "SUCCEEDED"] spawn BIS_fnc_taskSetState;

sleep 300;
["spetsnaz_aa"] call BIS_fnc_deleteTask;
deleteMarker "spetsnaz_aa";

{deleteVehicle _x;} foreach groupes;
{deleteVehicle _x;} foreach vehicules;

diag_log "Mission terminée";