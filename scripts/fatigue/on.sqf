_unit = _this select 0;
_unit removeAction fatigue;
//
_unit enableFatigue true;
_unit enableStamina true;
_unit setVariable ["fatigue","ON"];
//
fatigue = _unit addAction ["<t color='#99cc33'>Fatigue OFF</t>", "scripts\fatigue\off.sqf"];

