class PAPRoleInfoNorthernZombie extends RORoleInfoNorthernInfantry;

DefaultProperties
{
    RoleType=RORIT_Rifleman
    ClassTier=1
    ClassIndex=`ROCI_RIFLEMAN

    bAllowPistolsInRealism=False

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_guerilla'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_guerilla'

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
