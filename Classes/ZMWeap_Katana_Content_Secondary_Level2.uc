class ZMWeap_Katana_Content_Secondary_Level2 extends ZMWeap_Katana_Secondary_Level2;

DefaultProperties
{
	ArmsAnimSet=AnimSet'ZM_WP_RS_Jap_Katana.Animation.WP_KatanaHands'

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		DepthPriorityGroup=SDPG_Foreground
		SkeletalMesh=SkeletalMesh'ZM_WP_RS_Jap_Katana.Mesh.JP_Katana_UPGD2'
		Materials(0)=MaterialInstanceConstant'ZM_WP_RS_Jap_Katana.MIC.Katana_lvl2_Mat'
		PhysicsAsset=None
		AnimSets(0)=AnimSet'ZM_WP_RS_Jap_Katana.Animation.WP_KatanaHands'
		Animations=AnimTree'ZM_WP_RS_Jap_Katana.Animation.JP_Katana_Tree'
		Scale=1.0
		FOV=70
	End Object

	// Pickup staticmesh
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'ZM_WP_RS_3rd_Master.Mesh_UPGD.Katana_3rd_Lvl2'
		PhysicsAsset=PhysicsAsset'ZM_WP_RS_3rd_Master.Phy.Katana_3rd_Physics'
		CollideActors=true
		BlockActors=true
		BlockZeroExtent=true
		BlockNonZeroExtent=true//false
		BlockRigidBody=true
		bHasPhysicsAssetInstance=false
		bUpdateKinematicBonesFromAnimation=false
		PhysicsWeight=1.0
		RBChannel=RBCC_GameplayPhysics
		RBCollideWithChannels=(Default=TRUE,GameplayPhysics=TRUE,EffectPhysics=TRUE)
		bSkipAllUpdateWhenPhysicsAsleep=TRUE
		bSyncActorLocationToRootRigidBody=true
	End Object

	AttachmentClass=class'ZombieMode.ZMWeapAttach_Katana_Secondary_Level2'

	WeaponFireSnd[0]=()
	WeaponFireSnd[1]=()
}
