class ZMRoleInfoNorthernLeaper extends ZMRoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    super.ExtraPawnModifiers(NP);

    // `zmlog("Applying extra Leaper modifiers", 'Debug');

    NP.Jumpz *= 3;
    NP.MaxFallSpeed *= 3;
    NP.AirControl *= 5;
    NP.AirSpeed *= 3;
}

DefaultProperties
{
    RoleType=RORIT_Marksman
    ClassTier=3
    ClassIndex=`ROCI_SNIPER //3

    bAllowPistolsInRealism=False

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_scout'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_scout'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level2'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}
}
