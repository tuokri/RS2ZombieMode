class ZMRoleInfoNorthernInfantry extends RORoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
	if (NP.HealthMax == 100 && NP.Health == 100)
	{
		NP.HealthMax *= 1.20; // 1.15
	    NP.Health *= 1.20; // 1.15
	}
}
