class ZMWeapAttach_TripwireTrap extends ROWeaponAttachmentTrap;

var(Animations) name PlantStake_CH;
var(Animations) name PlantStakeLong_CH;

var bool bPlantedFirstStake;

simulated function PlaySetTrapAnimation(bool bLong)
{
    local ROPawn ROP;
    local float Duration;
    local name AnimToPlay;

    ROP = ROPawn(Instigator);

    if ( ROP == none )
    {
        return;
    }

    if( bPlantedFirstStake )
    {
        AnimToPlay = bLong ? PlantStakeLong_CH : PlantStake_CH;
    }
    else
    {
        AnimToPlay = bLong ? PlantTrapLong_CH : PlantTrap_CH;
    }

    Duration = Mesh.GetAnimLength(AnimToPlay);
    ROP.PlayFullBodyAnimation(AnimToPlay);
    Mesh.PlayAnim(AnimToPlay, Duration,, false);

    // This won't handle cases when we pick up uncompleted traps...
    bPlantedFirstStake = !bPlantedFirstStake;
}

DefaultProperties
{
    WeaponType=ROWT_Binocs
    ThirdPersonHandsAnim=Tripwire_Handpose
    IKProfileName=F1

    CHR_AnimSet=AnimSet'CHR_VN_Playeranim_Master.Weapons.CHR_TripwireTrap'

    // Weapon SkeletalMesh
    Begin Object Name=SkeletalMeshComponent0
        SkeletalMesh=SkeletalMesh'WP_VN_3rd_Master.Mesh.TripwireTrap_3rd_Master'
        AnimSets(0)=AnimSet'WP_VN_3rd_Master.Anim.TripwireTrap_3rd_Anims'
        PhysicsAsset=PhysicsAsset'WP_VN_3rd_Master.Phy_Bounds.TripwireTrap_3rd_Bounds_Physics'
        CullDistance=5000
    End Object

    WeaponClass=class'ZMWeap_TripwireTrap'

    PlantTrap_CH=Plant_01
    PlantStake_CH=Plant_02

    PlantTrapLong_CH=Plant_Long_01
    PlantStakeLong_CH=Plant_Long_02

    // Player animations
    StandToProneAnim=Stand_TO_Prone_tool
    StandToProneMovingAnim=JogF_TO_Prone_tool
    StandToProneSprintAnim=SprintF_TO_Prone_tool
    ProneToStandAnim=Prone_TO_Stand_tool
    ProneToStandMovingAnim=Prone_TO_JogF_tool
    CrouchToProneAnim=Crouch_TO_Prone_tool
    CrouchToProneSprintAnim=CHsprint_TO_Prone_tool
    ProneToCrouchAnim=Prone_TO_Crouch_tool
    StandToCrouchAnim=Hip_TO_CH_Hip_tool
    //StandToCrouchIronsightsAnim=Iron_TO_CHiron_nade
    CrouchToStandAnim=CH_Hip_TO_Hip_tool
    //CrouchToStandIronsightsAnim=CH_Iron_TO_Iron_nade
        // Player animations - PlayThirdPersonWeaponAction()
    HolsterWeaponAnim=Holster_tool
    //Add_HolsterWeaponAnim=ADD_Holster_nade_idle
    //Add_HolsterWeaponIronAnim=ADD_Holster_nade_iron
    EquipWeaponAnim=Pullout_tool
    EquipWeaponIronAnim=Pullout_tool

    HolsterWeaponCrouchedAnim=CH_Holster_tool
    EquipWeaponCrouchedAnim=CH_Pullout_tool

    //MeleeBash1Anim=Bash_nade
    //MeleeBash1Anim_CH=CH_Bash_nade
    //MeleeBashChargeAnim=Sprint_Bash_nade
    //MeleeBashChargeAnim_CH=CHSprint_Bash_nade
    //MeleeStabAnim_Prone=Prone_Bash_nade
}
