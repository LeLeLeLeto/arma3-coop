/**
	Auteur : Léo
	Fait apparaitre des unités ennemies dans les batiment aux alentours
	Retourne : liste des groupes créés
 */

params ["_unites", "_position"];
_resultat = [];

private _garrisongroupamount = 0;
	_batiments = nearestObjects [_position, ["house","building"], 400];

	if (count _batiments > 0) then {
		_groupe = createGroup east;

		_nombre_batiments = 10;
		if ( count _batiments > 100 ) then {
			_nombre_batiments = 30;
		} else {
			// f(x) = -l(x+h)²+v
			// l = v / h²
			// 50% des batiments jusqu'à 20 max à 70
			_nombre_batiments = floor(0 - (0.004) * (count _batiments - 70) ^ 2 + 20);
		};

		// En sélectionnant depuis 0 on priorise les batiments plus proches
		for "_i" from 0 to _nombre_batiments do {
			_positions = (_batiments select _i) buildingPos -1;

			for "_n" from 0 to random ((count _positions / 2) - 1) do {
				_position_unite = selectRandom _positions;
				_positions = _positions - [_position_unite];

				_unite = _groupe createUnit [selectRandom _unites, _position_unite, [], 0, "CAN_COLLIDE"];
				_unite disableAI "PATH";
			};
		};

		_resultat pushBack _groupe;
	};

_resultat