/**
	Auteur : Léo 2023
	Positionne la mission à un endroit adéquat
 */

[
	[0, 0], // Centre de la recherche
	0, // Distance minimale
	-1, // Distance maximale
	50, // Distance minimale avec d'autres objets
	0, // 0 : terre uniquement
	0.25, // Pente maximale
	0, // Mode côte
	[ // Blacklist
		positions_blacklist;
	]
] call BIS_fnc_findSafePos