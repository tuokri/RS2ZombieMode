class PAPNorthPawn extends PAPPawn;

simulated event byte ScriptGetTeamNum()
{
	return `AXIS_TEAM_INDEX;
}

DefaultProperties
{
	LegInjuryLength=0.1
	BleedTimerRate=5.0

	bCanPickupInventory=False
	bCanResupply=False
}
