/*
Author: 

	[MF] Alex Yuri / [MF] Ricky

Last modified: 

	12 Novembre 2022 by [MF] Ricky

Description:

	Mission Détruire caches de munition

*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_completeText","_unitsArray"];

Armementunits = [];
Armementunits_veh = [];
Armementunits_squad = [];




//-------------------- FIND POSITION FOR OBJECTIVE

	_flatPos = [[9938,18283,131],random 1000,10000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];
		};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700) then {
			_accepted = true;
		};
	};

private _objPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

	_flatPos1 = [(_flatPos select 0) + 0, (_flatPos select 1) + 8, (_flatPos select 2)];
	_flatPos2 = [(_flatPos select 0) + 2, (_flatPos select 1) + 11, (_flatPos select 2)];
	_flatPos3 = [(_flatPos select 0) - 3, (_flatPos select 1) + 11, (_flatPos select 2)];

	//-------------------- SPAWN OBJECTIVE

ArmementObj1 = "Box_FIA_Support_F" createVehicle _flatPos1;
waitUntil {alive ArmementObj1};
ArmementObj1 setVectorUp [0,0,1];
ArmementObj1 setDir 0;
_flatPos1 = getPos ArmementObj1;

ArmementObj2 = "Box_FIA_Ammo_F" createVehicle _flatPos2;
waitUntil {alive ArmementObj2};
ArmementObj2 setVectorUp [0,0,1];
ArmementObj2 setDir 0;
_flatPos2 = getPos ArmementObj2;

ArmementObj3 = "Box_FIA_Wps_F" createVehicle _flatPos3;
waitUntil {alive ArmementObj3};
ArmementObj3 setVectorUp [0,0,1];
ArmementObj3 setDir 0;
_flatPos3 = getPos ArmementObj3;
{_x addCuratorEditableObjects [[ArmementObj1,ArmementObj2,ArmementObj3], false];} forEach allCurators;


_barrier1 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 0, (_flatPos1 select 1) - 4, 0], [], 0, "CAN_COLLIDE"];
_barrier2 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 0, (_flatPos1 select 1) + 8, 0], [], 0, "CAN_COLLIDE"];
_barrier3 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 11, (_flatPos1 select 1) + 2, 0], [], 0, "CAN_COLLIDE"];
_barrier3 setDir 90;
_barrier4 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 11, (_flatPos1 select 1) + 2, 0], [], 0, "CAN_COLLIDE"];
_barrier4 setDir 90;
_barrier5 = createVehicle ["CamoNet_INDP_open_F", [(_flatPos1 select 0) + 0, (_flatPos1 select 1) + 2, 0], [], 0, "CAN_COLLIDE"];
_barrier6 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) - 5.723, (_flatPos1 select 1) - 5.973, 0], [], 0, "CAN_COLLIDE"];
_barrier7 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) + 5.723, (_flatPos1 select 1) - 5.973, 0], [], 0, "CAN_COLLIDE"];
_barrier8 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) - 5.723, (_flatPos1 select 1) + 9.885, 0], [], 0, "CAN_COLLIDE"];
_barrier8 setDir 180;
_barrier9 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) + 5.723, (_flatPos1 select 1) + 9.885, 0], [], 0, "CAN_COLLIDE"];
_barrier9 setDir 180;
_spawnedObjects = [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8,_barrier9];
//
{_x addCuratorEditableObjects [_spawnedObjects, false];} forEach allCurators;
//	
{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects;

Tourelle1 = createVehicle ["I_GMG_01_high_F", [(_flatPos1 select 0) - 5.886, (_flatPos1 select 1) - 5.852, 0], [], 0, "CAN_COLLIDE"];
Tourelle1 setDir 180;
Tourelle2 = createVehicle ["I_HMG_02_high_F", [(_flatPos1 select 0) + 5.61, (_flatPos1 select 1) - 5.852, 0], [], 0, "CAN_COLLIDE"];
Tourelle2 setDir 180;
Tourelle3 = createVehicle ["I_GMG_01_high_F", [(_flatPos1 select 0) + 5.918, (_flatPos1 select 1) + 9.61, 0], [], 0, "CAN_COLLIDE"];
Tourelle4 = createVehicle ["I_HMG_02_high_F", [(_flatPos1 select 0) - 5.59, (_flatPos1 select 1) + 9.61, 0], [], 0, "CAN_COLLIDE"];

Tourelle1 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle1)) then { Tourelle1 setVehicleAmmo 1; };}];
Tourelle2 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle2)) then { Tourelle2 setVehicleAmmo 1; };}];
Tourelle3 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle3)) then { Tourelle3 setVehicleAmmo 1; };}];
Tourelle4 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle4)) then { Tourelle4 setVehicleAmmo 1; };}];

{_x lock 3;_x allowCrewInImmobile true;} forEach [Tourelle1,Tourelle2,Tourelle3,Tourelle4];

sleep 1;

	_TourelleGroup = createGroup Independent;
		
		"I_G_Soldier_F" createUnit [_flatPos, _TourelleGroup];
		"I_G_Soldier_F" createUnit [_flatPos, _TourelleGroup];
		"I_G_Soldier_F" createUnit [_flatPos, _TourelleGroup];
		"I_G_Soldier_F" createUnit [_flatPos, _TourelleGroup];
		
		((units _TourelleGroup) select 0) assignAsGunner Tourelle1;
		((units _TourelleGroup) select 0) moveInGunner Tourelle1;
		((units _TourelleGroup) select 1) assignAsGunner Tourelle2;
		((units _TourelleGroup) select 1) moveInGunner Tourelle2;
		((units _TourelleGroup) select 2) assignAsGunner Tourelle3;
		((units _TourelleGroup) select 2) moveInGunner Tourelle3;
		((units _TourelleGroup) select 3) assignAsGunner Tourelle4;
		((units _TourelleGroup) select 3) moveInGunner Tourelle4;

		
		Armementunits_veh = Armementunits_veh + (units _TourelleGroup);
	{
		_x addCuratorEditableObjects [[Tourelle1,Tourelle2,Tourelle3,Tourelle4] + (units _TourelleGroup), false];
	} foreach adminCurators;

sleep 1;

//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"];
	Destroy_And_EliminateMarkerText = "Détruire les caches de munitions"; publicVariable "Destroy_And_EliminateMarkerText";
	"Destroy_And_EliminateMarker" setMarkerText "Détruire les caches de munitions"; publicVariable "Destroy_And_EliminateMarker";
	publicVariable "ArmementObj1";publicVariable "ArmementObj2";publicVariable "ArmementObj3";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Détruire les caches de munitions</t><br/>____________________<br/>Les FIA protègent des caches de munitions dans cette zone.<br/>Partez à la recherche des caches de munitions et détruisez les...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Détruire les caches de munitions"]; publicVariable "showNotification";
	Destroy_And_EliminateMarkerText = "Détruire les caches de munitions"; publicVariable "Destroy_And_EliminateMarkerText";
	[west,["DETRUIRECACHES"],["Les FIA protègent des caches de munitions dans cette zone.<br/>Partez à la recherche des caches de munitions et détruisez les...", "Détruire les caches de munitions", "Détruire les caches de munitions","Destroy_And_EliminateMarker"],(getMarkerPos "Destroy_And_EliminateMarker"),"Created",0,true,"mine",true] call BIS_fnc_taskCreate; 

private _noSpawning = 500;
	
//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, Independent, (configfile >> "CfgGroups" >> "East" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits = Armementunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> " IRG_InfTeam_AT")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 2) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> " IRG_InfSentry")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfAssault")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "B_G_InfSquad_Assault")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "B_G_InfTeam_Light")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos ArmementObj1,50 + random 200] call BIS_fnc_taskPatrol;
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


_random = (round(random 2) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, Independent, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_SniperTeam_M")] call BIS_fnc_spawnGroup;	
	_spawnGroup_squad setBehaviour "COMBAT";	
	Armementunits_squad = Armementunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

	private _enemiesArray = [objNull];

	
		//=====defining vehicles=========
private _vehicletypes = ["I_G_Offroad_01_armed_F","I_G_Offroad_01_AT_F","I_static_AA_F","I_static_AT_F","I_HMG_01_high_F","I_G_Mortar_01_F"];	

//vehicles
private _RandomVicAmount = 0;
for "_x" from 1 to 5 do {
	private _randomPos = [_fuzzyPos, 10, 75, 5, 0, 0.3, 0, [], _fuzzyPos] call BIS_fnc_findSafePos;
	
	private _grp1 = createGroup resistance;
	_RandomVicAmount = _RandomVicAmount + 1;
	_grp1 setGroupIdGlobal [format ['rescue-RandVic-%1', _RandomVicAmount]];
	private _vehicletype = selectRandom _vehicletypes;
	private _vehc =  _vehicletype createVehicle _randompos;
	_vehc allowCrewInImmobile true;
	_vehc lock 2;
	
	if (_vehicletype == "I_G_Offroad_01_armed_F") then {
	createVehicleCrew _vehc;
		(crew _vehc) join _grp1;
		[_grp1, _fuzzyPos, 275] call BIS_fnc_taskPatrol;
		_grp1 setSpeedMode "LIMITED";
	}else{
	private _grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _fuzzyPos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (random 360);
	};

	_groupsArray = _groupsArray + [_grp1];
	_spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];
	{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} forEach allCurators;
};
	
	sleep 0.1;

	_infunits = ["I_G_Soldier_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_M_F","I_G_Soldier_LAT_F","I_G_Soldier_A_F","I_G_officer_F"];
	
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [ArmementObj1, ["house","building"], 400];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;
		if (_infBuildingAmount > 20 ) then {_GarrisonedBuildings = _infBuildingAmount*3/4;};
		if (_infBuildingAmount > 40 ) then {_GarrisonedBuildings = _infBuildingAmount/2;};
		if (_infBuildingAmount > 60 ) then {_GarrisonedBuildings = 30;};

		for "_i" from 0 to _GarrisonedBuildings do {
			_garrisongroup = createGroup Independent;
			_garrisongroupamount = _garrisongroupamount + 1;
			_garrisongroup setGroupIdGlobal [format ['Side-GarrisonGroup-%1', _garrisongroupamount]];
			_infBuilding = selectRandom _infBuildingArray;
			_infBuildingArray = _infBuildingArray - [_infBuilding];
			_infbuildingpos = _infBuilding buildingPos -1;
			
			_buildingposcount = count _infbuildingpos;
			_Garrisonpos = _buildingposcount/2;
			
			for "_i" from 1 to _Garrisonpos do {
				_unitpos = selectRandom _infbuildingpos;
				_infbuildingpos = _infbuildingpos - _unitpos;
				_unittype = selectRandom _infunits;
				_unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
				_unit disableAI "PATH";
			};
			_enemiesArray = _enemiesArray + (units _garrisongroup);
			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
			Armementunits_squad = Armementunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	ArmementMissionUp = true; publicVariable "ArmementMissionUp";
	Armement_SUCCESS = false; publicVariable "Armement_SUCCESS";


	
while { ArmementMissionUp } do {
	

	
	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]
	 if (!alive ArmementObj1) then {
		if (!alive ArmementObj2) then {
			if (!alive ArmementObj3) then {
				
				//-------------------- DE-BRIEFING
				sleep 5;
				ArmementMissionUp = false; publicVariable "ArmementMissionUp";
				Armement_SUCCESS = true;
				_CompleteText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>REUSSIE</t><br/>____________________<br/>Les caches de munitions sont détruites! Bravo!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
				GlobalHint = _CompleteText; publicVariable "GlobalHint"; hint parseText _CompleteText;
				showNotification = ["CompletedMission", Destroy_And_EliminateMarkerText]; publicVariable "showNotification";
				{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"]; publicVariable "Destroy_And_EliminateMarker";
				_null = ["DETRUIRECACHES", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
				sleep 5;
				["DETRUIRECACHES"] call BIS_fnc_deleteTask; 
	
				//--------------------- DELETE
		
				sleep 120;

				{deletevehicle _x} foreach Armementunits;
				{deletevehicle _x} foreach Armementunits_veh;
				{deletevehicle _x} foreach Armementunits_squad;
				{deletevehicle _x} foreach [Tourelle1,Tourelle2,Tourelle3,Tourelle4];
				Armementunits = [];
				Armementunits_veh = [];
				Armementunits_squad = [];
				{ deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;
				{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;
			[_flatPos, _spawnedObjects]spawn {
		
				deleteVehicle nearestObject[(_this select 0), "Land_BagBunker_Small_F"];
				deleteVehicle nearestObject[(_this select 0), "Land_BagBunker_Small_ruins_F"];
				deleteVehicle nearestObject[(_this select 0), "CamoNet_INDP_open_F"];
				{
				if (!(isNull _x) && {alive _x}) then {
					deleteVehicle _x;
				};
				} foreach (_this select 1);
				};	
			};
		};
	};
};