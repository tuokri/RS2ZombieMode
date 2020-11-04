class ZMWeap_RDG1_Smoke extends ROStielGrenadeWeapon;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    MaxAmmoCount=5; // TODO: See if this is necessary.
    AmmoCount=MaxAmmoCount;

    /*
    `zmlog("ZMWeap_RDG1_Smoke.PostBeginPlay():", 'Debug');
    `zmlog("#    MaxAmmoCount = " $ MaxAmmoCount, 'Debug');
    `zmlog("#    AmmoCount    = " $ AmmoCount, 'Debug');
    */
}

defaultproperties
{
    WeaponContentClass(0)="ROGameContent.ROWeap_RDG1_Smoke_Content"

    WeaponClassType=ROWCT_SmokeGrenade
    TeamIndex=`AXIS_TEAM_INDEX

    RoleSelectionImage(0)=Texture2D'VN_UI_Textures.WeaponTex.VN_Weap_RDG1_Smoke'

    InvIndex=`ROII_RDG1_SmokeGrenade
    Category=ROIC_SmokeGrenade// ROIC_Grenade
    InventoryWeight=1

    PlayerViewOffset=(X=5,Y=4.5,Z=-1.25)
    ShoulderedPosition=(X=3,Y=3.5,Z=-0.5)
    //ShoulderRotation=(Pitch=-300,Yaw=500,Roll=1500)

    // Anims
    WeaponPullPinAnim=RDG_1_pullpin
    WeaponPutDownAnim=RDG_1_Putaway
    WeaponEquipAnim=RDG_1_Pullout
    WeaponDownAnim=RDG_1_Down
    WeaponUpAnim=RDG_1_Up

    // Prone Crawl
    WeaponCrawlingAnims(0)=RDG_1_CrawlF
    WeaponCrawlStartAnim=RDG_1_Crawl_into
    WeaponCrawlEndAnim=RDG_1_Crawl_out

    // Sprinting
    WeaponSprintStartAnim=RDG_1_sprint_into
    WeaponSprintLoopAnim=RDG_1_Sprint
    WeaponSprintEndAnim=RDG_1_sprint_out

    // Mantling
    WeaponMantleOverAnim=RDG_1_Mantle

    // Cover/Blind Fire Anims
    WeaponBF_LeftPullpin=RDG_1_L_Pullpin
    WeaponBF_RightPullpin=RDG_1_R_Pullpin
    WeaponBF_UpPullpin=RDG_1_Up_Pullpin
    // Blind Fire ready
    WeaponBF_Rest2LeftReady=RDG_1_idleTO_L_ready
    WeaponBF_Rest2RightReady=RDG_1_idleTO_R_ready
    WeaponBF_Rest2UpReady=RDG_1_idleTO_Up_ready
    WeaponBF_LeftReady2Rest=RDG_1_L_readyTOidle
    WeaponBF_RightReady2Rest=RDG_1_R_readyTOidle
    WeaponBF_UpReady2Rest=RDG_1_Up_readyTOidle
    WeaponBF_LeftReady2Up=RDG_1_L_ready_toUp_ready
    WeaponBF_LeftReady2Right=RDG_1_Up_ready_toL_ready
    WeaponBF_UpReady2Left=RDG_1_Up_ready_toL_ready
    WeaponBF_UpReady2Right=RDG_1_Up_ready_toR_ready
    WeaponBF_RightReady2Up=RDG_1_R_ready_toUp_ready
    WeaponBF_RightReady2Left=RDG_1_R_ready_toL_ready
    WeaponBF_LeftReady2Idle=RDG_1_L_readyTOidle
    WeaponBF_RightReady2Idle=RDG_1_R_readyTOidle
    WeaponBF_UpReady2Idle=RDG_1_Up_readyTOidle
    WeaponBF_Idle2UpReady=RDG_1_idleTO_Up_ready
    WeaponBF_Idle2LeftReady=RDG_1_idleTO_L_ready
    WeaponBF_Idle2RightReady=RDG_1_idleTO_R_ready
    // Blind Fire ready (Armed)
    ArmedBF_Rest2LeftReady=RDG_1_idleHold_TO_L_Hold
    ArmedBF_Rest2RightReady=RDG_1_idleHold_TO_R_Hold
    ArmedBF_Rest2UpReady=RDG_1_idleHold_TO_Up_Hold
    ArmedBF_LeftReady2Rest=RDG_1_L_HoldTOidleHold
    ArmedBF_RightReady2Rest=RDG_1_R_HoldTOidleHold
    ArmedBF_UpReady2Rest=RDG_1_Up_HoldTOidleHold
    ArmedBF_LeftReady2Up=RDG_1_L_Hold_toUp_Hold
    ArmedBF_LeftReady2Right=RDG_1_LHold_ready_toR_Hold
    ArmedBF_UpReady2Left=RDG_1_Up_Hold_toL_Hold
    ArmedBF_UpReady2Right=RDG_1_Up_Hold_toR_Hold
    ArmedBF_RightReady2Up=RDG_1_R_Hold_toUp_Hold
    ArmedBF_RightReady2Left=RDG_1_R_Hold_toL_Hold
    ArmedBF_LeftReady2Idle=RDG_1_L_HoldTOidleHold
    ArmedBF_RightReady2Idle=RDG_1_R_HoldTOidleHold
    ArmedBF_UpReady2Idle=RDG_1_Up_HoldTOidleHold
    ArmedBF_Idle2UpReady=RDG_1_idleHold_TO_Up_Hold
    ArmedBF_Idle2LeftReady=RDG_1_idleHold_TO_L_Hold
    ArmedBF_Idle2RightReady=RDG_1_idleHold_TO_R_Hold

    // Enemy Spotting
    WeaponSpotEnemyAnim=RDG_1_SpotEnemy

    // Melee anims
    WeaponMeleeAnims(0)=RDG_1_Bash
    WeaponMeleeHardAnim=RDG_1_BashHard
    MeleePullbackAnim=RDG_1_Pullback
    MeleeHoldAnim=RDG_1_Pullback_Hold

    FuzeLength = 2.8
    bUseFuseTimeForProj=false

    bHasIronSights=false;

    MuzzleFlashSocket=none

    AmmoClass=class'ZMAmmo_RDG1_Smoke'

    // MAIN FIREMODE
    FiringStatesArray(0)=WeaponSingleFiring
    WeaponProjectiles(0)=class'RDG1SmokeProjectile'
    WeaponThrowAnim(0)=RDG_1_throw
    WeaponIdleAnims(0)=RDG_1_idle
    ExplosiveBlindFireRightAnim(0)=RDG_1_R_throw
    ExplosiveBlindFireLeftAnim(0)=RDG_1_L_throw
    ExplosiveBlindFireUpAnim(0)=RDG_1_Up_throw

    // ALT FIREMODE
    FiringStatesArray(ALTERNATE_FIREMODE)=none
    WeaponProjectiles(ALTERNATE_FIREMODE)=class'RDG1SmokeProjectile'
    WeaponThrowAnim(ALTERNATE_FIREMODE)=RDG_1_toss
    WeaponIdleAnims(ALTERNATE_FIREMODE)=RDG_1_idle
    ExplosiveBlindFireRightAnim(ALTERNATE_FIREMODE)=RDG_1_R_toss
    ExplosiveBlindFireLeftAnim(ALTERNATE_FIREMODE)=RDG_1_L_throw
    ExplosiveBlindFireUpAnim(ALTERNATE_FIREMODE)=RDG_1_toss

    Weight=0.0 // weight is in the ammo
    MaxAmmoCount=5
    InitialNumPrimaryMags=5

    ThrowSpawnModifier=0.525//0.55
    TossSpawnModifier=0.4//0.5

    ThrowingBattleChatterIndex=19 // `BATTLECHATTER_ThrowingSmoke

    // AI
    MinBurstAmount=1
    MaxBurstAmount=1
    BurstWaitTime=5.0

    EquipTime=+0.45//0.35//0.25
}
