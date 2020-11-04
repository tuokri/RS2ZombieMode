class ZMWeap_M9_Flamethrower_Content extends ZMWeap_M9_Flamethrower;

DefaultProperties
{
	// Arms
	ArmsAnimSet=AnimSet'WP_VN_USA_M9_Flamethrower.Animation.WP_M9_Hands'

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		DepthPriorityGroup=SDPG_Foreground
		SkeletalMesh=SkeletalMesh'WP_VN_USA_M9_Flamethrower.Mesh.USA_M9_Flamethrower'
		PhysicsAsset=PhysicsAsset'WP_VN_USA_M9_Flamethrower.Phys.USA_M9_Flamethrower_Physics'
		AnimSets(0)=AnimSet'WP_VN_USA_M9_Flamethrower.Animation.WP_M9_Hands'
		AnimTreeTemplate=AnimTree'WP_VN_USA_M9_Flamethrower.Animation.USA_M9_AnimTree'
		Scale=1.0
		FOV=70
	End Object

	// Pickup staticmesh
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.M9_Flamethrower_3rd_Master'
		PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy.M9_3rd_Master_Physics'
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

	AttachmentClass=class'ZombieMode.ZMWeapAttach_M9_Flamethrower'

	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_Flamethrower.Play_WEP_Flamethrower_Start_3P', FirstPersonCue=AkEvent'WW_WEP_Flamethrower.Play_WEP_Flamethrower_Start')

	bLoopingFireSnd(DEFAULT_FIREMODE)=true
	WeaponFireLoopEndSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_Flamethrower.Play_WEP_Flamethrower_End_3P', FirstPersonCue=AkEvent'WW_WEP_Flamethrower.Play_WEP_Flamethrower_End')
	bLoopHighROFSounds(DEFAULT_FIREMODE)=true
}
