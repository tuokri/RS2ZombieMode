class PAPRoleInfoNorthernLeaper extends PAPRoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(PAPNorthPawn NP)
{
    super.ExtraPawnModifiers(NP);

    // `paplog("Applying extra Leaper modifiers", 'Debug');

    NP.Jumpz *= 3;
    NP.MaxFallSpeed *= 3;
    NP.AirControl *= 3;
    NP.AirSpeed *= 3;
    NP.Health *= 0.8;
    NP.HealthMax *= 0.8;
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
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}
}
