class ZMWeapAttach_ZombieClaws extends ROWeapAttach_PunjiTrap;

simulated function PlaySetTrapAnimation(bool bLong)
{
    /*
    local ROPawn ROP;

    ROP = ROPawn(Instigator);

    if ( ROP == none )
    {
        return;
    }

    if( ROP.bIsProning )
    {
        ROP.PlayFullBodyAnimation(PlantTrap_Prone);
    }
    else
    {
        ROP.PlayFullBodyAnimation(PlantTrap_CH);
    }

    // Only have the one weapon anim
    PlayAnimationByRate(PlantTrap_CH, 1.f);
    */
}

DefaultProperties
{
    WeaponType=ROWT_Binocs
    ThirdPersonHandsAnim=MD82_Mine_Handpose
    IKProfileName=F1

    CHR_AnimSet=AnimSet'CHR_VN_Playeranim_Master.Weapons.CHR_PunjiTrap'

    // Weapon SkeletalMesh
    Begin Object Name=SkeletalMeshComponent0
        SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.PunjiShovel_3rd_Master'
        AnimSets(0)=AnimSet'WP_VN_3rd_Master.Anim.PunjiTrap_3rd_Anims'
        Materials(0)=Material'M_VN_Common_Characters.Materials.M_Hair_NoTransp'
        Materials(1)=Material'M_VN_Common_Characters.Materials.M_Hair_NoTransp'
        PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy_Bounds.PunjiShovel_3rd_Bounds_Physics'
        CullDistance=5000
    End Object

    WeaponClass=class'ZMWeap_ZombieClaws'

    MeleeBash1Anim=Bash_tool
    MeleeBash1Anim_CH=CH_Bash_tool
    MeleeBashChargeAnim=BashHard_tool
    MeleeBashChargeAnim_CH=CH_BashHard_tool
    MeleeStabAnim_Prone=Prone_bash_tool

    // Player animations - PlayThirdPersonWeaponAction()
    HolsterWeaponAnim=Holster_tool
    //Add_HolsterWeaponAnim=ADD_Holster_nade_idle
    //Add_HolsterWeaponIronAnim=ADD_Holster_nade_iron
    EquipWeaponAnim=Pullout_tool
    EquipWeaponIronAnim=Pullout_tool

    HolsterWeaponCrouchedAnim=CH_Holster_tool
    EquipWeaponCrouchedAnim=CH_Pullout_tool
}
