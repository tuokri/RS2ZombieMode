class ZMWeap_ZombieClaws_Content extends ZMWeap_ZombieClaws;

DefaultProperties
{
    AttachmentClass=class'ZombieMode.ZMWeapAttach_ZombieClaws'
    ArmsAnimSet=AnimSet'ZM_Zombie_Melee_Anims.Zombie_Melee_AnimSet'

    Begin Object Name=FirstPersonMesh
          DepthPriorityGroup=SDPG_Foreground
          SkeletalMesh=None
          Materials(0)=None
          PhysicsAsset=None
          AnimSets(0)=AnimSet'ZM_Zombie_Melee_Anims.Zombie_Melee_AnimSet'
          Animations=AnimTree'ZM_WP_RS_Jap_Katana.Animation.JP_Katana_Tree'
          Scale=1.0
          FOV=70
    End Object

    // PickupMesh=None
}
