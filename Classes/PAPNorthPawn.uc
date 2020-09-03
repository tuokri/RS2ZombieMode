class PAPNorthPawn extends PAPPawn;

simulated event byte ScriptGetTeamNum()
{
	return `AXIS_TEAM_INDEX;
}
