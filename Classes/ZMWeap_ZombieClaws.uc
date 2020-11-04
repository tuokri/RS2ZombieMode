class ZMWeap_ZombieClaws extends ZMWeap_Katana;

DefaultProperties
{
    WeaponContentClass(0)="ZombieMode.ZMWeap_ZombieClaws_Content"
    RoleSelectionImage(0)=Texture2D'ZM_UI_Textures.HUD.Zombie_Claw_UI_256'

    Category=ROIC_Secondary
    InvIndex=`ZMII_ZombieClaws

    //Equip and putdown
    WeaponPutDownAnim=Punji_Putaway
    WeaponEquipAnim=Punji_Pullout
    WeaponDownAnim=Punji_Down
    WeaponUpAnim=Punji_Up

    // Idle Anim
    //Hip Idle
    WeaponIdleAnims(0)=Idle
    // Shouldered idle
    WeaponIdleShoulderedAnims(0)=Idle

    // Prone Crawl
    WeaponCrawlingAnims(0)=Katana_CrawlF
    WeaponCrawlStartAnim=Katana_Crawl_into
    WeaponCrawlEndAnim=Katana_Crawl_out

    // Sprinting
    WeaponSprintStartAnim=RunIni
    WeaponSprintLoopAnim=RunLoop
    WeaponSprintEndAnim=RunEnd

    // Mantling
    WeaponMantleOverAnim=Vault

    // Cover/Blind Fire Anims
    WeaponRestAnim=Idle
    WeaponEquipRestAnim=Punji_Pullout
    WeaponPutDownRestAnim=Punji_Putaway
    // WeaponIdleToRestAnim=Katana_idleTOrest
    // WeaponRestToIdleAnim=Katana_restTOidle

    // Swing anims
    WeaponSwingAnims(0)=LightMelee
    WeaponSwingHardAnim=ChargeEnd
    SwingPullbackAnims(0)=ChargeIni
    SwingHoldAnims(0)=ChargeLoop

    // Stab anims
    WeaponMeleeAnims(0)=LightMelee
    WeaponMeleeHardAnim=ChargeEnd
    MeleePullbackAnim=ChargeIni
    MeleeHoldAnim=ChargeLoop

    // Block anims
    WeaponBlockStartAnim=Katana_Block_into
    WeaponBlockLoopAnim=Katana_BlockHOLD
    WeaponBlockEndAnim=Katana_Block_out
    WeaponBlockDeflectAnim=Katana_Deflect

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
}
