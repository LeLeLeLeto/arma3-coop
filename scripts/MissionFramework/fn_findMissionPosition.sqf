/**
	Auteur : Léo 2023
	Positionne la mission à un endroit adéquat
 */

[
	[14174, 16263], // Centre de la recherche
	2000, // Distance minimale
	-1, // Distance maximale
	0, // Distance minimale avec d'autres objets
	0, // 0 : terre uniquement
	0.15, // Pente maximale
	0, // Mode côte
	positions_blacklist
] call BIS_fnc_findSafePos