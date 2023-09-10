/**
	Auteur : Léo 2023
	Positionne la mission à un endroit adéquat
 */

[
	[14000, 16000], // Centre de la recherche
	5000, // Distance minimale
	-1, // Distance maximale
	0, // Distance minimale avec d'autres objets
	0, // 0 : terre uniquement
	0.2, // Pente maximale
	0, // Mode côte
	[] // Blacklist
] call BIS_fnc_findSafePos