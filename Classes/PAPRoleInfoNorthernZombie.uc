class PAPRoleInfoNorthernZombie extends PAPRoleInfoNorthernInfantry;

DefaultProperties
{
    RoleType=RORIT_Rifleman
    ClassTier=1
    ClassIndex=`ROCI_RIFLEMAN

    bAllowPistolsInRealism=False

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_guerilla'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_guerilla'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'PicksAndPistols.PAPWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'PicksAndPistols.PAPWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'PicksAndPistols.PAPWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'PicksAndPistols.PAPWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}
}
