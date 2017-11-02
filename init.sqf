	call compile preprocessFileLineNumbers "oo_tree.sqf";
	call compile preprocessFileLineNumbers "oo_node.sqf";

	sleep 1;

	private _tree = ["new", []] call OO_TREE;
	["put", ["toto", "super la"]] call _tree;
	["put", ["toti", "super la super clef"]] call _tree;
	["put", ["jota", "la moto de dudu le berlu"]] call _tree;
	["put", ["la", "yea roger roger!!!!"]] call _tree;
	["put", ["tota", "super la super clef 2"]] call _tree;

	hintc format ["%1 %2 %3", ["get", "toto"] call _tree, ["get", "tota"] call _tree, ["get", "jota"] call _tree];
