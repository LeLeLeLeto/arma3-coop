/**
	Auteur : Léo 2023
	Fait apparaitre des véhicules de défense
	Retourne : liste des véhicules créés
 */

 params ["_liste_vehicules", "_nombre", "_position"];
 vehicules = [];

 for "i" from 0 to _nombre {
	vehicule = [
		[_position, 50, 200, -1, 0, 0.2] call BIS_fnc_findSafePos,
		0,
		selectRandom _liste_vehicules,
		east
	] call BIS_fnc_spawnVehicle;
	[vehicule, _position, 100 + random(250)] call BIS_fnc_taskPatrol;

	vehicules pushBack vehicule;
 }

 vehicules