
_markers = [];
_debug = true;

while {true} do {

  // Get knowledge
  _k = 0;
  {
    _k1 = east knowsAbout _x;
    if (_k1 > _k) then {
      _k = _k1;
    };
  } forEach (units group player);

  if (_k > 1) then { mode = "DESTROY"; } else { mode = "NORMAL"; };

  if (_debug) then
  {
    // Draw markers for groups
    {
      deleteMarker _x;
    } forEach _markers;

    _i = 0;
    {
      if (side _x == opfor) then
      { 
        if ( ({alive _x} count units _x) > 0 ) then
        {
          _m = createMarker [Format ["mGroup_%1", _i], position ((units _x) select 0)];
          _m setMarkerShape "ELLIPSE";
          _m setMarkerColor "ColorBlue";
          _m setMarkerAlpha 0.50;
          _m setMarkerSize [15, 15];    
          _markers = _markers + [_m];
        };

        _i = _i + 1;
      }
    } forEach allGroups;
  };

  {
    // Make sure all soldiers are in vehicle
    _allIn = true;
    {
      _isInVehicle = vehicle _x != _x;
      if (! _isInVehicle) then {
        _allIn = false;
      }
    } forEach (units _x);

    if (_allIn) then {

      if (mode == "DESTROY") then {
        // Go to player
        if ((count (waypoints _x)) > 1) then {
          hint "Set waypoint to player";
          // Group is patrolling - switch to destroy
          hint "delete current waypoint";
          while {(count (waypoints _x)) > 0} do {
            deleteWaypoint ((waypoints _x) select 0);
          };

          hint "set new waypoint";
          _wp = _x addWaypoint [getPos player, 0]; // TODO randomize
          _wp setWaypointType "DESTROY";
        }
      }
      else {
        if ((count (waypoints _x)) < 3) then {        
          _shuffled = patrolMarkers call BIS_fnc_arrayShuffle;

          _wp =_x addWaypoint [getMarkerPos (_shuffled select 0), 0];
          _wp setWaypointType "MOVE";
        
          _wp =_x addWaypoint [getMarkerPos (_shuffled select 1), 0];
          _wp setWaypointType "MOVE";

          _wp =_x addWaypoint [getMarkerPos (_shuffled select 2), 0];
          _wp setWaypointType "CYCLE";
        }
      };

    };
  } forEach groups;

  hint format ["mode=%1 k=%2", mode, _k];

  sleep 1;
};