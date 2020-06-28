// Set vehicle groups to patrol between random markers
// _vehTypes = ["O_MBT_02_cannon_F", "O_T_Truck_02_transport_F", "O_MRAP_02_F"];
_vehTypes = ["O_T_Truck_02_transport_F", "O_MRAP_02_F"];
for "_i" from 0 to (maxGroups - 1) do {    
  _soldiers = ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F"];

  _vehType = selectRandom _vehTypes;
  if (_vehType == "O_T_Truck_02_transport_F") then {
    _soldiers = ["O_Soldier_SL_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_Soldier_F", "O_Soldier_F", "O_Soldier_F", "O_Soldier_F", "O_Soldier_LAT_F", "O_medic_F", "O_soldier_M_F"];
  };

    if (["_cannon_", _vehType] call BIS_fnc_inString ) then {
    _soldiers = ["O_T_Crew_F", "O_T_Crew_F", "O_T_Crew_F"];
  };

  _pos = (getMarkerPos "mSpawn") getpos [_i * 25, 128];  
  _grp = [_pos, east, _soldiers] call BIS_fnc_spawnGroup;
 
  _pos = (getMarkerPos "mSpawn") getpos [_i * 25 + 10, 128];  
  _veh = createVehicle [_vehType, _pos, [], 0, "NONE"];
  _veh setDir 210;
  _grp addVehicle _veh;

  {[_x] orderGetIn true} foreach (units _grp);

  sleep 1;

  groups = groups + [_grp];
};

// TODO nearRoads