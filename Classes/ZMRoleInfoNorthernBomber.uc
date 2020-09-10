class ZMRoleInfoNorthernBomber extends ZMRoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    super.ExtraPawnModifiers(NP);

    NP.SpawnBomberBurningEffects();
}

DefaultProperties
{
    RoleType=RORIT_MachineGunner
    ClassTier=2
    ClassIndex=`ROCI_MACHINEGUNNER // 2

    bAllowPistolsInRealism=False

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_mg'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_mg'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}
}
