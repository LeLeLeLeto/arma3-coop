/**
	Auteur : Léo 2023
	Fait apparaitre des groupes de défense
	Retourne : Liste des groupes créés
 */

params ["_liste_groupes", "_nombre", "_position"];
groupes = [];

for "i" from 0 to _nombre do {
	groupe = [
		[_position, 50, 200, -1, 0, 0.2] call BIS_fnc_findSafePos,
		east,
		selectRandom _liste_groupes
	] call BIS_fnc_spawnGroup;
	[groupe, _position, 250] call BIS_fnc_taskPatrol;

	groupes pushBack groupe;
};

groupes