class ZMWeapAttach_DesertEagle_Gold_Pistol extends ZMWeapAttach_DesertEagle_Pistol;

DefaultProperties
{
	// Weapon SkeletalMesh
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'ZM_WP_DesertEagle.Mesh.DesertEagle_3rd'
		AnimSets(0)=AnimSet'WP_VN_3rd_Master.Anim.ColtM1911A1_3rd_Anims'
		Materials(2)=MaterialInstanceConstant'ZM_WP_DesertEagle.MIC.M_DesertEagle_Upper_Gold_INST'
		Materials(3)=MaterialInstanceConstant'ZM_WP_DesertEagle.MIC.M_DesertEagle_Lower_Gold_INST'
		PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy_Bounds.ColtM1911A1_3rd_Bounds_Physics'
		CullDistance=3000 // 5000
	End Object
}
