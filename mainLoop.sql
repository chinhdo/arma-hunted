
_markers = [];
_debug = true;

while {true} do {

  _k = 0;
  {
    _k1 = east knowsAbout _x;
    if (_k1 > _k) then {
      _k = _k1;
    };
  } forEach (units group player);

  // hint format ["K=%1 groups=%2", _k, count groups];  

  if (_debug) then
  {
    // Draw markers for groups
    {
      deleteMarker _x;
    } forEach _markers;

    _i = 0;
    {
      _m = createMarker [Format ["mGroup_%1", _i], position ((units _x) select 0)];
      _m setMarkerShape "ELLIPSE";
      _m setMarkerColor "ColorRed";    
      _m setMarkerSize [25, 25];    
      _markers = _markers + [_m];
      _i = _i + 1;
    } forEach groups;
  };

  if (_k > 1) then
  {
    mode = "DESTROY";    
  }
  else
  {
    mode = "NORMAL";
  };

  {
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
        _wp = _x addWaypoint [getPos player, 0];
        _wp setWaypointType "DESTROY";
      }
    }
    else {
      _m = selectRandom patrolMarkers;
      _wp =_x addWaypoint [getMarkerPos _m, 0];
      _wp setWaypointType "MOVE";
    
      _m = selectRandom patrolMarkers;
      _wp =_x addWaypoint [getMarkerPos _m, 0];
      _wp setWaypointType "MOVE";

      _m = selectRandom patrolMarkers;
      _wp =_x addWaypoint [getMarkerPos _m, 0];
      _wp setWaypointType "CYCLE";
    };
  } forEach groups;


  sleep 1;
};