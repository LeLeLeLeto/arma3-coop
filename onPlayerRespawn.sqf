// Initialisation de la fatigue (ON par défaut)
_unit = _this select 0;
_unit enableFatigue true;
_unit enableStamina true;
_unit setVariable ["fatigue","ON"];
fatigue = _unit addAction ["<t color='#99cc33'>Fatigue OFF</t>", "scripts\fatigue\off.sqf"];

// Options distance de vue
view = _unit addAction ["Distance de vue", CHVD_fnc_openDialog, [], -99, false, true];