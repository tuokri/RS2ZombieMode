class ZMWeap_DesertEagle_Pistol_Content extends ZMWeap_DesertEagle_Pistol;


DefaultProperties
{
    //Arms
    ArmsAnimSet=AnimSet'WP_VN_USA_ColtM1911_pistol.Animation.WP_M1911Hands'

    // Weapon SkeletalMesh
    Begin Object Name=FirstPersonMesh
        DepthPriorityGroup=SDPG_Foreground
        SkeletalMesh=SkeletalMesh'ZM_WP_DesertEagle.Mesh.DesertEagle_1st'
        PhysicsAsset=PhysicsAsset'WP_VN_USA_ColtM1911_pistol.Phys.USA_ColtM1911A1_Physics'
        AnimSets(0)=AnimSet'WP_VN_USA_ColtM1911_pistol.Animation.WP_M1911Hands'
        AnimTreeTemplate=AnimTree'WP_VN_USA_ColtM1911_pistol.Animation.USA_ColtM1911_Tree'
        Scale=1.0
        FOV=70
    End Object

    // Pickup staticmesh
    Begin Object Name=PickupMesh
        SkeletalMesh=SkeletalMesh'ZM_WP_DesertEagle.Mesh.DesertEagle_3rd'
        PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy.ColtM1911A1_3rd_Physics'
        CollideActors=true
        BlockActors=true
        BlockZeroExtent=true
        BlockNonZeroExtent=true//false
        BlockRigidBody=true
        bHasPhysicsAssetInstance=false
        bUpdateKinematicBonesFromAnimation=false
        PhysicsWeight=1.99
        RBChannel=RBCC_GameplayPhysics
        RBCollideWithChannels=(Default=TRUE,GameplayPhysics=TRUE,EffectPhysics=TRUE)
        bSkipAllUpdateWhenPhysicsAsleep=TRUE
        bSyncActorLocationToRootRigidBody=true
    End Object

    AttachmentClass=class'ZMWeapAttach_DesertEagle_Pistol'

    // WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_MAS49.Play_WEP_MAS49_Single_3P', FirstPersonCue=AkEvent'WW_WEP_MAS49.Play_WEP_MAS49_Fire_Single')
    WeaponFireSndCustom(DEFAULT_FIREMODE)=SoundCue'ZM_AUD_DesertEagle.SoundCue.DesertEagle_Fire_1P_Cue'
    WeaponFireSndFirstPersonCustom(DEFAULT_FIREMODE)=SoundCue'ZM_AUD_DesertEagle.SoundCue.DesertEagle_Fire_3P_Cue'
}
