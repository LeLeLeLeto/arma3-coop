/**
	Auteur : Léo 2023
	Crée un marqueur sur la carte
 */

params ["_titre", "_description", "_type", "_id", "_position", "_color"];
[
	true,
	_id,
	[_description, _titre, _type],
	_position,
	"CREATED",
	0,
	true
] call BIS_fnc_taskCreate;

marqueur = createMarker [_id, _position];
marqueur setMarkerShape "ELLIPSE";
marqueur setMarkerBrush "FDiagonal";
marqueur setMarkerSize [1000, 1000];
marqueur setMarkerColor _color;