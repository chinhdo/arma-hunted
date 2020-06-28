  {
    hint "delete current waypoint";
    while {(count (waypoints _x)) > 0} do {
      deleteWaypoint ((waypoints _x) select 0);
    };

  } forEach groups;