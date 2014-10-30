	call compilefinal preprocessFileLineNumbers "oo_tree.sqf";
	call compilefinal preprocessFileLineNumbers "oo_node.sqf";

	_tree = ["new", []] call OO_TREE;
	["put", ["toto", "super la super clef"]] call _tree;
	["put", ["tota", "la moto de dudu le berlu"]] call _tree;
	["put", ["la", "yea roger roger!!!!"]] call _tree;
	["put", ["toto", "super la super clef 2"]] call _tree;
	




