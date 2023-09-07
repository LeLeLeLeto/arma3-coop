/*
Author: 

	Ryan Rodrigo

Last modified: 

	04 Novembre 2022 by [MF] Ricky

Description:

	Kill an officier

*/
private _towns = nearestLocations [(getMarkerPos "Base"), ["NameVillage"], 25000];

_missionLocation = getMarkerPos "Base";
while { _missionLocation distance getMarkerPos "Base" < 1500  } do {
	_missionLocation = position (selectRandom _towns);
};

_housePosition = nearestBuilding _missionLocation;

"officerHouse" setMarkerPos _housePosition;

_fuite = [5216,6075];

//------------Find Objective Position-------------

_housePrevList = getMarkerPos "officerHouse" nearObjects ["House", 300];
//_excludedbuildings = ["Land_nav_pier_m_F","Land_Pier_Box_F","Land_Pier_F","Land_Pier_wall_F","Land_TTowerSmall_1_F", "Land_Dome_Big_F", "Cargo_Patrol_base_F", "Cargo_House_base_F", "Cargo_Tower_base_F", "Cargo_HQ_base_F","Piers_base_F", "PowerLines_base_F", "PowerLines_Wires_base_F", "PowerLines_Small_base_F", "Land_PowerPoleWooden_L_F",  /*"Lamps_base_F",*/ "Land_Research_HQ_F", "Land_Research_house_V1_F", "Land_MilOffices_V1_F", "Land_TBox_F", "Land_Chapel_V1_F","Land_Chapel_Small_V2_F",  "Land_Chapel_Small_V1_F", "Land_BellTower_01_V1_F", "Land_BellTower_02_V1_F", "Land_fs_roof_F","Land_fs_feed_F", "Land_Windmill01_ruins_F", "Land_d_Windmill01_F", "Land_i_Windmill01_F","Land_i_Barracks_V2_F", "Land_spp_Transformer_F", "Land_dp_smallFactory_F", "Land_Shed_Big_F", "Land_Metal_Shed_F","Land_i_Shed_Ind_F","Land_Communication_anchor_F", "Land_TTowerSmall_2_F", "Land_Communication_F","Land_cmp_Shed_F", "Land_cmp_Tower_F", "Land_u_Shed_Ind_F", "Land_TBox_F"];
_houseList = _housePrevList /*- _excludedbuildings*/;
_officerHousePrevPos = position (selectRandom _houseList);
_officerHouse = nearestBuilding _officerHousePrevPos;

"officerHouse" setMarkerPos _officerHousePrevPos;

//------------Spawn Officer-----------------------

private _officergroup = createGroup east;

_officer = _officerGroup createUnit ["O_Officer_Parade_Veteran_F", nearestBuilding getMarkerPos "officerHouse", [], 0, "NONE"];
_officer setSkill 1;
_officer disableAI "PATH";

//------------Spawn Officer Bodyguard (2) + Officer Patrol-----

_bodyguard1 = _officergroup createUnit ["O_V_Soldier_JTAC_hex_F", nearestBuilding _officer, [], 0, "NONE"];
_bodyguard1 setSkill 1;
_bodyguard1 disableAI "PATH";

_bodyguard2 = _officergroup createUnit ["O_V_Soldier_JTAC_hex_F", nearestBuilding _officer, [], 0, "NONE"];
_officergroup selectLeader _bodyguard2;
_bodyguard2 setSkill 1;
_bodyguard2 disableAI "PATH";

_officergroup setFormation "FILE";
_officergroup setBehaviour "SAFE";
_officergroup setSpeedMode "LIMITED";

_escapePosVehi = [getPos _housePosition, 0, 40, 3, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
_escapevehicle = createVehicle ["I_E_Offroad_01_covered_F", _escapePosVehi, [], 0, "CAN_COLLIDE"];
_escapevehicle lock 3;
_officergroup addVehicle _escapevehicle;
_vehiGroup = [];
_vehiGroup = _vehiGroup + [_escapevehicle];

{_x addCuratorEditableObjects [units _officerGroup, false];} foreach allCurators;
{_x addCuratorEditableObjects [_vehiGroup, false];} foreach allCurators;

//------------Spawn Fake Officer ----------------------------

_fakePos = [getPos _officer, 40, 300, 0, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;

private _officergroupFake1 = createGroup east;

_officerFake1 = _officerGroupFake1 createUnit ["O_Officer_Parade_Veteran_F", nearestBuilding _fakePos, [], 0, "NONE"];
_officerFake1 setSkill 1;
_officerFake1 disableAI "PATH";

_bodyguard1Fake1 = _officergroupFake1 createUnit ["O_V_Soldier_JTAC_hex_F", nearestBuilding _officerFake1, [], 0, "NONE"];
_bodyguard1Fake1 setSkill 1;
_bodyguard1Fake1 disableAI "PATH";

_bodyguard2Fake1 = _officergroupFake1 createUnit ["O_V_Soldier_JTAC_hex_F", nearestBuilding _officerFake1, [], 0, "NONE"];
_officergroupFake1 selectLeader _bodyguard2Fake1;
_bodyguard2Fake1 setSkill 1;
_bodyguard2Fake1 disableAI "PATH";

{_x addCuratorEditableObjects [units _officerGroupFake1, false];} foreach allCurators;


//-------------Set Objective---------------------------------
	sleep 1;
	[west, ["TUERLOFFICIER"], ["Un officier CSAT très important se trouve en ce moment sur l'île. Trouvez-le et abattez-le avant qu'il ne puisse s'enfuir ! Prenez garde, des troupes d'élites l'accompagne !", "Tuer l'officier"],(getMarkerPos "officerHouse"),"Created",0,true,"kill",true] call BIS_fnc_taskCreate;
	ASSASSINATMissionUp = true; publicVariable "ASSASSINATMissionUp";

//------------Spawn Protection Forces------------------------

_protectionGroup = [];

for "_i" from 0 to 3 do {
	_patrolLocation = [getMarkerPos "officerHouse", 0, 80, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_patrolGroup = [_patrolLocation, OPFOR, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_ViperTeam")] call BIS_fnc_spawnGroup;
	_patrolGroup setFormation "COLUMN";
	_patrolGroup setBehaviour "SAFE";
	[_patrolGroup, getMarkerPos "officerHouse", 230] call BIS_fnc_taskPatrol;
	sleep 1;
	{_x addCuratorEditableObjects [units _patrolGroup, false];} forEach allCurators;
	_protectiongroup = _protectiongroup + (units _patrolGroup)
};


//--------------Set Officer Escape + Task State--------------
while { ASSASSINATMissionUp } do {
	
	if ( behaviour _officerFake1 == "COMBAT" ) then {
		_officer setBehaviour "COMBAT";
		_officerFake1 setBehaviour "CARELESS";
	};

	if ( behaviour _officer == "COMBAT" ) then {
		_bodyguard1 enableAI "PATH";
		_bodyguard2 enableAI "PATH";
		_officer enableAI "PATH";
		sleep 3;
		_officer setUnitPos "UP";
		_bodyguard1 setUnitPos "UP";
		_bodyguard2 setUnitPos "UP";
		_officergroup setBehaviour "STEALTH";
		_officergroup setSpeedMode "FULL";
		
		if ( alive _escapevehicle ) then {
			[_officer, _bodyguard1, _bodyguard2] orderGetIn true;
			_officergroup addWaypoint [_fuite, 0]
		};
		if ( !alive _escapevehicle ) then {
			_officergroup addWaypoint [_fuite, 0]
		};
	};
	
	if ( !alive _officer ) then {
	
		ASSASSINATMissionUp = false; publicVariable "ASSASSINATMissionUp";
		["TUERLOFFICIER", "SUCCEEDED"] call BIS_fnc_taskSetState;
		sleep 3;
		["TUERLOFFICIER"] call BIS_fnc_deleteTask;
		"officerHouse" setMarkerPos [-1000,-1000];
		sleep 40;
		{ deleteVehicle _x; sleep 0.1;} forEach units _officergroup;
		{ deleteVehicle _x; sleep 0.1;} forEach _vehiGroup;
	};
			
	if ( _officer distance [5216,6075] < 40 ) then {

		ASSASSINATMissionUp = false; publicVariable "ASSASSINATMissionUp";
		["TUERLOFFICIER", "FAILED"] call BIS_fnc_taskSetState;
		sleep 3;
		["TUERLOFFICIER"] call BIS_fnc_deleteTask;
		"officerHouse" setMarkerPos [-1000,-1000];
		sleep 40;
		{ deleteVehicle _x; sleep 0.1;} forEach units _officergroup;
		{ deleteVehicle _x; sleep 0.1;} forEach _vehiGroup;	
	};
};




