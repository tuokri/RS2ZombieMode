// Zombie "flamethrower".
class ZMWeap_M9_Flamethrower extends ROWeap_M9_Flamethrower
	abstract;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	MaxAmmoCount=15; // TODO: See if this is necessary.
	AmmoCount=MaxAmmoCount;
}

DefaultProperties
{
	WeaponContentClass.Empty
	WeaponContentClass(0)="ZombieMode.ZMWeap_M9_Flamethrower_Content"

	TeamIndex=`AXIS_TEAM_INDEX
	InvIndex=`ZMII_ZombieFlamethrower

	WeaponProjectiles(0)=class'ZMProjectile_M9Flame'

	MaxAmmoCount=15
	AmmoClass=class'ZMAmmo_15L_M9A1Tank'

	MuzzleFlashPSCTemplate=ParticleSystem'ZM_FX_Z_Flamethrower.Emitters.FX_RS_WEP_Flamer_muzzleflash'

	// InventoryWeight=0
}
