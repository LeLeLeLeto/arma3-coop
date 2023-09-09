/**
	Auteur : Léo
	Fait apparaitre des unités ennemies dans les batiment aux alentours
	Retourne : liste des groupes créés
 */

params ["_unites", "_position"];
_resultat = [];

private _garrisongroupamount = 0;
	_batiments = nearestObjects [_position, ["house","building"], 500];

	if (count _batiments > 0) then {
		{
			_groupe = createGroup east;
			
			// TODO : chance d'apparition f(x) = 100 - 100/500 . x
			// (100% à 0m > 0% à 500m)
			_distance_batiment = _x distance _position;
			_chance_apparition = 100 - 100 / 500 * _distance_batiment;

			if (_chance_apparition > random(100)) then {
				_positions = _x buildingPos -1;
				for "_i" from 1 to count _positions do {
					_position_unite = selectRandom _positions;
					_positions = _positions - [_position_unite];

					_unite = _groupe createUnit [selectRandom _unites, _position_unite, [], 0, "CAN_COLLIDE"];
					_unite disableAI "PATH";
				};
			};

			_resultat pushBack _groupe;
		} forEach _batiments;
	};

_resultat