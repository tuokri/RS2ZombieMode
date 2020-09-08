class ZMWeap_MD82_Mine_Content extends ZMWeap_MD82_Mine;

DefaultProperties
{
    Begin Object Name=FirstPersonMesh
        DepthPriorityGroup=SDPG_Foreground
        SkeletalMesh=SkeletalMesh'WP_VN_VC_MD82_Mine.Mesh.VC_MD82_Mine'
        PhysicsAsset=PhysicsAsset'WP_VN_VC_MD82_Mine.Phys.VC_MD82_Mine_Physics'
        AnimSets(0)=AnimSet'WP_VN_VC_MD82_Mine.Animation.WP_MD82Hands'
        AnimTreeTemplate=AnimTree'WP_VN_VC_MD82_Mine.Animation.VC_MD82_Mine_Tree'
        Scale=1.0
        FOV=70
    End Object

    Begin Object Name=PickupMesh
        SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.MD82_Mine_3rd_Master'
        PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy.MD82_Mine_3rd_Physics'
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

    AttachmentClass=class'ROGameContent.ROWeapAttach_MD82_Mine'

    ArmsAnimSet=AnimSet'WP_VN_VC_MD82_Mine.Animation.WP_MD82Hands'
}
