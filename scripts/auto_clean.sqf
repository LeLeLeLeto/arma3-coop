/** 
	Nettoie la carte automatiquement toutes les 10 minutes
 */

while {true} do {
	sleep 600;

	execVM "scripts\clean_map.sqf";
};