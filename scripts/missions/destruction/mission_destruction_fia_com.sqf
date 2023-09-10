// Stockage des unités apparues
private _groupes = [];

// Position de la mission
private _position = call MFW_fn_findMissionPosition;
private _id_mission = "mission_destruction_fia_com";

// Briefing / Marqueurs
[
	"Perturber les communications de la FIA", // Titre
	"La FIA communique depuis ce point. Empêchez-les !", // Description
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
	missionNamespace getVariable "objectif_destruction_fia_com_1"
];

// ----- Unités de défense
private _nombre_groupes = 6 + round(random(3));
private _liste_groupes = [
	(configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSquad"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfTeam"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AT"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSentry"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_G_F" >> "Infantry" >> "I_G_InfSquad_Assault"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_G_F" >> "Infantry" >> "I_G_InfTeam_Light"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")
];

private _nombre_vehicules = 1 + floor(random(3));
private _liste_vehicules = [
	"I_G_Offroad_01_armed_F",
	"I_G_Offroad_01_AT_F"
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

_groupes append ([_liste_groupes, _nombre_groupes, _position, independent] call MFW_fn_spawnGroups);
_groupes append ([_liste_vehicules, _nombre_vehicules, _position, independent] call MFW_fn_spawnVehicles);
_groupes append ([_liste_unites, _position, independent] call MFW_fn_spawnUnitsInBuildings);

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