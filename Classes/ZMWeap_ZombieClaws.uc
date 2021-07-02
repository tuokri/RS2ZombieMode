class ZMWeap_ZombieClaws extends ZMWeap_Katana;

DefaultProperties
{
    WeaponContentClass(0)="ZombieMode.ZMWeap_ZombieClaws_Content"
    RoleSelectionImage(0)=Texture2D'ZM_UI_Textures.HUD.Zombie_Claw_UI_256'

    Category=ROIC_Secondary
    InvIndex=`ZMII_ZombieClaws

    PlayerViewOffset=(X=-2,Y=4,Z=-2)
    ZoomInRotation=(Pitch=0,Yaw=0,Roll=0)
    ShoulderedPosition=(X=-2,Y=4,Z=-2)
    ShoulderRotation=(Pitch=0,Yaw=0,Roll=0)
    IronSightPosition=(X=-2,Y=4,Z=-2)

    // Rot range = [0,65536]

    //Equip and putdown
    WeaponPutDownAnim=Idle
    WeaponEquipAnim=Idle
    WeaponDownAnim=Idle
    WeaponUpAnim=Idle

    // Idle Anim
    //Hip Idle
    WeaponIdleAnims(0)=Idle
    WeaponIdleAnims(1)=Idle
    // Shouldered idle
    WeaponIdleShoulderedAnims(0)=Idle
    WeaponIdleShoulderedAnims(1)=Idle

    // Prone Crawl
    WeaponCrawlingAnims(0)=RunLoop
    WeaponCrawlStartAnim=RunIni
    WeaponCrawlEndAnim=RunEnd

    // Sprinting
    WeaponSprintStartAnim=RunIni
    WeaponSprintLoopAnim=RunLoop
    WeaponSprintEndAnim=RunEnd

    // Mantling
    WeaponMantleOverAnim=Vault

    // Cover/Blind Fire Anims
    WeaponRestAnim=Idle
    WeaponEquipRestAnim=Idle
    WeaponPutDownRestAnim=Idle
    WeaponIdleToRestAnim=Idle
    WeaponRestToIdleAnim=Idle

    // Swing anims
    WeaponSwingAnims(0)=LightMelee
    WeaponSwingAnims(1)=LightMelee
    WeaponSwingHardAnim=ChargeEnd
    SwingPullbackAnims(0)=ChargeIni
    SwingPullbackAnims(1)=ChargeIni
    SwingHoldAnims(0)=ChargeLoop
    SwingHoldAnims(1)=ChargeLoop

    // Stab anims
    WeaponMeleeAnims(0)=LightMelee
    WeaponMeleeAnims(1)=LightMelee
    WeaponMeleeHardAnim=ChargeEnd
    MeleePullbackAnim=ChargeIni
    MeleeHoldAnim=ChargeLoop

    // // Block anims
    // WeaponBlockStartAnim=Katana_Block_into
    // WeaponBlockLoopAnim=Katana_BlockHOLD
    // WeaponBlockEndAnim=Katana_Block_out
    // WeaponBlockDeflectAnim=Katana_Deflect

    // MAIN FIREMODE
    InstantHitDamageTypes(0)=class'ZMDmgType_Katana'

    // MELEE FIREMODE
    InstantHitDamageTypes(MELEE_ATTACK_FIREMODE)=class'ZMDmgType_KatanaStab'

    // DISMEMBERMENT DAMAGE
    DismemberDamageType=class'ZMDmgType_KatanaChop'

    SwingAttackSound=AkEvent'WW_WEP_Shared.Play_WEP_Melee_Katana_Swing'
    SwingHardAttackSound=AkEvent'WW_WEP_Shared.Play_WEP_Melee_Katana_Swing'
    SwingImpactSound=AkEvent'WW_WEP_Shared.Play_WEP_Melee_Bayonet_Hard'
    SwingAttackHitFleshSound=AkEvent'WW_WEP_Shared.Play_WEP_Melee_Bayonet_Flesh'
    MeleeAttackSound=AkEvent'WW_WEP_Shared.Play_WEP_Melee_Rifle_Swing'
    MeleeImpactSound=AkEvent'WW_WEP_Shared.Play_WEP_Melee_Bayonet_Hard'
    MeleeAttackHitFleshSound=AkEvent'WW_WEP_Shared.Play_WEP_Melee_Rifle_Impact'

    bCanThrow=false
}
