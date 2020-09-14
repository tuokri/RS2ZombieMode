class ZMWeapAttach_DesertEagle_Pistol extends ROWeaponAttachmentPistol;

defaultproperties
{
   	ThirdPersonHandsAnim=M1911_Handpose
   	ThirdPersonHandsIronAnim=M1911_Ironsight_Handpose
	IKProfileName=C96

	// Weapon SkeletalMesh
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'ZM_WP_DesertEagle.Mesh.DesertEagle_3rd'
		AnimSets(0)=AnimSet'WP_VN_3rd_Master.Anim.ColtM1911A1_3rd_Anims'
		PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy_Bounds.ColtM1911A1_3rd_Bounds_Physics'
		CullDistance=3000 // 5000
	End Object

	MuzzleFlashSocket=MuzzleFlashSocket
	MuzzleFlashPSCTemplate=ParticleSystem'FX_VN_Weapons.MuzzleFlashes.FX_VN_MuzzleFlash_3rdP_Pistol'
	MuzzleFlashDuration=0.33
	MuzzleFlashLightClass=class'ROGame.RORifleMuzzleFlashLight'
	WeaponClass=class'ZMWeap_DesertEagle_Pistol'

	// Shell eject FX
	ShellEjectSocket=ShellEjectSocket
	ShellEjectPSCTemplate=ParticleSystem'FX_VN_Weapons.ShellEjects.FX_Wep_ShellEject_USA_M1911A1Pistol'

	// ROPawn weapon specific animations
	CHR_AnimSet=AnimSet'CHR_VN_Playeranim_Master.Weapons.CHR_ColtM1911'

	// Firing animations
	FireAnim=Shoot
	FireLastAnim=Shoot_Last
	IdleAnim=Idle
	IdleEmptyAnim=Idle_Empty
}
