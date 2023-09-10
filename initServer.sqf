// _null = [] execVM "mission\InvasionMissionControl.sqf";
// _null = [] execVM "mission\RescueMissionControl.sqf";
// _null = [] execVM "mission\UnderwaterMissionControl.sqf";
// _null = [] execVM "mission\Voler_And_LOGMissionControl.sqf";

// ----- Missions
    _null = [] execVM "scripts\missions\mission_controle.sqf";

// Script de nettoyage
execVM "scripts\auto_clean.sqf";
// Script Zeus
execVM "scripts\units_to_zeus.sqf";

// Initialise le "Dynamic Groups Framework"
// (Permet la création et la gestion des équipes par les joueurs)
["Initialize", [true]] call BIS_fnc_dynamicGroups;

// Nécessaire : la compilation ne marche pas encore
MFW_fn_findMissionPosition = compile preprocessFile "scripts\MissionFramework\fn_findMissionPosition.sqf";
MFW_fn_spawnGroups = compile preprocessFile "scripts\MissionFramework\fn_spawnGroups.sqf";
MFW_fn_spawnVehicles = compile preprocessFile "scripts\MissionFramework\fn_spawnVehicles.sqf";
MFW_fn_spawnUnitsInBuildings = compile preprocessFile "scripts\MissionFramework\fn_spawnUnitsInBuildings.sqf";
MFW_fn_createMissionMarker = compile preprocessFile "scripts\MissionFramework\fn_createMissionMarker.sqf";

publicVariableServer "MFW_fn_findMissionPosition";
publicVariableServer "MFW_fn_spawnGroups";
publicVariableServer "MFW_fn_spawnVehicles";
publicVariableServer "MFW_fn_spawnUnitsInBuildings";
publicVariableServer "MFW_fn_createMissionMarker";