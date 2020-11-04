class ZMWeap_RDG1_Smoke_Content extends ZMWeap_RDG1_Smoke;

DefaultProperties
{
	Begin Object Name=FirstPersonMesh
		DepthPriorityGroup=SDPG_Foreground
		SkeletalMesh=SkeletalMesh'WP_VN_VC_RDG_1.Mesh.Sov_RDG_1'
		PhysicsAsset=PhysicsAsset'WP_VN_VC_RDG_1.Phys.Sov_RDG_1_Physics'
		AnimSets(0)=AnimSet'WP_VN_VC_RDG_1.Animation.WP_RDG_1Hands'
		AnimTreeTemplate=AnimTree'WP_VN_VC_RDG_1.Animation.VC_RDG_1_Tree'
		Scale=1.0
		FOV=70
	End Object

	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.RDG_1_3rd_Master'
		PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy.RDG_1_3rd_Master_Physics'
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

	AttachmentClass=class'ZombieMode.ZMWeapAttach_RDG1_Smoke'

	ArmsAnimSet=AnimSet'WP_VN_VC_RDG_1.Animation.WP_RDG_1Hands'
}
