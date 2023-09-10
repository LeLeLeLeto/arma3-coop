/** 
	Nettoie la carte automatiquement toutes les 20 minutes
 */

while {true} do {
	sleep 1200;

	execVM "scripts\clean_map.sqf";
};