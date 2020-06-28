groups = [];

mode = "NORMAL";
patrolMarkers = ["mP1", "mP2", "mP3", "mP4", "mP5"];
maxGroups = 10;

if (isServer) then
{	
	[] execVM 'mainLoop.sqf';
	[] execVM 'createRedUnits.sqf';

	player addaction ["Reset", "reset.sqf"];
} 
