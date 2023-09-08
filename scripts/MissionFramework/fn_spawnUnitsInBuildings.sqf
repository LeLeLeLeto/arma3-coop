/**
	Auteur : Léo
	Fait apparaitre des unités ennemies dans les batiment aux alentours
	Retourne : liste des groupes créés
 */

params ["_unites", "_position", "_faction"];
groupes = [];

batiments = nearestObjects [_position, ["house", "building"], 400];
if (count batiments > 0) then {
	// 6 ln x
	for "i" from 0 to 6 * ln count batiments do {
		// Evite de choisir 2 fois le même batiment
		batiment = selectRandom batiments;
		batiments = batiments - [batiment];

		// 1 groupe par batiment
		groupe = createGroup east;

		// Ajout des unités
		positions_batiment = batiment buildingPos -1;
		for "n" from 0 to floor(random count positions_batiments) do {
			position_batiment = selectRandom positions_batiment;

			positions_batiments = positions_batiments - [position_batiment];

			unite = groupe createUnit [
				selectRandom _unites,
				position_batiment, [], 0,
				"CAN_COLLIDE"];

			unite disableAI "PATH";
		};

		groupes pushBack groupe;
	};
};

groupes