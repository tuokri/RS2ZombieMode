class ZMWeap_ZombieClaws_Content extends ZMWeap_ZombieClaws;

DefaultProperties
{
    AttachmentClass=class'ZMWeapAttach_ZombieClaws'
    ArmsAnimSet=AnimSet'ZM_Zombie_Melee_Anims.Anim.Zombie_Melee_AnimSet'

    Begin Object Name=FirstPersonMesh
          DepthPriorityGroup=SDPG_Foreground
          SkeletalMesh=SkeletalMesh'ZM_Zombie_Melee_Anims.Mesh.ZombieHands'
          Materials(0)=Material'M_VN_Common_Characters.Materials.M_Hair_NoTransp'
          Materials(1)=Material'M_VN_Common_Characters.Materials.M_Hair_NoTransp'
          // PhysicsAsset=None
          AnimSets(0)=AnimSet'ZM_Zombie_Melee_Anims.Anim.Zombie_Melee_AnimSet'
          Animations=AnimTree'ZM_WP_RS_Jap_Katana.Animation.JP_Katana_Tree'
          Scale=1.0
          FOV=70
    End Object

    // PickupMesh=None
}
