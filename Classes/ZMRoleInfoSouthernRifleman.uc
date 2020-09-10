class ZMRoleInfoSouthernRifleman extends ZMRoleInfoSouthernInfantry;

DefaultProperties
{
    RoleType=RORIT_Rifleman
    ClassTier=1
    ClassIndex=`ROCI_RIFLEMAN

    bAllowPistolsInRealism=True

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_grunt'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_grunt'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ROGame.ROWeap_SKS_Rifle'),
        SecondaryWeapons=(),
        SquadLeaderItems=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ROGame.ROWeap_SKS_Rifle'),
        SecondaryWeapons=(),
        SquadLeaderItems=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ROGame.ROWeap_SKS_Rifle'),
        SecondaryWeapons=(),
        SquadLeaderItems=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ROGame.ROWeap_SKS_Rifle'),
        SecondaryWeapons=(),
        SquadLeaderItems=(),
        OtherItems=()
    )}
}
