class PAPNorthPawn extends PAPPawn;

simulated event byte ScriptGetTeamNum()
{
	return `AXIS_TEAM_INDEX;
}

DefaultProperties
{
	LegInjuryLength=0.1

	bCanPickupInventory=False
	bCanResupply=False
}
