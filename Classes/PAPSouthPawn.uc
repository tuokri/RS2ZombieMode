class PAPSouthPawn extends PAPPawn;

simulated event byte ScriptGetTeamNum()
{
	return `ALLIES_TEAM_INDEX;
}
