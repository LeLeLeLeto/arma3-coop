//-------------------------------------------------- Server scripts

// _null = [] execVM "mission\InvasionMissionControl.sqf";
// _null = [] execVM "mission\RescueMissionControl.sqf";
// _null = [] execVM "mission\UnderwaterMissionControl.sqf";
// _null = [] execVM "mission\Voler_And_LOGMissionControl.sqf";

// ----- Missions
    // Missions d'attaque et destruction
    _null = [] execVM "scripts\missions\attaque_destruction_controle.sqf";
    // Missions d'attaque
    _null = [] execVM "scripts\missions\attaque_controle.sqf";

// Script de nettoyage
execVM "scripts\auto_clean.sqf";
// Script Zeus
execVM "scripts\units_to_zeus.sqf";

// Initialise le "Dynamic Groups Framework"
// (Permet la création et la gestion des équipes par les joueurs)
["Initialize", [true]] call BIS_fnc_dynamicGroups;
