class ZMRoleInfoNorthernInfantry extends RORoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
	if (NP.HealthMax == 100 && NP.Health == 100)
	{
		NP.HealthMax *= 1.1; // 1.35
	    NP.Health *= 1.1; // 1.35
	}
}
