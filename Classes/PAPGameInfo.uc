class PAPGameInfo extends ROGameInfo;

function float GetReducedDamageScale(int Damage,
	Pawn Injured, Controller InstigatedBy, vector HitLocation,
	vector Momentum, class<DamageType> DmgType, Actor DamageCauser)
{
	if (DmgType == class'PAPDmgType_BomberExplosion')
	{
		if (PAPPlayerController(InstigatedBy).GetTeamNum() == Injured.GetTeamNum())
		{
			`paplog("Reducing PAPDmgType_BomberExplosion damage for: InstigatedBy="
				$ InstigatedBy $ ", Injured=" $ Injured, 'Debug');
			Damage = 0;
		}
	}

	return super.GetReducedDamageScale(Damage, Injured, InstigatedBy,
		HitLocation, Momentum, DmgType, DamageCauser);
}
