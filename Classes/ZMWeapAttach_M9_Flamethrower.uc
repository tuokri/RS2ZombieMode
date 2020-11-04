class ZMWeapAttach_M9_Flamethrower extends ROWeaponAttachment;

simulated function CauseMuzzleFlash()
{
	// Make the player animate even if they aren't seen on the client so the
	// flame muzzle flash will be pointing in the right direction
	if( WorldInfo.NetMode != NM_DedicatedServer && OwnerMesh != none )
	{
		OwnerMesh.AnimatingIntoView(5.0f);
	}
	super.CauseMuzzleFlash();
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{
	UpdateTracers(HitLocation);

	if ( EffectIsRelevant(Location, false, ImpactInfoClass.default.MaxFireEffectDistance, 10000) )
	{
		// Light it up
		CauseMuzzleFlash();
	}

	if (FireAnim != '')
	{
		Mesh.PlayAnim(FireAnim,,, false);
	}
}

defaultproperties
{
	TriggerHoldDuration=0.2

	CarrySocketName=WeaponSling
	ThirdPersonHandsAnim=M9_Flamethrower_Handpose
	IKProfileName=mp40

	// Weapon SkeletalMesh
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.M9_Flamethrower_3rd_Master'
		AnimSets(0)=AnimSet'WP_VN_3rd_Master.Anim.M9_Flamethrower_3rd_Anims'
		PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy_Bounds.M9_Flamethrower_3rd_Bounds_Physics'
		CullDistance=5000
	End Object

	MuzzleFlashSocket=MuzzleFlashSocket
	MuzzleFlashPSCTemplate=ParticleSystem'ZM_FX_Z_Flamethrower.Emitters.FX_RS_WEP_Flamer_muzzleflash_3p'
	MuzzleFlashDuration=0.33
	MuzzleFlashLightClass=class'ROFlamethrowerMuzzleFlashLight'
	bMuzzleFlashPSCLoops=true
	WeaponClass=class'ZMWeap_M9_Flamethrower'

	ShellEjectSocket=None

	// ROPawn weapon specific animations
	CHR_AnimSet=AnimSet'CHR_VN_Playeranim_Master.Weapons.CHR_M3'

	// Firing animations
	FireAnim=Shoot
	FireLastAnim=Shoot_Last
	IdleAnim=Idle
	IdleEmptyAnim=Idle_Empty

	bHasFieldgearAttachment=TRUE
}
