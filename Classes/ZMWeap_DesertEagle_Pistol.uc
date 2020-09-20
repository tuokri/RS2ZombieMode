// Mark XIX .44 Magnum
class ZMWeap_DesertEagle_Pistol extends ROProjectileWeapon
    abstract;

// TODO: clean up last shot ping code.
var bool bLastShot;
var(Sounds) array<SoundCue> WeaponFirePingSnd;
var(Sounds) array<SoundCue> WeaponFirePingSndFirstPerson;

var(Sounds) array<SoundCue> WeaponFireSndCustom;
var(Sounds) array<SoundCue> WeaponFireSndFirstPersonCustom;

/*
simulated function float GetSpreadMod()
{
    return 3 * super.GetSpreadMod();
}
*/

// TODO: clean up last shot ping code.
simulated function PlayFiringSound(byte FireModeNum)
{
    if( Instigator != none && Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() )
    {
        if ( bLastShot && FireModeNum < WeaponFirePingSndFirstPerson.Length && WeaponFirePingSndFirstPerson[CurrentFireMode] != none )
        {
            MakeNoise(1.0, 'SmallArms');
            WeaponPlayCustomSound( WeaponFirePingSndFirstPerson[FireModeNum] );
            bLastShot = false;
        }
        else if ( bLastShot && FireModeNum < WeaponFirePingSnd.Length && WeaponFirePingSnd[FireModeNum] != None )
        {
            MakeNoise(1.0, 'SmallArms');
            WeaponPlayCustomSound( WeaponFirePingSnd[FireModeNum] );
            bLastShot = false;
        }
        else if ( FireModeNum < WeaponFireSndFirstPersonCustom.Length && WeaponFireSndFirstPersonCustom[FireModeNum] != none )
        {
            MakeNoise(1.0, 'SmallArms');
            WeaponPlayCustomSound( WeaponFireSndFirstPersonCustom[FireModeNum] );
        }
        else if ( FireModeNum < WeaponFireSndCustom.Length && WeaponFireSndCustom[FireModeNum] != None )
        {
            MakeNoise(1.0, 'SmallArms');
            WeaponPlayCustomSound( WeaponFireSndCustom[FireModeNum] );
        }
    }
    else
    {
        if ( bLastShot && FireModeNum < WeaponFirePingSnd.Length && WeaponFirePingSnd[FireModeNum] != None )
        {
            MakeNoise(1.0, 'SmallArms');
            WeaponPlayCustomSound( WeaponFirePingSnd[FireModeNum] );
            bLastShot = false;
        }
        else if ( FireModeNum < WeaponFireSndCustom.Length && WeaponFireSndCustom[FireModeNum] != None )
        {
            MakeNoise(1.0, 'SmallArms');
            WeaponPlayCustomSound( WeaponFireSndCustom[FireModeNum] );
        }
    }
}

/**
 * This function handles playing sounds for weapons.  How it plays the sound depends on the following:
 *
 * If we are a listen server, then this sound is played and replicated as normal
 * If we are a remote client, but locally controlled (ie: we are on the client) we play the sound and don't replicate it
 * If we are a dedicated server, play the sound and replicate it to everyone BUT the owner (he will play it locally).
 *
 *
 * @param   SoundCue    - The Source Cue to play
 */
simulated function WeaponPlayCustomSound(SoundCue Sound, optional float NoiseLoudness)
{
    Sound.VolumeMultiplier = ZMPlayerController(Instigator.Controller).GetSFXVolumeSetting();
    Sound.VolumeMultiplier *= 5; // TODO: temporary. Find a way to tune the volume correctly.

    // if we are a listen server, just play the sound.  It will play locally
    // and be replicated to all other clients.
    if(Sound == None || Instigator == None)
    {
        return;
    }

    Instigator.PlaySound(Sound, false, true);
}

DefaultProperties
{
    // TODO: clean up last shot ping code.
    bLastShot=False
    WeaponFirePingSnd.Empty
    WeaponFirePingSndFirstPerson.Empty

    WeaponContentClass(0)="ZombieMode.ZMWeap_DesertEagle_Pistol_Content"

    RoleSelectionImage(0)=Texture2D'VN_UI_Textures.WeaponTex.US_Weap_M1911_Pistol'

    WeaponClassType=ROWCT_HandGun
    TeamIndex=`ALLIES_TEAM_INDEX

    Category=ROIC_Secondary //ROIC_Primary
    Weight=1.99             //KG
    //RoleEncumbranceModifier=0.0
    InvIndex=`ROII_M1911_Pistol
    InventoryWeight=0

    PlayerIronSightFOV=65.0

    // MAIN FIREMODE
    FiringStatesArray(0)=WeaponSingleFiring
    WeaponFireTypes(0)=EWFT_Custom
    WeaponProjectiles(0)=class'ZMBullet_DesertEagle'
    FireInterval(0)=+0.2 // 0.1
    Spread(0)=0.0048
    WeaponDryFireSnd=AkEvent'WW_WEP_Shared.Play_WEP_Generic_Dry_Fire'

    // ALT FIREMODE
    FiringStatesArray(ALTERNATE_FIREMODE)=none
    //WeaponFireTypes(ALTERNATE_FIREMODE)=EWFT_Custom
    WeaponProjectiles(ALTERNATE_FIREMODE)=none
    FireInterval(ALTERNATE_FIREMODE)=+0.1
    Spread(ALTERNATE_FIREMODE)=0.0048

    PreFireTraceLength=1250 //25 Meters

    //ShoulderedSpreadMod=3.0//6.0
    //HippedSpreadMod=5.0//10.0

    // AI
    MinBurstAmount=1
    MaxBurstAmount=5
    //BurstWaitTime=1.5
    //AISpreadScale=20.0

    //Recoil
    maxRecoilPitch=950
    minRecoilPitch=950
    maxRecoilYaw=150 // 125
    minRecoilYaw=-100 // -75
    RecoilRate=0.15 // 0.07
    RecoilMaxYawLimit=500
    RecoilMinYawLimit=65035
    RecoilMaxPitchLimit=750
    RecoilMinPitchLimit=64785
    RecoilISMaxYawLimit=500
    RecoilISMinYawLimit=65035
    RecoilISMaxPitchLimit=500
    RecoilISMinPitchLimit=65035
    RecoilBlendOutRatio=0.65

    // InstantHitDamage(0)=230
    // InstantHitDamage(1)=230
    InstantHitDamage(0)=125 // TODO: ?
    InstantHitDamage(1)=125

    InstantHitDamageTypes(0)=class'ZMDmgType_DesertEagleBullet'
    InstantHitDamageTypes(1)=class'ZMDmgType_DesertEagleBullet'

    MuzzleFlashSocket=MuzzleFlashSocket
    MuzzleFlashPSCTemplate=ParticleSystem'FX_VN_Weapons.MuzzleFlashes.FX_VN_MuzzleFlash_1stP_Pistol'
    MuzzleFlashDuration=0.33
    MuzzleFlashLightClass=class'ROGame.RORifleMuzzleFlashLight'

    // Shell eject FX
    ShellEjectSocket=ShellEjectSocket
    ShellEjectPSCTemplate=ParticleSystem'FX_VN_Weapons.ShellEjects.FX_Wep_ShellEject_USA_M1911A1Pistol'

    bHasIronSights=true;

    // Equip and putdown
    WeaponPutDownAnim=M1911_Putaway
    WeaponEquipAnim=M1911_Pullout
    WeaponDownAnim=M1911_Down
    WeaponUpAnim=M1911_Up
    WeaponDownSightedAnim=M1911_Down_Ironsight

    // Fire Anims
    // Hip fire
    WeaponFireAnim(0)=M1911_shoulder_shoot
    WeaponFireAnim(1)=M1911_shoulder_shoot
    WeaponFireLastAnim=M1911_shoulder_shoot_LAST
    // Shouldered fire
    WeaponFireShoulderedAnim(0)=M1911_shoulder_shoot
    WeaponFireShoulderedAnim(1)=M1911_shoulder_shoot
    WeaponFireLastShoulderedAnim=M1911_shoulder_shoot_LAST
    // Fire using iron sights
    WeaponFireSightedAnim(0)=M1911_iron_shoot
    WeaponFireSightedAnim(1)=M1911_iron_shoot
    WeaponFireLastSightedAnim=M1911_iron_shoot_LAST

    // Idle Anims
    // Hip Idle
    WeaponIdleAnims(0)=M1911_Shoulder_Idle
    WeaponIdleAnims(1)=M1911_Shoulder_Idle
    // Shouldered idle
    WeaponIdleShoulderedAnims(0)=M1911_Shoulder_Idle
    WeaponIdleShoulderedAnims(1)=M1911_Shoulder_Idle
    // Sighted Idle
    WeaponIdleSightedAnims(0)=M1911_Iron_Idle
    WeaponIdleSightedAnims(1)=M1911_Iron_Idle

    // Prone Crawl
    WeaponCrawlingAnims(0)=M1911_CrawlF
    WeaponCrawlStartAnim=M1911_Crawl_into
    WeaponCrawlEndAnim=M1911_Crawl_out

    //Reloading
    WeaponReloadEmptyMagAnim=M1911_reloadempty_02
    WeaponRestReloadEmptyMagAnim=M1911_reloadempty_rest
    WeaponReloadNonEmptyMagAnim=M1911_reloadhalf
    WeaponRestReloadNonEmptyMagAnim=M1911_reloadhalf_rest
    // Ammo check
    WeaponAmmoCheckAnim=M1911_ammocheck
    WeaponRestAmmoCheckAnim=M1911_ammocheck_rest

    // Sprinting
    WeaponSprintStartAnim=M1911_sprint_into
    WeaponSprintLoopAnim=M1911_Sprint
    WeaponSprintEndAnim=M1911_sprint_out

    // Mantling
    WeaponMantleOverAnim=M1911_Mantle

    // Cover/Blind Fire Anims
    WeaponRestAnim=M1911_rest_idle
    WeaponEquipRestAnim=M1911_pullout_rest
    WeaponPutDownRestAnim=M1911_putaway_rest
    WeaponBlindFireRightAnim=M1911_BF_Right_Shoot
    WeaponBlindFireLeftAnim=M1911_BF_Left_Shoot
    WeaponBlindFireUpAnim=M1911_BF_up_Shoot
    WeaponIdleToRestAnim=M1911_idleTOrest
    WeaponRestToIdleAnim=M1911_restTOidle
    WeaponRestToBlindFireRightAnim=M1911_restTOBF_Right
    WeaponRestToBlindFireLeftAnim=M1911_restTOBF_Left
    WeaponRestToBlindFireUpAnim=M1911_restTOBF_up
    WeaponBlindFireRightToRestAnim=M1911_BF_Right_TOrest
    WeaponBlindFireLeftToRestAnim=M1911_BF_Left_TOrest
    WeaponBlindFireUpToRestAnim=M1911_BF_up_TOrest
    WeaponBFLeftToUpTransAnim=M1911_BFleft_toBFup
    WeaponBFRightToUpTransAnim=M1911_BFright_toBFup
    WeaponBFUpToLeftTransAnim=M1911_BFup_toBFleft
    WeaponBFUpToRightTransAnim=M1911_BFup_toBFright
    // Blind Fire ready
    WeaponBF_Rest2LeftReady=M1911_restTO_L_ready
    WeaponBF_LeftReady2LeftFire=M1911_L_readyTOBF_L
    WeaponBF_LeftFire2LeftReady=M1911_BF_LTO_L_ready
    WeaponBF_LeftReady2Rest=M1911_L_readyTOrest
    WeaponBF_Rest2RightReady=M1911_restTO_R_ready
    WeaponBF_RightReady2RightFire=M1911_R_readyTOBF_R
    WeaponBF_RightFire2RightReady=M1911_BF_RTO_R_ready
    WeaponBF_RightReady2Rest=M1911_R_readyTOrest
    WeaponBF_Rest2UpReady=M1911_restTO_Up_ready
    WeaponBF_UpReady2UpFire=M1911_Up_readyTOBF_Up
    WeaponBF_UpFire2UpReady=M1911_BF_UpTO_Up_ready
    WeaponBF_UpReady2Rest=M1911_Up_readyTOrest
    WeaponBF_LeftReady2Up=M1911_L_ready_toUp_ready
    WeaponBF_LeftReady2Right=M1911_L_ready_toR_ready
    WeaponBF_UpReady2Left=M1911_Up_ready_toL_ready
    WeaponBF_UpReady2Right=M1911_Up_ready_toR_ready
    WeaponBF_RightReady2Up=M1911_R_ready_toUp_ready
    WeaponBF_RightReady2Left=M1911_R_ready_toL_ready
    WeaponBF_LeftReady2Idle=M1911_L_readyTOidle
    WeaponBF_RightReady2Idle=M1911_R_readyTOidle
    WeaponBF_UpReady2Idle=M1911_Up_readyTOidle
    WeaponBF_Idle2UpReady=M1911_idleTO_Up_ready
    WeaponBF_Idle2LeftReady=M1911_idleTO_L_ready
    WeaponBF_Idle2RightReady=M1911_idleTO_R_ready

    // Enemy Spotting
    WeaponSpotEnemyAnim=M1911_SpotEnemy
    WeaponSpotEnemySightedAnim=M1911_SpotEnemy_ironsight

    // Melee anims
    WeaponMeleeAnims(0)=M1911_Bash
    WeaponMeleeHardAnim=M1911_BashHard
    MeleePullbackAnim=M1911_Pullback
    MeleeHoldAnim=M1911_Pullback_Hold

    // Ironsight Melee Anim (only needed for pistols because their ironsight position is so different
    IronsightMeleeAnim=M1911_Bash_ironsight
    IronsightMeleePullbackAnim=M1911_Pullback_ironsight

    // needed for IronsightMeleeAnim to play instead of the normal Melee one
    bUsesIronsightMeleeAnim=true

    EquipTime=+0.65 // 0.45

    BoltControllerNames[0]=SlideControl_M1911
    BoltControllerNames[1]=SlideControl_M1911_2

    ISFocusDepth=14.5

    // Ammo
    MaxAmmoCount=9
    AmmoClass=class'ZMAmmo_109x33_DesertEagleMag'
    bUsesMagazines=true
    InitialNumPrimaryMags=5
    bPlusOneLoading=true
    bCanReloadNonEmptyMag=true
    bCanLoadStripperClip=false
    bCanLoadSingleBullet=false
    PenetrationDepth=18 // 10
    MaxPenetrationTests=5 // 3
    MaxNumPenetrations=4 // 2
    PerformReloadPct=0.71f

    PlayerViewOffset=(X=6.0,Y=4.5,Z=-2.75)
    ZoomInRotation=(Pitch=-910,Yaw=0,Roll=2910)
    //ShoulderedTime=0.35
    ShoulderedPosition=(X=5.0,Y=2.0,Z=-2.0)
    //ShoulderRotation=(Pitch=-300,Yaw=500,Roll=1500)
    IronSightPosition=(X=0,Y=0,Z=30) // Z=0

    bUsesFreeAim=true

    ZoomInTime=0.45 // 0.25
    ZoomOutTime=0.45 // 0.25

    // Free Aim variables
    FreeAimHipfireOffsetX=25

    PostureHippedRecoilModifer=2.0 // 1.25
    PostureShoulderRecoilModifer=1.8 //1.1

    Begin Object Class=ForceFeedbackWaveform Name=ForceFeedbackWaveformShooting1
        Samples(0)=(LeftAmplitude=30,RightAmplitude=30,LeftFunction=WF_Constant,RightFunction=WF_Constant,Duration=0.120)
    End Object
    WeaponFireWaveForm=ForceFeedbackWaveformShooting1

    CollisionCheckLength=30.0 // 22.0

    FireCameraAnim[0]=CameraAnim'1stperson_Cameras.Anim.Camera_C96_Shoot'
    FireCameraAnim[1]=CameraAnim'1stperson_Cameras.Anim.Camera_C96_Shoot'

    SuppressionPower=8 // 5

    AIRating=0.3

    NumHeloPenetrations=2 // 1

    bSkipZoomInRotation=false
    bUsesIronSightAnims=true

    SightRanges[0]=(AddedPitch=0)

    WeaponISZoomInAnim=M1911_IdleTOIron
    WeaponISZoomOutAnim=M1911_IronTOIdle

    WeaponEquipSightedAnim=M1911_Pullout_Ironsight
    WeaponPutDownSightedAnim=M1911_Putaway_Ironsight

    WeaponAmmoCheckIronAnim=M1911_ammocheck_Ironsight
    WeaponReloadEmptyMagIronAnim=M1911_reloadempty_Ironsight_02
    WeaponReloadNonEmptyMagIronAnim=M1911_reloadhalf_Ironsight

    SwayScale=0.9 // 0.6

    // bDebugWeapon=True
}
