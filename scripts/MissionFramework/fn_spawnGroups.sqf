/**
	Auteur : Léo 2023
	Fait apparaitre des groupes de défense
	Retourne : Liste des groupes créés
 */

params ["_liste_groupes", "_nombre", "_position", "_faction"];
groupes = [];

for "i" from 0 to _nombre do {
	groupe = [
		[_position, 150, 400, -1, 0, 0.2] call BIS_fnc_findSafePos,
		_faction,
		selectRandom _liste_groupes
	] call BIS_fnc_spawnGroup;
	[groupe, _position, 400] call BIS_fnc_taskPatrol;

	groupes pushBack groupe;
};

groupes