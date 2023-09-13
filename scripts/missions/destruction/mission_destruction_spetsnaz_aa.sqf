params ["_position"];

// Stockage des unités apparues
private _groupes = [];

// Position de la mission
private _id_mission = "mission_destruction_spetsnaz_aa";

// Briefing / Marqueurs
[
	"Détruire l'anti-aérien russe", // Titre
	"Nos pilotes peuvent à peine décoller ! Rendez-leur la vie plus facile et détruisez ces défenses !", // Description
	_id_mission, // Type
	_id_mission, // ID
	_position,
	"ColorRed"
] call MFW_fn_createMissionMarker;

// ----- Composition
private _composition = [
	_id_mission, // Nom composition (composition.cfg)
	_position
] call LARs_fnc_spawnComp;

// Objectif à détruire
// Bien noter le nom de variable des objectifs !
// (Ca veut dire que 2 mêmes mission ne peuvent pas être activées en même temps... pas grave)
// IMPORTANT : Il faut gérer les objectifs après la composition. Sinon ils ne sont pas encore chargés
private _objectifs = [
	missionNamespace getVariable "objectif_destruction_spetsnaz_aa_1",
	missionNamespace getVariable "objectif_destruction_spetsnaz_aa_2"
];

// ----- Unités de défense
private _nombre_groupes = 6 + round(random(3));
private _liste_groupes = [
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad"),
	(configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")
];

private _nombre_vehicules = 1 + floor(random(3));
private _liste_vehicules = [
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

private _liste_unites = [
	"O_R_Soldier_TL_F",
	"O_R_Soldier_AR_F",
	"O_R_soldier_exp_F",
	"O_R_Soldier_GL_F",
	"O_R_Soldier_LAT_F",
	"O_R_soldier_M_F",
	"O_R_Patrol_Soldier_M_F",
	"O_R_Patrol_Soldier_Medic",
	"O_R_Patrol_Soldier_Engineer_F"];

_groupes append ([_liste_groupes, _nombre_groupes, _position, east] call MFW_fn_spawnGroups);
_groupes append ([_liste_vehicules, _nombre_vehicules, _position, east] call MFW_fn_spawnVehicles);
_groupes append ([_liste_unites, _position, east] call MFW_fn_spawnUnitsInBuildings);

// Attente fin d'objectif
waitUntil {!alive (_objectifs select 0) && !alive (_objectifs select 1)};

// Succès
[_id_mission, "SUCCEEDED"] spawn BIS_fnc_taskSetState;

// Nettoyage
sleep 300;

{
	_y = _x; // _y : Groupe
	{
		deleteVehicle _x;
	} forEach units _y;
} forEach _groupes;

// Suppression de la composition est des unités
[ _composition ] call LARs_fnc_deleteComp;
[_id_mission] call BIS_fnc_deleteTask;
deleteMarker _id_mission;
diag_log "Mission terminée";