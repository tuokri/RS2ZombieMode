class ZMWeapAttach_BomberBomb extends ROWeapAttachRemoteExplosive;

DefaultProperties
{
	ThirdPersonHandsAnim=C4_HandPose
	IKProfileName=F1

	// Weapon SkeletalMesh
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.C4_3rd_Master'
		AnimSets(0)=AnimSet'WP_VN_3rd_Master.Anim.C4_3rd_Anim'
		PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy_Bounds.C4_3rd_Bounds_Physics'
		CullDistance=5000
	End Object

	CHR_AnimSet=AnimSet'CHR_VN_Playeranim_Master.Weapons.CHR_C4'

	PlantChargeGround_CH=CH_Plant
	PlantChargeGround_Prone=Prone_Plant
	PlantChargeWall_CH=CH_WallPlant
	PlantChargeWall_Prone=Prone_WallPlant
	PlantChargeWall=WallPlant


	WeaponClass=class'ZombieMode.ZMWeap_BomberBomb'

	ChargeBoneName=C4_3rd
	DetonatorBoneName=Claymore_Detonator
}
