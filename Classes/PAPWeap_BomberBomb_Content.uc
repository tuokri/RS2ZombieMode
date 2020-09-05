class PAPWeap_BomberBomb_Content extends PAPWeap_BomberBomb;

DefaultProperties
{
    Begin Object Name=FirstPersonMesh
        DepthPriorityGroup=SDPG_Foreground
        SkeletalMesh=SkeletalMesh'WP_VN_USA_C4.Mesh.US_C4'
        PhysicsAsset=PhysicsAsset'WP_VN_USA_C4.Phys.US_C4_Physics'
        AnimSets(0)=AnimSet'WP_VN_USA_C4.Animation.WP_C4hands'
        AnimTreeTemplate=AnimTree'WP_VN_USA_C4.Animation.C4_Tree'
        Scale=1.0
        FOV=70
    End Object

    /*
    Begin Object Name=PickupMesh
        SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.C4_3rd_Master'
        PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy.C4_3rd_Master_Physics'
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
    */

    AttachmentClass=class'ROGameContent.ROWeapAttach_C4_Explosive'

    ArmsAnimSet=AnimSet'WP_VN_USA_C4.Animation.WP_C4hands'
}
