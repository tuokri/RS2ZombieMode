class ZMHUD extends ROHUD
    config(Mutator_ZombieMode_Client);

DefaultProperties
{
    SideColors(0)=(R=229,G=73,B=39,A=255) //(R=240,G=32,B=32,A=255)
    SideColors(1)=(R=80,G=160,B=240,A=255)
    SideDeadColors(0)=(R=100,G=46,B=35,A=255) //(R=171,G=47,B=20,A=255) //(R=190,G=24,B=24,A=255)
    SideDeadColors(1)=(R=50,G=70,B=120,A=255) //(R=50,G=110,B=190,A=255)
    NeutralColor=(R=255,G=255,B=255,A=210)
    //SquadColors(0)=(R=235,G=61,B=235,A=210)//(R=203,G=89,B=206,A=210)
    //SquadColors(1)=(R=235,G=61,B=235,A=210)//(R=203,G=89,B=206,A=210)
    //SquadDeadColors(0)=(R=173,G=18,B=173,A=210)//(R=164,G=255,B=164,A=210)
    //SquadDeadColors(1)=(R=173,G=18,B=173,A=210)//(R=164,G=255,B=164,A=210)
    //AttachedSquadColors(0)=(R=173,G=18,B=173,A=210)//(R=164,G=255,B=164,A=210)
    //AttachedSquadColors(1)=(R=173,G=18,B=173,A=210)//(R=164,G=255,B=164,A=210)
    TeamLeaderColor=(R=255,G=128,B=0,A=255)
    SquadLeaderColor=(R=149,G=108,B=199,A=255)//(R=173,G=18,B=173,A=210)//(R=204,G=153,B=0,A=255)
    PlayerTagFont=Font'VN_UI_Mega_Fonts.Font_VN_Mega_36'//Font'VN_UI_Fonts.Font_VN_Clean'

    SquadColourPresets(0)=(SquadColour=(R=253,G=162,B=0,A=210),SquadDeadColour=(R=180,G=129,B=46,A=210),AttachedSquadColour=(R=180,G=129,B=46,A=210))
    SquadColourPresets(1)=(SquadColour=(R=50,G=200,B=60,A=210),SquadDeadColour=(R=15,G=100,B=33,A=210),AttachedSquadColour=(R=15,G=100,B=33,A=210))
    SquadColourPresets(2)=(SquadColour=(R=235,G=61,B=235,A=210),SquadDeadColour=(R=173,G=18,B=173,A=210),AttachedSquadColour=(R=173,G=18,B=173,A=210))
    SquadColourPresets(3)=(SquadColour=(R=150,G=45,B=255,A=210),SquadDeadColour=(R=94,G=0,B=187,A=210),AttachedSquadColour=(R=94,G=0,B=187,A=210))

    DefaultStatusWidget=class'ROHUDWidgetStatus'
    DefaultWeaponWidget=class'ROHUDWidgetWeapon'
    DefaultInventoryWidget=class'ROHUDWidgetInventory'
    DefaultObjectiveWidget=class'ROHUDWidgetObjective'
    DefaultScoreboardWidgetTE=class'ROGame.ROHUDWidgetScoreboardTE'
    DefaultScoreboardWidgetFF=class'ROGame.ROHUDWidgetScoreboardFF'
    DefaultScoreboardWidgetSK=class'ROGame.ROHUDWidgetScoreboardSK'
    DefaultScoreboardWidgetSU=class'ROHUDWidgetScoreboardSU'
    DefaultOverheadMapWidget=class'ROHUDWidgetOverheadMap'
    DefaultCommunicationWidget=class'ROHUDWidgetComCommunication'
    DefaultOrdersWidget=class'ROHUDWidgetComOrders'
    DefaultCompactVoiceCommsWidget=class'ROHUDWidgetCompactVoiceComms'
    DefaultMessagesChatWidget=class'ROHUDWidgetMessagesColoredChat'
    DefaultMessagesAlertsWidget=class'ROHUDWidgetMessagesAlerts'
    DefaultMessagesRedAlertsWidget=class'ROHUDWidgetMessagesRedAlerts'
    DefaultMessageBleedingWidget=class'ROHUDWidgetMessageBleeding'
    DefaultMessagesPickupsWidget=class'ROHUDWidgetMessagesPickups'
    DefaultMessagesOrdersSLWidget=class'ROHUDWidgetMessagesOrdersSL'
    DefaultMessagesReloadWidget=class'ROHUDWidgetMessagesReload'
    DefaultMessagesPromptsWidget=class'ROHUDWidgetMessagesPrompts'
    DefaultIndicatorWidget=class'ROHUDWidgetIndicator'
    DefaultIndicatorRightWidget=class'ROHUDWidgetIndicatorRight'
    DefaultCompassWidget=class'ROHUDWidgetSimpleCompass'
    DefaultObjectiveOverviewWidget=class'ROHUDWidgetObjectiveOverview'
    DefaultWorldWidget=class'ROHUDWidgetWorld'
    DefaultPeripheralWhips=class'ROHUDWidgetPeripheralWhips'
    DefaultPeripheralDamage=class'ROHUDWidgetPeripheralDamage'
    DefaultPeripheralPawns=class'ROHUDWidgetPeripheralPawns'
    DefaultCutOffTimerWidget=class'ROHUDWidgetCutOffTimer'
    DefaultMapBoundaryTimer=class'ROHUDWidgetMapBoundaryTimer'
    //DefaultMiniStrengthPointsWidget=class'ROHUDWidgetMiniStrengthPoints'
    DefaultSpawnQueueWidget=class'ROHUDWidgetSpawnQueue'
    DefaultCommanderWidget=class'ROHUDWidgetCommander'
    DefaultCommanderAbilitiesWidgetNorth=class'ROHUDWidgetCommanderAbilitiesNorth'
    DefaultCommanderAbilitiesWidgetSouth=class'ROHUDWidgetCommanderAbilitiesSouth'
    /*DefaultTimerWidgetTE=class'ROHUDWidgetLockDownTimer'
    DefaultTimerWidgetFF=class'ROHUDWidgetRoundEndTimer'
    DefaultTimerWidgetSP=class'ROHUDWidgetSPDefendTimer'
    DefaultTimerWidgetSU=class'ROHUDWidgetOvertimeTimer'*/
    DefaultGameStartWidget=class'ROHUDWidgetTerritoryStartTimer'
    DefaultVOIPMeterWidget=class'ROHUDWidgetVOIPMeter'
    DefaultSpecatorWidget=class'ROHUDWidgetSpectator'
    DefaultTrainingWidget=class'ROHUDWidgetTraining'
    DefaultVOIPTalkersWidget=class'ROHUDWidgetVOIPTalkers'
    DefaultInviteMessageWidget=class'ROHUDWidgetInviteMessage'
    DefaultLevelUpWidget=class'ROHUDWidgetLevelUpMessage'
    DefaultSquadListWidget=class'ROHUDWidgetSquadList'
    DefaultVehicleListWidget=class'ROHUDWidgetVehicleList'
    DefaultHintsWidget=class'ROHUDWidgetHints'
    DefaultVehicleInfoWidget=class'ROHUDWidgetVehicleInfo'
    DefaultFadeWidget=class'ROHUDWidgetFadeScreen'
    DefaultGForceFadeWidget=class'ROHUDWidgetGForceFade'
    DefaultCamoIndicatorWidget=class'ROHUDWidgetCamoIndicator'
    DefaultHelicopterInfoWidget=class'ROHUDWidgetHelicopterInfo'
    DefaultHelicopterInstrumentWidget=class'ROHUDWidgetHelicopterInstruments'
    DefaultMessagesTrapsWidget=class'ROHUDWidgetMessagesTraps'
    DefaultGameStatusWidgetSK=class'ROHUDWidgetGameStatusSK'
    DefaultGameStatusWidgetTE=class'ROHUDWidgetGameStatusTE'
    DefaultGameStatusWidgetSU=class'ROHUDWidgetGameStatusSU'
    DefaultPromptBoxWidget=class'ROHUDWidgetPromptBox'
    DefaultWatermarkWidget=class'ROHUDWidgetWatermark'
    DefaultAmmoCheckWidget=class'ROHUDWidgetAmmoCheckIcon'
    DefaultSLNoticeWidget=class'ROHUDWidgetSLNotice'
    DefaultBandagingBarWidget=class'ROHUDWidgetProgressBar'
    DefaultHeloTrainingRespawnWidget=class'ROHUDWidgetHeloTrainRespawnTimer'
    DefaultRadiomanHelperWidget=class'ROHUDWidgetRadiomanHelper'

    Begin Object Class=ROHUDWidgetComponent Name=Reticle
        X=448
        Y=320
        Width=128
        Height=128
        TexWidth=256
        TexHeight=256
        Tex=Texture2D'ui_textures_two.EnemySpotted.EnemySpottedHud'
        DrawColor=(R=255,G=255,B=255,A=80)
        FullAlpha=80
    End Object
    EnemySpottedReticle=Reticle

    CrosshairAccuracyScale=(Points=((InVal=0.0001,OutVal=0.8),(InVal=0.0095,OutVal=1.0),(InVal=0.015,OutVal=1.3)))
    BaseCrosshairSize=50

    CurrentIronSightAlpha=0

    // ZombieMode widgets.
    // DefaultHintsWidget=class'ZMHudWidgetHints'
    DefaultKillMessageWidget=class'ZMHUDWidgetKillMessages';

    // ZombieMode specific stuff.
    AmmoUVs(66)=(AmmoClass=ZMAmmo_109x33_DesertEagleMag,MagTexture=Texture2D'VN_UI_Textures.HUD.Ammo.UI_HUD_Ammo_1911')
    AmmoUVs(67)=(AmmoClass=ZMAmmo_127x99_M2Belt_APC,MagTexture=Texture2D'VN_UI_Textures.HUD.Ammo.UI_HUD_Ammo_DSHK')
    AmmoUVs(68)=(AmmoClass=ZMAmmo_15L_M9A1Tank,MagTexture=Texture2D'VN_UI_Textures.HUD.Ammo.UI_HUD_Ammo_M9A1_Flamer')
    AmmoUVs(69)=(AmmoClass=ZMAmmo_9x19_BHPMag,MagTexture=Texture2D'VN_UI_Textures_Three.HUD.Ammo.UI_HUD_Ammo_Browning')
    AmmoUVs(70)=(AmmoClass=ZMAmmo_Buck_M37ShellNo4,MagTexture=Texture2D'VN_UI_Textures.HUD.Ammo.UI_HUD_Ammo_ShotgunShellNo4')
    AmmoUVs(71)=(AmmoClass=ZMAmmo_RDG1_Smoke,MagTexture=Texture2D'VN_UI_Textures.HUD.Ammo.UI_HUD_Ammo_RGD1_Smoke')
    AmmoUVs(72)=(AmmoClass=ZMAmmo_TripwireTrap,MagTexture=Texture2D'VN_UI_Textures.HUD.Ammo.UI_HUD_Ammo_TripwireTrap')

    WeaponUVs(75)=(WeaponClass=ZMWeap_Katana,WeaponTexture=Texture2D'ZM_RS_UI_Textures.HUD.WeaponSelect.UI_HUD_WeaponSelect_Katana',MagTexture=Texture2D'ZM_RS_UI_Textures.HUD.Ammo.ui_ammo_katana',KillMessageTexture=Texture2D'ZM_RS_UI_Textures.HUD.DeathMessage.UI_Kill_Icon_Katana',KillMessageWidth=128,KillMessageHeight=64)
    WeaponUVs(76)=(WeaponClass=ZMWeap_Katana_Level2,WeaponTexture=Texture2D'ZM_RS_UI_Textures.HUD.WeaponSelect.UI_HUD_WeaponSelect_Katana',MagTexture=Texture2D'ZM_RS_UI_Textures.HUD.Ammo.ui_ammo_katana',KillMessageTexture=Texture2D'ZM_RS_UI_Textures.HUD.DeathMessage.UI_Kill_Icon_Katana',KillMessageWidth=128,KillMessageHeight=64)
    WeaponUVs(77)=(WeaponClass=ZMWeap_Katana_Level3,WeaponTexture=Texture2D'ZM_RS_UI_Textures.HUD.WeaponSelect.UI_HUD_WeaponSelect_Katana',MagTexture=Texture2D'ZM_RS_UI_Textures.HUD.Ammo.ui_ammo_katana',KillMessageTexture=Texture2D'ZM_RS_UI_Textures.HUD.DeathMessage.UI_Kill_Icon_Katana',KillMessageWidth=128,KillMessageHeight=64)
    WeaponUVs(79)=(WeaponClass=ZMWeap_DesertEagle_Pistol,WeaponTexture=Texture2D'ZM_WP_DesertEagle.HUD.deagle_inventory_select',KillMessageTexture=Texture2D'ZM_WP_DesertEagle.HUD.deagle_kill_ui',KillMessageWidth=64,KillMessageHeight=64)
    WeaponUVs(80)=(WeaponClass=ZMWeap_DesertEagle_Pistol_Gold,WeaponTexture=Texture2D'ZM_WP_DesertEagle.HUD.deagle_inventory_select',KillMessageTexture=Texture2D'ZM_WP_DesertEagle.HUD.deagle_kill_ui',KillMessageWidth=64,KillMessageHeight=64)
    WeaponUVs(81)=(WeaponClass=ZMWeap_ZombieClaws,WeaponTexture=Texture2D'ZM_UI_Textures.HUD.Zombie_Claw_UI_256',MagTexture=Texture2D'ZM_UI_Textures.HUD.Zombie_Claw_UI_256',KillMessageTexture=Texture2D'ZM_UI_Textures.HUD.Zombie_Claw_UI_256',KillMessageWidth=128,KillMessageHeight=64)
    WeaponUVs(82)=(WeaponClass=ZMWeap_Katana_Secondary_Level2,WeaponTexture=Texture2D'ZM_RS_UI_Textures.HUD.WeaponSelect.UI_HUD_WeaponSelect_Katana',MagTexture=Texture2D'ZM_RS_UI_Textures.HUD.Ammo.ui_ammo_katana',KillMessageTexture=Texture2D'ZM_RS_UI_Textures.HUD.DeathMessage.UI_Kill_Icon_Katana',KillMessageWidth=128,KillMessageHeight=64)
}
