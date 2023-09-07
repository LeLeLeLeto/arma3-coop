// Attente obligatoire (Chargement ?)
sleep 1;

is_on = true;

earplugAction = {
	if(is_on) then {
		2 fadeSound 0.2;
		[parseText format ["<br/><t size='1.6' font='PuristaBold' align='center'>*** Bouchons mis *** </t>"], true, [10,5], 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
	} else {
		2 fadeSound 1;
		[parseText format ["<br/><t size='1.6' font='PuristaBold' align='center'>*** Bouchons enlevés *** </t>"], true, [10,5], 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
	};
	is_on = !is_on;
};

// Touche earplugs : PAUSE
event_earplugs = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 197) then {_this call earplugAction;};"];