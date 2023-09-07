_unit = _this select 0;
_unit removeAction fatigue;
//
_unit enableFatigue false;
_unit enableStamina false;
_unit setVariable ["fatigue","OFF"];
//
fatigue = _unit addAction ["<t color='#99cc33'>Fatigue ON</t>", "scripts\fatigue\on.sqf"];

