private ["_flatPos","_accepted","_position","_fuzzyPos","_x","_briefing","_completeText","_PTdir","_dir","_pos","_targetList","_flatPos1","_flatPos2","_flatPos3","_doTargets","_targetSelect","_targetListEnemy"];

AAAunits = [];
AAAunits_veh = [];
AAAunits_squad = [];

// ----- Position
	// Position adéquate partout sur la carte
	mission_center = [[10000, 18300, 130], random 1000, 10000, 1, 0, 0.2, 0, []] call BIS_fnc_findSafePos;

	// Compatibilité
	_flatPos = mission_center;

	private _objPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

	_flatPos1 = [(_flatPos select 0) - 30, (_flatPos select 1) - 30, (_flatPos select 2)];
	_flatPos2 = [(_flatPos select 0) + 30, (_flatPos select 1) + 30, (_flatPos select 2)];
	_flatPos3 = [(_flatPos select 0) + 5, (_flatPos select 1) + random 5, (_flatPos select 2)];

// ----- Objectifs à détruire
	// Type d'objectif
	objective_vehicle = "O_T_APC_Tracked_02_AA_ghex_F";

	// Cap des objectifs
	_PTdir = random 360;

	objectives = [];

	objectives pushBack objective_vehicle CreateVehicle _flatPos1;
	objectives pushBack objective_vehicle CreateVehicle _flatPos2;
	objectives pushBack "O_Truck_03_ammo_F" createVehicle _flatPos3;
	sleep 0.5;

	objectives # 0 setDir _PTdir;
	objectives # 1 setDir _PTdir;

	// Ne pas faire descendre l'équipage
	{_x lock 3;_x allowCrewInImmobile true;} forEach objectives;

	// Compatibilité
	AAAObj1 = objectives # 0;
	AAAObj2 = objectives # 1;
	
//-------------------- 3. SPAWN CREW
	
	_unitsArray = [objNull];
	
	_AAAGroup = createGroup east;
	
	"O_officer_F" createUnit [_flatPos, _AAAGroup];
	"O_officer_F" createUnit [_flatPos, _AAAGroup];
	"O_engineer_F" createUnit [_flatPos, _AAAGroup];
	"O_engineer_F" createUnit [_flatPos, _AAAGroup];
	
	((units _AAAGroup) select 0) assignAsCommander AAAObj1;
	((units _AAAGroup) select 0) moveInCommander AAAObj1;
	((units _AAAGroup) select 2) assignAsGunner AAAObj1;
	((units _AAAGroup) select 2) moveInGunner AAAObj1;

	((units _AAAGroup) select 1) assignAsCommander AAAObj2;
	((units _AAAGroup) select 1) moveInCommander AAAObj2;
	((units _AAAGroup) select 3) assignAsGunner AAAObj2;
	((units _AAAGroup) select 3) moveInGunner AAAObj2;

	AAAunits_veh = AAAunits_veh + (units _AAAGroup);
	
	//---------- Engines on baby
	
	AAAObj1 engineOn true;
	AAAObj2 engineOn true;

	_barrier1 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) + 13.233, (_flatPos1 select 1) - 12.807, 0], [], 0, "CAN_COLLIDE"];
	_barrier1 setDir 314.723;
	_barrier2 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) + 12.742, (_flatPos1 select 1) + 12.758, 0], [], 0, "CAN_COLLIDE"];
	_barrier2 setDir 226.771;
	_barrier3 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) - 13.345, (_flatPos1 select 1) + 12.662, 0], [], 0, "CAN_COLLIDE"];
	_barrier3 setDir 137.039;
	_barrier4 = createVehicle ["Land_HBarrierTower_F", [(_flatPos1 select 0) - 12.795, (_flatPos1 select 1) - 13.303, 0], [], 0, "CAN_COLLIDE"];
	_barrier4 setDir 44.675;
	_barrier5 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 5.283, (_flatPos1 select 1) - 15.125, 0], [], 0, "CAN_COLLIDE"];
	_barrier6 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 5.646, (_flatPos1 select 1) - 15.002, 0], [], 0, "CAN_COLLIDE"];
	_barrier7 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 5.817, (_flatPos1 select 1) + 14.726, 0], [], 0, "CAN_COLLIDE"];
	_barrier8 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 5.295, (_flatPos1 select 1) + 14.918, 0], [], 0, "CAN_COLLIDE"];
	_barrier9 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 15.173, (_flatPos1 select 1) - 5.375, 0], [], 0, "CAN_COLLIDE"];
	_barrier9 setDir 90;
	_barrier10 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) + 14.929, (_flatPos1 select 1) + 5.271, 0], [], 0, "CAN_COLLIDE"];
	_barrier10 setDir 90;
	_barrier11 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 15.381, (_flatPos1 select 1) + 5.256, 0], [], 0, "CAN_COLLIDE"];
	_barrier11 setDir 90;
	_barrier12 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos1 select 0) - 14.958, (_flatPos1 select 1) - 5.785, 0], [], 0, "CAN_COLLIDE"];
	_barrier12 setDir 90;
	_barrier13 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0), (_flatPos1 select 1) - 8.75, 0], [], 0, "CAN_COLLIDE"];
	_barrier13 setDir 358.5;
	_barrier14 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) + 9, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
	_barrier14 setDir 268;
	_barrier15 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0), (_flatPos1 select 1) + 8.402, 0], [], 0, "CAN_COLLIDE"];
	_barrier15 setDir 178;
	_barrier16 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos1 select 0) - 9.475, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
	_barrier16 setDir 88.5;
	_spawnedObjects = [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8,_barrier9,_barrier10,_barrier11,_barrier12,_barrier13,_barrier14,_barrier15,_barrier16];

	{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects;

	sleep 1;

	Tourelle1 = createVehicle ["O_GMG_01_high_F", [(_flatPos1 select 0) + 8.685, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
	Tourelle1 setDir 90;
	Tourelle2 = createVehicle ["O_HMG_02_high_F", [(_flatPos1 select 0), (_flatPos1 select 1) + 8.863, 0], [], 0, "CAN_COLLIDE"];
	Tourelle3 = createVehicle ["O_GMG_01_high_F", [(_flatPos1 select 0) - 9.297, (_flatPos1 select 1), 0], [], 0, "CAN_COLLIDE"];
	Tourelle3 setDir 270;
	Tourelle4 = createVehicle ["O_HMG_02_high_F", [(_flatPos1 select 0), (_flatPos1 select 1) - 9.137, 0], [], 0, "CAN_COLLIDE"];
	Tourelle4 setDir 180;

	Tourelle1 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle1)) then { Tourelle1 setVehicleAmmo 1; };}];
	Tourelle2 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle2)) then { Tourelle2 setVehicleAmmo 1; };}];
	Tourelle3 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle3)) then { Tourelle3 setVehicleAmmo 1; };}];
	Tourelle4 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle4)) then { Tourelle4 setVehicleAmmo 1; };}];

	{_x lock 3;_x allowCrewInImmobile true;} forEach [Tourelle1,Tourelle2,Tourelle3,Tourelle4];

	sleep 1;

	_TourelleGroup = createGroup EAST;
		
	"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup];
	"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup];
	"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup];
	"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup];

	
	((units _TourelleGroup) select 0) assignAsGunner Tourelle1;
	((units _TourelleGroup) select 0) moveInGunner Tourelle1;
	((units _TourelleGroup) select 1) assignAsGunner Tourelle2;
	((units _TourelleGroup) select 1) moveInGunner Tourelle2;
	((units _TourelleGroup) select 2) assignAsGunner Tourelle3;
	((units _TourelleGroup) select 2) moveInGunner Tourelle3;
	((units _TourelleGroup) select 3) assignAsGunner Tourelle4;
	((units _TourelleGroup) select 3) moveInGunner Tourelle4;

	
	AAAunits_veh = AAAunits_veh + (units _TourelleGroup);

	sleep 1;

	//create Hostile forces:
	private ["_PAX1","_PAX2","_PAX3","_PAX4","_PAX5","_PAX6","_PAX7","_PAX8"];	
	private _PAXGroup = createGroup EAST;

	_PAX1 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) - 12.453, (_flatPos1 select 1) - 14.131, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX1 setDir 162;
	_PAX2 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) - 13.44, (_flatPos1 select 1) - 13.369, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX2 setDir 266;
	_PAX3 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) + 14.21, (_flatPos1 select 1) - 12.809, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX3 setDir 77;
	_PAX4 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) + 13.353, (_flatPos1 select 1) - 13.772, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX4 setDir 182;
	_PAX5 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) + 12.783, (_flatPos1 select 1) + 13.549, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX5 setDir 348;
	_PAX6 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) + 13.608, (_flatPos1 select 1) + 12.765, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX6 setDir 93;
	_PAX7 = _PAXGroup createUnit ["O_R_soldier_M_F", [(_flatPos1 select 0) - 14.234, (_flatPos1 select 1) + 12.533, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX7 setDir 255;
	_PAX8 = _PAXGroup createUnit ["O_R_Soldier_AR_F", [(_flatPos1 select 0) - 13.372, (_flatPos1 select 1) + 13.503, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX8 setDir 0;

	{	_x disableAI "PATH";
		_spawnedUnits = _spawnedUnits + [_x];
	} forEach (units _PAXGroup);
	_groupsArray = _groupsArray + [_PAXGroup];
	_PAXGroup setGroupIdGlobal [format ['rescue-HostageTakers']];

			AAAunits = AAAunits + (units _PAXGroup);

	{_x addCuratorEditableObjects [units _PAXGroup, false];} foreach allCurators;	
	sleep 1;

	_barrier17 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) + 13.233, (_flatPos2 select 1) - 12.807, 0], [], 0, "CAN_COLLIDE"];
	_barrier17 setDir 314.723;
	_barrier18 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) + 12.742, (_flatPos2 select 1) + 12.758, 0], [], 0, "CAN_COLLIDE"];
	_barrier18 setDir 226.771;
	_barrier19 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) - 13.345, (_flatPos2 select 1) + 12.662, 0], [], 0, "CAN_COLLIDE"];
	_barrier19 setDir 137.039;
	_barrier20 = createVehicle ["Land_HBarrierTower_F", [(_flatPos2 select 0) - 12.795, (_flatPos2 select 1) - 13.303, 0], [], 0, "CAN_COLLIDE"];
	_barrier20 setDir 44.675;
	_barrier21 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 5.283, (_flatPos2 select 1) - 15.125, 0], [], 0, "CAN_COLLIDE"];
	_barrier22 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 5.646, (_flatPos2 select 1) - 15.002, 0], [], 0, "CAN_COLLIDE"];
	_barrier23 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 5.817, (_flatPos2 select 1) + 14.726, 0], [], 0, "CAN_COLLIDE"];
	_barrier24 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 5.295, (_flatPos2 select 1) + 14.918, 0], [], 0, "CAN_COLLIDE"];
	_barrier25 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 15.173, (_flatPos2 select 1) - 5.375, 0], [], 0, "CAN_COLLIDE"];
	_barrier25 setDir 90;
	_barrier26 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) + 14.929, (_flatPos2 select 1) + 5.271, 0], [], 0, "CAN_COLLIDE"];
	_barrier26 setDir 90;
	_barrier27 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 15.381, (_flatPos2 select 1) + 5.256, 0], [], 0, "CAN_COLLIDE"];
	_barrier27 setDir 90;
	_barrier28 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos2 select 0) - 14.958, (_flatPos2 select 1) - 5.785, 0], [], 0, "CAN_COLLIDE"];
	_barrier28 setDir 90;
	_barrier29 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0), (_flatPos2 select 1) - 8.75, 0], [], 0, "CAN_COLLIDE"];
	_barrier29 setDir 358.5;
	_barrier30 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0) + 9, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
	_barrier30 setDir 268;
	_barrier31 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0), (_flatPos2 select 1) + 8.402, 0], [], 0, "CAN_COLLIDE"];
	_barrier31 setDir 178;
	_barrier32 = createVehicle ["Land_BagBunker_Small_F", [(_flatPos2 select 0) - 9.475, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
	_barrier32 setDir 88.5;
	_spawnedObjects2 = [_barrier17,_barrier18,_barrier19,_barrier20,_barrier21,_barrier22,_barrier23,_barrier24,_barrier25,_barrier26,_barrier27,_barrier28,_barrier29,_barrier30,_barrier31,_barrier32];

	//
	{_x addCuratorEditableObjects [_spawnedObjects2, false];} forEach allCurators;
	//	
	{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects2;

	sleep 1;

	Tourelle5 = createVehicle ["O_GMG_01_high_F", [(_flatPos2 select 0) + 8.685, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
	Tourelle5 setDir 90;
	Tourelle6 = createVehicle ["O_HMG_02_high_F", [(_flatPos2 select 0), (_flatPos2 select 1) + 8.863, 0], [], 0, "CAN_COLLIDE"];
	Tourelle7 = createVehicle ["O_GMG_01_high_F", [(_flatPos2 select 0) - 9.297, (_flatPos2 select 1), 0], [], 0, "CAN_COLLIDE"];
	Tourelle7 setDir 270;
	Tourelle8 = createVehicle ["O_HMG_02_high_F", [(_flatPos2 select 0), (_flatPos2 select 1) - 9.137, 0], [], 0, "CAN_COLLIDE"];
	Tourelle8 setDir 180;

	Tourelle5 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle5)) then { Tourelle5 setVehicleAmmo 1; };}];
	Tourelle6 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle6)) then { Tourelle6 setVehicleAmmo 1; };}];
	Tourelle7 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle7)) then { Tourelle7 setVehicleAmmo 1; };}];
	Tourelle8 addEventHandler ["Fired",{if (!isPlayer (gunner Tourelle8)) then { Tourelle8 setVehicleAmmo 1; };}];

	{_x lock 3;_x allowCrewInImmobile true;} forEach [Tourelle5,Tourelle6,Tourelle7,Tourelle8];

	sleep 1;

	sleep 1;

	_TourelleGroup2 = createGroup EAST;
		
		"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup2];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup2];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup2];
		"O_R_Soldier_GL_F" createUnit [_flatPos, _TourelleGroup2];

		
		((units _TourelleGroup2) select 0) assignAsGunner Tourelle5;
		((units _TourelleGroup2) select 0) moveInGunner Tourelle5;
		((units _TourelleGroup2) select 1) assignAsGunner Tourelle6;
		((units _TourelleGroup2) select 1) moveInGunner Tourelle6;
		((units _TourelleGroup2) select 2) assignAsGunner Tourelle7;
		((units _TourelleGroup2) select 2) moveInGunner Tourelle7;
		((units _TourelleGroup2) select 3) assignAsGunner Tourelle8;
		((units _TourelleGroup2) select 3) moveInGunner Tourelle8;

		
		AAAunits_veh = AAAunits_veh + (units _TourelleGroup2);
	{
		_x addCuratorEditableObjects [[Tourelle5,Tourelle6,Tourelle7,Tourelle8] + (units _TourelleGroup2), false];
	} foreach adminCurators;

	sleep 1;

	//create Hostile forces:
	private ["_PAX9","_PAX10","_PAX11","_PAX12","_PAX13","_PAX14","_PAX15","_PAX16"];	
	private _PAXGroup2 = createGroup EAST;

	_PAX9 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) - 12.453, (_flatPos2 select 1) - 14.131, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX9 setDir 162;
	_PAX10 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) - 13.44, (_flatPos2 select 1) - 13.369, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX10 setDir 266;
	_PAX11 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) + 14.21, (_flatPos2 select 1) - 12.809, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX11 setDir 77;
	_PAX12 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) + 13.353, (_flatPos2 select 1) - 13.772, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX12 setDir 182;
	_PAX13 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) + 12.783, (_flatPos2 select 1) + 13.549, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX13 setDir 348;
	_PAX14 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) + 13.608, (_flatPos2 select 1) + 12.765, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX14 setDir 93;
	_PAX15 = _PAXGroup2 createUnit ["O_R_soldier_M_F", [(_flatPos2 select 0) - 14.234, (_flatPos2 select 1) + 12.533, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX15 setDir 255;
	_PAX16 = _PAXGroup2 createUnit ["O_R_Soldier_AR_F", [(_flatPos2 select 0) - 13.372, (_flatPos2 select 1) + 13.503, 2.4], [], 0, "CAN_COLLIDE"];
	_PAX16 setDir 0;

	{	_x disableAI "PATH";
		_spawnedUnits2 = _spawnedUnits2 + [_x];
	} forEach (units _PAXGroup2);
	_groupsArray2 = _groupsArray2 + [_PAXGroup2];
	_PAXGroup2 setGroupIdGlobal [format ['rescue-HostageTakers']];

			AAAunits = AAAunits + (units _PAXGroup2);

	{_x addCuratorEditableObjects [units _PAXGroup2, false];} foreach allCurators;	
		
	sleep 1;


	//-------------------- 6. THAT GIRL IS SO DANGEROUS!

	[(units _AAAGroup)] call QS_fnc_setSkill4;
	_AAAGroup setBehaviour "COMBAT";
	_AAAGroup setCombatMode "RED";	
	_AAAGroup allowFleeing 0;
	
	//----- 6a. UNLIMITED AMMO

	// AAAObj1 addEventHandler ["Fired",{ AAAObj1 setVehicleAmmo 1 }];
	// AAAObj2 addEventHandler ["Fired",{ AAAObj2 setVehicleAmmo 1 }];

	//-------------------- 6b. ABIT OF EXTRA HEALTH

	//---------- OBJ 1
	
	//	AAAObj1 setVariable ["selections", []];
	//	AAAObj1 setVariable ["gethit", []];
	//	AAAObj1 addEventHandler
	//	[
	//		"HandleDamage",
	//		{
	//			_unit = _this select 0;
	//			_selections = _unit getVariable ["selections", []];
	//			_gethit = _unit getVariable ["gethit", []];
	//			_selection = _this select 1;
	//			if !(_selection in _selections) then
	//			{
	//				_selections set [count _selections, _selection];
	//				_gethit set [count _gethit, 0];
	//			};
	//			_i = _selections find _selection;
	//			_olddamage = _gethit select _i;
	//			_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
	//			_gethit set [_i, _damage];
	//			_damage;
	//		}
	//	];
	//
	////---------- OBJ 2
	//
	//	AAAObj2 setVariable ["selections", []];
	//	AAAObj2 setVariable ["gethit", []];
	//	AAAObj2 addEventHandler
	//	[
	//		"HandleDamage",
	//		{
	//			_unit = _this select 0;
	//			_selections = _unit getVariable ["selections", []];
	//			_gethit = _unit getVariable ["gethit", []];
	//			_selection = _this select 1;
	//			if !(_selection in _selections) then
	//			{
	//				_selections set [count _selections, _selection];
	//				_gethit set [count _gethit, 0];
	//			};
	//			_i = _selections find _selection;
	//			_olddamage = _gethit select _i;
	//			_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
	//			_gethit set [_i, _damage];
	//			_damage;
	//		}
	//	];

//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 10),0];
	
	{ _x setMarkerPos _fuzzyPos; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"];
	Destroy_And_EliminateMarkerText = "Détruire la défense anti-aérienne"; publicVariable "Destroy_And_EliminateMarkerText";
	"Destroy_And_EliminateMarker" setMarkerText "Détruire la défense anti-aérienne"; publicVariable "Destroy_And_EliminateMarker";
	publicVariable "AAAObj1";publicVariable "AAAObj2";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Détruire la défense anti-aérienne</t><br/>____________________<br/>Les forces Russes ont déployé une défense anti-aérienne dans cette zone.<br/>Partez à sa recherche et détruisez la défense anti-aérienne...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Détruire la défense anti-aérienne"]; publicVariable "showNotification";
	Destroy_And_EliminateMarkerText = "Détruire la défense anti-aérienne"; publicVariable "Destroy_And_EliminateMarkerText";
	[west,["DETRUIREAAA"],["Les forces Russes ont déployé une défense anti-aérienne dans cette zone.<br/>Partez à sa recherche et détruisez la défense anti-aérienne...", "Détruire la défense anti-aérienne", "Détruire la défense anti-aérienne","Destroy_And_EliminateMarker"], _fuzzyPos,"Created",0,true,"mine",true] call BIS_fnc_taskCreate; 

	_marqueur = createMarker ["marqueur_aa_spetsnaz", _fuzzyPos];
	_marqueur setMarkerType "selector_selectedMission";
	"marqueur_aa_spetsnaz" setMarkerSize [2, 2];
	"marqueur_aa_spetsnaz" setMarkerColor "ColorRed";
	
	
//-------------------- SPAWN FORCE PROTECTION

_random = (round(random 2) + 2);

for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos AAAObj1,50 + random 200] call BIS_fnc_taskPatrol;
	AAAunits = AAAunits + (units _spawnGroup);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup, false];} forEach allCurators;
};


_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos AAAObj1,50 + random 200] call BIS_fnc_taskPatrol;
	AAAunits_squad = AAAunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};

_random = (round(random 1) + 1);
for "_i" from 0 to _random do 
{
	_nposition = [_fuzzyPos,random 50,250, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup_squad = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")] call BIS_fnc_spawnGroup;
	[_spawnGroup_squad, getpos AAAObj1,50 + random 200] call BIS_fnc_taskPatrol;
	AAAunits_squad = AAAunits_squad + (units _spawnGroup_squad);

	sleep 1;
	{_x addCuratorEditableObjects [units _spawnGroup_squad, false];} forEach allCurators;
};


	private _enemiesArray = [objNull];
	
	
	//=====defining vehicles=========
	_Randomvehicle = ["O_G_Offroad_01_armed_F","O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F","O_Heli_Attack_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_black_F","O_Heli_Light_02_F","O_Heli_Light_02_v2_F","O_MBT_04_command_F","O_MBT_04_cannon_F"];	

		//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;
	
	for "_i" from 0 to (2 + (random 3)) do {
		_randomPos = [_fuzzyPos, 10, 300, 5, 0, 0.3, 0, [], (getPos AAAObj1)] call BIS_fnc_findSafePos;
		_Vehiclegroup1 = createGroup EAST;
		_vehicletype = selectRandom _Randomvehicle;
		_vehicle1 = _vehicletype createVehicle _randomPos;
		createvehiclecrew _vehicle1;
		(crew _vehicle1) join _Vehiclegroup1;
		_vehpatrolgroupamount = _vehpatrolgroupamount + 1;
		_Vehiclegroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _vehpatrolgroupamount]];
		_vehicle1 lock 3;
		[_Vehiclegroup1, _fuzzyPos, 200 + (random 200)] call BIS_fnc_taskPatrol;
		{_x addCuratorEditableObjects [[_vehicle1] + units _Vehiclegroup1, false];} foreach allCurators;
		_enemiesArray = _enemiesArray + (units _Vehiclegroup1) + [_vehicle1];
		AAAunits_veh = AAAunits_veh + (units _Vehiclegroup1);
	};
	
	sleep 0.1;
	
	

	_infunits = ["O_R_Soldier_TL_F","O_R_Soldier_AR_F","O_R_soldier_exp_F","O_R_Soldier_GL_F","O_R_Soldier_LAT_F","O_R_soldier_M_F","O_R_Patrol_Soldier_M_F","O_R_Patrol_Soldier_Medic","O_R_Patrol_Soldier_Engineer_F"];
	
	
	
	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [AAAObj1, ["house","building"], 400];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;
		if (_infBuildingAmount > 20 ) then {_GarrisonedBuildings = _infBuildingAmount*3/4;};
		if (_infBuildingAmount > 40 ) then {_GarrisonedBuildings = _infBuildingAmount/2;};
		if (_infBuildingAmount > 60 ) then {_GarrisonedBuildings = 30;};

		for "_i" from 0 to _GarrisonedBuildings do {
			_garrisongroup = createGroup EAST;
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

			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
			AAAunits_squad = AAAunits_squad + (units _garrisongroup);
			sleep 0.1;
		};
	};

		// Spawn a CAS jet to patrol the Radio.
		 
		#define PLANE_TYPE "O_Plane_CAS_02_dynamicLoadout_F","O_Plane_Fighter_02_F","I_Plane_Fighter_04_F"
		 
		_plane = createVehicle [([PLANE_TYPE] call BIS_fnc_selectRandom), [0,0,0], [], 0, "FLY"];
		 
		_plane addEventHandler ["Fired",{
			(_this select 0) setVehicleAmmo 1
		}];
		 
		_pilotguy = [[0,0,0], EAST, ["O_Fighter_Pilot_F"],[],[],[],[],[],232] call BIS_fnc_spawnGroup;
		 
		((units _pilotguy) select 0) moveInDriver _plane;
		 
		_wpcas = _pilotguy addWaypoint [getmarkerPos "AAAMarker", 500];
		_wpcas setWaypointType "LOITER";
		_wpcas setWaypointLoiterRadius 3500;
		_wpcas setWaypointLoiterType "CIRCLE_L";
		_wpcas setWaypointBehaviour "AWARE";
		_wpcas setWaypointCombatMode "RED";
		[_pilotguy, _fuzzyPos, 1000 + (random 4000)] call BIS_fnc_taskPatrol;
		sleep 20;
		
		_plane = createVehicle [([PLANE_TYPE] call BIS_fnc_selectRandom), [0,0,0], [], 0, "FLY"];
		 
		_plane addEventHandler ["Fired",{
			(_this select 0) setVehicleAmmo 1
		}];
		 
		_pilotguy = [[0,0,0], EAST, ["O_Fighter_Pilot_F"],[],[],[],[],[],232] call BIS_fnc_spawnGroup;
		 
		((units _pilotguy) select 0) moveInDriver _plane;
		 
		_wpcas = _pilotguy addWaypoint [getmarkerPos "AAAMarker", 500];
		_wpcas setWaypointType "LOITER";
		_wpcas setWaypointLoiterRadius 3500;
		_wpcas setWaypointLoiterType "CIRCLE_L";
		_wpcas setWaypointBehaviour "AWARE";
		_wpcas setWaypointCombatMode "RED";
		[_pilotguy, _fuzzyPos, 1000 + (random 4000)] call BIS_fnc_taskPatrol;
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	AAAMissionUp = true; publicVariable "AAAMissionUp";
	AAA_SUCCESS = false; publicVariable "AAA_SUCCESS";


	
while { alive AAAObj1 || alive AAAObj2 } do { sleep 10; };

//-------------------- DE-BRIEFING
AAAMissionUp = false; publicVariable "AAAMissionUp";
AAA_SUCCESS = true;
_CompleteText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#FF0000'>REUSSIE</t><br/>____________________<br/>La défense anti-aérienne est détruite! Bravo!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>"];
GlobalHint = _CompleteText; publicVariable "GlobalHint"; hint parseText _CompleteText;
showNotification = ["CompletedMission", Destroy_And_EliminateMarkerText]; publicVariable "showNotification";
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["Destroy_And_EliminateMarker", "Destroy_And_EliminateCircle"]; publicVariable "Destroy_And_EliminateMarker";
_null = ["DETRUIREAAA", "SUCCEEDED"] spawn BIS_fnc_taskSetState;

//--------------------- DELETE

sleep 60;
["DETRUIREAAA"] call BIS_fnc_deleteTask; 
{deletevehicle _x} foreach AAAunits;
{deletevehicle _x} foreach AAAunits_veh;
{deletevehicle _x} foreach AAAunits_squad;
{deletevehicle _x} foreach [Tourelle1,Tourelle2,Tourelle3,Tourelle4,Tourelle5,Tourelle6,Tourelle7,Tourelle8];

{_x removeEventHandler ["Fired", 0];} forEach [AAAObj1,AAAObj2];
{_x removeEventHandler ["HandleDamage",1];} forEach [AAAObj1,AAAObj2];
AAAunits = [];
AAAunits_veh = [];
AAAunits_squad = [];
[_flatPos, _spawnedObjects]spawn {

	deleteVehicle nearestObject[(_this select 0), "O_Truck_03_ammo_F"];
	{
	if (!(isNull _x) && {alive _x}) then {
		deleteVehicle _x;
	};
	} foreach (_this select 1);
		
};	
[_flatPos, _spawnedObjects2]spawn {

	deleteVehicle nearestObject[(_this select 0), "O_Truck_03_ammo_F"];
	{
	if (!(isNull _x) && {alive _x}) then {
		deleteVehicle _x;
	};
	} foreach (_this select 1);
		
};	
{deleteVehicle _x;} forEach [ammoTruck];
{deleteVehicle _x; sleep 0.1;} forEach _enemiesArray;	
deleteMarker "marqueur_aa_spetsnaz";
diag_log "Mission terminée";