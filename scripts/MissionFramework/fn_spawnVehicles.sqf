/**
	Auteur : Léo 2023
	Fait apparaitre des véhicules de défense
	Retourne : liste des véhicules créés
 */

params ["_liste_vehicules", "_nombre", "_position", "_faction"];
private _resultat = [];

for "i" from 0 to _nombre do {
	private _groupe = createGroup _faction;
	private _vehicule = [
		[_position, 50, 200, -1, 0, 0.2] call BIS_fnc_findSafePos,
		0,
		selectRandom _liste_vehicules,
		_groupe
	] call BIS_fnc_spawnVehicle;
	[_groupe, _position, 400 + random(100)] call BIS_fnc_taskPatrol;

	_resultat pushBack _groupe;
};

_resultat