class ZMWeapAttach_RDG1_Smoke extends ROWeapAttach_StickGrenade;

DefaultProperties
{
	ThirdPersonHandsAnim=RDG1_HandPose
	IKProfileName=F1

	// Weapon SkeletalMesh
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.RDG_1_3rd_Master'
		PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy_Bounds.RDG_1_3rd_Bounds_Physics'
		CullDistance=5000
	End Object

	WeaponClass=class'ZMWeap_RDG1_Smoke'
}
