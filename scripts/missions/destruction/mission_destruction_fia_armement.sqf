// Stockage des unités apparues
private _groupes = [];

// Position de la mission
private _position = call MFW_fn_findMissionPosition;
private _id_mission = "mission_destruction_fia_armement";

// Briefing / Marqueurs
[
	"Détruire la cache de munitions de la FIA", // Titre
	"La FIA stocke des munitions ici. A l'attaque !", // Description
	_id_mission, // Type
	_id_mission, // ID
	_position,
	"ColorGreen"
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
	missionNamespace getVariable "objectif_destruction_fia_armement_1"
];

// ----- Unités de défense
private _nombre_groupes = 6 + round(random(3));
private _liste_groupes = [
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad_Weapons"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam_AT"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_InfSentry"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_InfAssault"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "B_G_InfSquad_Assault"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "B_G_InfTeam_Light"),
	(configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_SniperTeam_M")
];

private _nombre_vehicules = 1 + floor(random(3));
private _liste_vehicules = [
	"I_G_Offroad_01_armed_F",
	"I_G_Offroad_01_AT_F",
	"I_static_AA_F",
	"I_static_AT_F",
	"I_HMG_01_high_F",
	"I_G_Mortar_01_F"
];

private _liste_unites = [
	"I_G_Soldier_F",
	"I_G_Soldier_lite_F",
	"I_G_Soldier_SL_F",
	"I_G_Soldier_AR_F",
	"I_G_medic_F",
	"I_G_engineer_F",
	"I_G_Soldier_exp_F",
	"I_G_Soldier_GL_F",
	"I_G_Soldier_M_F",
	"I_G_Soldier_LAT_F",
	"I_G_Soldier_A_F",
	"I_G_officer_F"
];

_groupes append ([_liste_groupes, _nombre_groupes, _position] call MFW_fn_spawnGroups);
_groupes append ([_liste_vehicules, _nombre_vehicules, _position] call MFW_fn_spawnVehicles);
_groupes append ([_liste_unites, _position, east] call MFW_fn_spawnUnitsInBuildings);

// Attente fin d'objectif
waitUntil {!alive (_objectifs select 0)};

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