	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2014-2018 Nicolas BOITEUX

	CLASS OO_NODE
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
	*/

	#include "oop.h"

	CLASS("OO_NODE")
		PRIVATE VARIABLE("scalar","parent");
		PRIVATE VARIABLE("scalar","current");
		PRIVATE VARIABLE("array","childrens");
		PRIVATE VARIABLE("array","value");

		PUBLIC FUNCTION("array","constructor") {
			DEBUG(#, "OO_NODE::constructor")
			MEMBER("parent", _this select 0);
			MEMBER("current", _this select 1);
			MEMBER("childrens", []);
			MEMBER("value", []);		
		};

		PUBLIC FUNCTION("","getCurrent") FUNC_GETVAR("current");
		PUBLIC FUNCTION("","getParent") FUNC_GETVAR("parent");
		PUBLIC FUNCTION("","getChildrens") FUNC_GETVAR("childrens");
		PUBLIC FUNCTION("", "getValue") { MEMBER("value", nil); };

		PUBLIC FUNCTION("scalar", "nextChild") {
			DEBUG(#, "OO_NODE::nextChild")
			private _scalar = _this;
			private _return = -1;

			{
				scopename "oo_node_nextchild";
				if(_scalar == _x select 0) then {
					_return = _x select 1;
					breakout "oo_node_nextchild";
				};
				sleep 0.0001;
			}foreach MEMBER("childrens", nil);
			_return;
		};

		PUBLIC FUNCTION("array", "parseChildKeySet") {
			DEBUG(#, "OO_NODE::parseChildKeySet")
			private _key = _this;
			private _localkey = MEMBER("getCurrent", nil);
			private 	_array = [];
			private _string = "";

			if(_localkey > 0) then { _key pushBack _localkey; };

			{
				_array append (["parseChildKeySet", _key] call (_x select 1));
				sleep 0.0001;
			}foreach MEMBER("childrens", nil);

			_value = MEMBER("getValue", nil);
			if(count _value > 0) then {
				_string = tostring _key;
				_array pushBack _string;
			};
			_array;
		};

		PUBLIC FUNCTION("", "parseChildEntrySet") {
			DEBUG(#, "OO_NODE::parseChildEntrySet")
			private _array = [];
			private _value = [];
			{
				_array append ("parseChildEntrySet" call (_x select 1));
				_value = "getValue" call (_x select 1);
				if(count _value > 0) then { _array pushBack _value; };
				sleep 0.0001;
			}foreach MEMBER("childrens", nil);
			_array;
		};

		PUBLIC FUNCTION("", "getChild") {
			DEBUG(#, "OO_NODE::getChild")
			private _return = -1;
			if(count MEMBER("childrens", nil) == 0) then { 
				_return = -1;
			} else {
				_return = (MEMBER("childrens",nil) select 0) select 1;
			};
			_return;
		};

		PUBLIC FUNCTION("scalar", "addChild") {
			DEBUG(#, "OO_NODE::addChild")
			private _scalar = _this;
			private _node = ["new", [MEMBER("current", nil), _scalar]] call OO_NODE;
			MEMBER("childrens", nil) pushBack [_scalar, _node];
			_node;
		};

		PUBLIC FUNCTION("scalar", "removeChild") {
			DEBUG(#, "OO_NODE::removeChild")
			if((MEMBER("childrens", nil) find _this) > -1) then { MEMBER("childrens", nil) deleteAt _index; };
		};

		PUBLIC FUNCTION("array", "setValue") {
			DEBUG(#, "OO_NODE::setValue")
			MEMBER("value", _this);
		};

		PUBLIC FUNCTION("","deconstructor") { 
			DEBUG(#, "OO_NODE::deconstructor")
			DELETE_VARIABLE("childrens");
			DELETE_VARIABLE("current");
			DELETE_VARIABLE("parent");
			DELETE_VARIABLE("value");
		};
	ENDCLASS;