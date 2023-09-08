/**
	Auteur : Léo 2023
	Fait apparaitre des véhicules de défense
	Retourne : liste des véhicules créés
 */

 params ["_liste_vehicules", "_nombre", "_position"];
 vehicules = [];

 for "i" from 0 to _nombre do {
	groupe = createGroup east;
	vehicule = [
		[_position, 50, 200, -1, 0, 0.2] call BIS_fnc_findSafePos,
		0,
		selectRandom _liste_vehicules,
		groupe
	] call BIS_fnc_spawnVehicle;
	[groupe, _position, random(400)] call BIS_fnc_taskPatrol;

	vehicules pushBack vehicule;
 };

 vehicules