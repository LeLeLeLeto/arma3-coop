// Attente obligatoire (Chargement ?)
sleep 1;

holsterWeapon = {
	player action ["SwitchWeapon", player, player, -1];
};

// Touche Holster : FIN
event_holster = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 207) then {_this call holsterWeapon;};"];