/**
    Fait réapparaitre le joueur avec le même inventaire
*/

addMissionEventHandler ["EntityKilled", {
	params ["_victim","_killer","_instigator"];
	if (isPlayer _victim) then {
		_victim setVariable ["inventory",getUnitLoadout _victim];
		_victim setVariable ["weapon",currentWeapon _victim];
	};
}];

addMissionEventHandler ["EntityRespawned", {
	params ["_unit","_corpse"];
	if (isPlayer _unit && local _unit) then {
            _unit setUnitLoadout (_corpse getVariable ["inventory",getUnitLoadout _unit]);
            _unit selectWeapon (_unit getVariable "weapon");
	};
}];
