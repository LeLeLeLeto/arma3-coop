// Groupes dynamiques
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

// ----- Scripts QoF
// Holster
[] execVM "scripts\holster.sqf";
// Bouchons d'oreilles
[] execVM "scripts\earplugs.sqf";
// Réapparition avec même inventaire
[] execVM "scripts\keepinventory.sqf";

