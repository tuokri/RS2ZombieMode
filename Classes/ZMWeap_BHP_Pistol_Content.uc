class ZMWeap_BHP_Pistol_Content extends ZMWeap_BHP_Pistol;

DefaultProperties
{
	//Arms
	ArmsAnimSet=AnimSet'WP_VN_AUS_BrowningHP_Pistol.Animation.WP_Browning_HPhands'

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		DepthPriorityGroup=SDPG_Foreground
		SkeletalMesh=SkeletalMesh'WP_VN_AUS_BrowningHP_Pistol.Mesh.AUS_Browning_HP'
		PhysicsAsset=PhysicsAsset'WP_VN_AUS_BrowningHP_Pistol.Phys.AUS_Browning_HP_Physics'
		AnimSets(0)=AnimSet'WP_VN_AUS_BrowningHP_Pistol.Animation.WP_Browning_HPhands'
		AnimTreeTemplate=AnimTree'WP_VN_AUS_BrowningHP_Pistol.Animation.WP_BrowningHP_Tree'
		Scale=1.0
		FOV=70
	End Object

	// Pickup staticmesh
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_VN_AUS_3rd_Master.Mesh.Browning_HP_3rd_Master'
		PhysicsAsset=PhysicsAsset'WP_VN_AUS_3rd_Master.Phy.Browning_HP_3rd_Physics'
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

	AttachmentClass=class'ROGameContent.ROWeapAttach_BHP_Pistol'

	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_BHP.Play_WEP_BHP_Fire_Single_3P', FirstPersonCue=AkEvent'WW_WEP_BHP.Play_WEP_BHP_Fire_Single')
}
