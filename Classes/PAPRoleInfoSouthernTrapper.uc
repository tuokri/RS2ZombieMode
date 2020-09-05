class PAPRoleInfoSouthernTrapper extends PAPRoleInfoSouthernInfantry;

DefaultProperties
{
    RoleType=RORIT_Marksman
    ClassTier=3
    ClassIndex=`ROCI_SNIPER //3

    bAllowPistolsInRealism=True

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_sniper'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_sniper'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ROGame.ROWeap_BHP_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M18_Claymore'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ROGame.ROWeap_BHP_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M18_Claymore'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ROGame.ROWeap_BHP_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M18_Claymore'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ROGame.ROWeap_BHP_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M18_Claymore'),
        SquadLeaderItems=()
    )}
}
