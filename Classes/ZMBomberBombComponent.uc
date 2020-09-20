class ZMBomberBombComponent extends ActorComponent;
/*
var ZMBomberBomb Bomb;

simulated function Detonate(class<ZMBomberBomb> BombClass)
{
	DoChargeStuff();
}

simulated function Projectile SpawnCharge()
{
	local Projectile SpawnedProjectile;

	SpawnedProjectile = Spawn(PlantedChargeClass,,, ChargePlantLoc + SpawnLocOffset, SpawnRotOffset);
	return SpawnedProjectile;

 	return None;
}

simulated function DoChargeStuff()
{
	Bomb = RORemoteExplosiveProjectile(SpawnCharge());
	if (Bomb != None)
	{
		Bomb.SetBase(Base);
		Bomb.bPlantedOnWall = False;
		Bomb.SetReplicationValues(False);
	}
}

DefaultProperties
{
}
*/