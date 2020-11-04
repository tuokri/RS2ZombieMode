class ZMRoleInfoSouthernDemolitions extends ZMRoleInfoSouthernInfantry;

DefaultProperties
{
    RoleType=RORIT_Engineer
    ClassTier=3
    ClassIndex=`ROCI_ENGINEER //4

    bAllowPistolsInRealism=True

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_sapper'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_sapper'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ROGame.ROWeap_M79_GrenadeLauncher'),
        SecondaryWeapons=(class'ROGame.ROWeap_M1917_Pistol'),
        OtherItems=(class'ROGame.ROWeap_M34_WP', class'ROGame.ROWeap_M61_Grenade'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ROGame.ROWeap_M79_GrenadeLauncher'),
        SecondaryWeapons=(class'ROGame.ROWeap_M1917_Pistol'),
        OtherItems=(class'ROGame.ROWeap_M34_WP', class'ROGame.ROWeap_M61_Grenade'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ROGame.ROWeap_M79_GrenadeLauncher'),
        SecondaryWeapons=(class'ROGame.ROWeap_M1917_Pistol'),
        OtherItems=(class'ROGame.ROWeap_M34_WP', class'ROGame.ROWeap_M61_Grenade'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ROGame.ROWeap_M79_GrenadeLauncher'),
        SecondaryWeapons=(class'ROGame.ROWeap_M1917_Pistol'),
        OtherItems=(class'ROGame.ROWeap_M34_WP', class'ROGame.ROWeap_M61_Grenade'),
        SquadLeaderItems=()
    )}
}
