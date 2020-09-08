class ZMWeap_TripwireTrap_Content extends ZMWeap_TripwireTrap;

DefaultProperties
{
	Begin Object Name=FirstPersonMesh
		DepthPriorityGroup=SDPG_Foreground
		SkeletalMesh=SkeletalMesh'WP_VN_VC_Tripwire_Trap.Mesh.VC_Tripwire_Trap'
		PhysicsAsset=PhysicsAsset'WP_VN_VC_Tripwire_Trap.Phys.VC_Tripwire_Trap_Physics'
		AnimSets(0)=AnimSet'WP_VN_VC_Tripwire_Trap.Animation.WP_TripwireTraphands'
		AnimTreeTemplate=AnimTree'WP_VN_VC_Tripwire_Trap.Animation.VC_Tripwire_Trap_Tree'
		Scale=1.0
		FOV=70
	End Object

	Begin Object Name=PickupMesh
		SkeletalMesh=none
		PhysicsAsset=none
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

	AttachmentClass=class'ROGameContent.ROWeapAttach_TripwireTrap'

	ArmsAnimSet=AnimSet'WP_VN_VC_Tripwire_Trap.Animation.WP_TripwireTraphands'
}
