class ZMRoleInfoNorthernZombie extends ZMRoleInfoNorthernInfantry;

/*
simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    super.ExtraPawnModifiers(NP);
}
*/

DefaultProperties
{
    RoleType=RORIT_Rifleman
    ClassTier=1
    ClassIndex=`ROCI_RIFLEMAN

    bAllowPistolsInRealism=False

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_guerilla'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_guerilla'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}
}
