
for "_i" from 0 to (maxGroups - 1) do {
  _soldiers = ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_LAT_F","O_medic_F", "O_soldier_M_F"];
  _grp = [getMarkerPos "mSpawn", east, _soldiers] call BIS_fnc_spawnGroup;

  _veh = createVehicle ["O_T_Truck_02_transport_F", getMarkerPos "mSpawn", [], 10, "NONE"];		
  _grp addVehicle _veh;

  {[_x] orderGetIn true} foreach (units _grp);

  _m = patrolMarkers select (_i mod (count patrolMarkers));
  _wp =_grp addWaypoint [getMarkerPos _m, 0];
  _wp setWaypointType "MOVE";
  
  _m = patrolMarkers select ((_i + 1) mod (count patrolMarkers));
  _wp =_grp addWaypoint [getMarkerPos _m, 0];
  _wp setWaypointType "MOVE";

  _m = patrolMarkers select ((_i + 2) mod (count patrolMarkers));
  _wp =_grp addWaypoint [getMarkerPos _m, 0];
  _wp setWaypointType "CYCLE";

  groups = groups + [_grp];

  sleep 60;
};