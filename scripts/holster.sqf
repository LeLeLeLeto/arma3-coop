/**
	Enlève l'arme équipée et la place en holster / sur le dos.
	Marche avec toutes les armes même moddées.
	Touche FIN (Code 207).
 */

// Attente obligatoire
sleep 1;

holsterWeapon = {
	player action ["SwitchWeapon", player, player, -1];
};

event_holster = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 207) then {_this call holsterWeapon;};"];