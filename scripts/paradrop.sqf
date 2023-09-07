/**
	paradrop = host1 addAction ["Halo", "scripts\paradrop.sqf", [(true,false),2500], 6, true, true, "","alive _target"];
*/

_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_params = _this select 3;
_typehalo = _params select 0;//true for all group, false for player only.
_althalo = _params select 1;//altitude of halo jump
_altchute = _params select 2;//altitude for autochute deployment

_uid = getPlayerUId _host;


if (not alive _host) exitwith {
hint "Parachutage non disponible."; 
_host removeaction _id;
};

private ["_pos"];
	_caller groupchat "Cliquez sur la carte pour sauter en parachute";

	openMap true;
	mapclick = false;

	onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

	waituntil {mapclick or !(visiblemap)};
	
	if (!visibleMap) exitwith {
		_caller groupchat "Saut annulé";
	};
	_pos = clickpos;

	if (_typehalo) then {
		_grp1 = group _caller;
		{
			_x setpos [_pos select 0, _pos select 1, _althalo];
			_x spawn bis_fnc_halo;
		} foreach units _grp1;
	} else {
		_caller setpos [_pos select 0, _pos select 1, _althalo];
		_caller spawn bis_fnc_halo;
	};

if (getpos _caller select 2 > (_altchute + 100)) then {
sleep 1;

[_caller] spawn bis_fnc_halo;

openMap false;

_bis_fnc_halo_action = _caller addaction ["<t color='#ff0000'>Ouvrir le parachute</t>","A3\functions_f\misc\fn_HALO.sqf",[],1,true,true,"Eject"];

hint "Bonne chance !";

waituntil {(position _caller select 2) <= _altchute};

_caller removeaction _bis_fnc_halo_action;

if ((vehicle _caller) iskindof "ParachuteBase") exitwith {};

hint "Ouverture du parachute";

[_caller] spawn bis_fnc_halo;

waituntil {(position _caller select 2) < 1};

_caller action ["Eject", vehicle _caller];
_caller switchmove "adthppnemstpsraswrfldnon_1";
_caller setvelocity [0,0,0];
_caller allowdamage true;
};
