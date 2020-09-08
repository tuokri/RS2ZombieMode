class ZMGameInfoTerritories extends ROGameInfoTerritories;

function float GetReducedDamageScale(int Damage,
	Pawn Injured, Controller InstigatedBy, vector HitLocation,
	vector Momentum, class<DamageType> DmgType, Actor DamageCauser)
{
	if (DmgType == class'ZMDmgType_BomberExplosion')
	{
		if (ZMPlayerController(InstigatedBy).GetTeamNum() == Injured.GetTeamNum())
		{
			`zmlog("Reducing ZMDmgType_BomberExplosion damage for: InstigatedBy="
				$ InstigatedBy $ ", Injured=" $ Injured, 'Debug');
			Damage = 0;
		}
	}

	return super.GetReducedDamageScale(Damage, Injured, InstigatedBy,
		HitLocation, Momentum, DmgType, DamageCauser);
}
