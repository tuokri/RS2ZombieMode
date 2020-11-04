class ZMRoleInfoSouthernFighter extends ZMRoleInfoSouthernInfantry;

DefaultProperties
{
    RoleType=RORIT_Scout
    ClassTier=2
    ClassIndex=`ROCI_HEAVY // 5

    bAllowPistolsInRealism=True

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_scout'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_scout'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ROGame.ROWeap_IZH43_Shotgun'),
        SecondaryWeapons=(
            class'ZombieMode.ZMWeap_BHP_Pistol',
            class'ZMWeap_DesertEagle_Pistol'),
        OtherItems=(),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ROGame.ROWeap_IZH43_Shotgun'),
        SecondaryWeapons=(
            class'ZombieMode.ZMWeap_BHP_Pistol',
            class'ZMWeap_DesertEagle_Pistol'),
        OtherItems=(),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ROGame.ROWeap_IZH43_Shotgun'),
        SecondaryWeapons=(
            class'ZombieMode.ZMWeap_BHP_Pistol',
            class'ZMWeap_DesertEagle_Pistol'),
        OtherItems=(),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ROGame.ROWeap_IZH43_Shotgun'),
        SecondaryWeapons=(
            class'ZombieMode.ZMWeap_BHP_Pistol',
            class'ZMWeap_DesertEagle_Pistol'),
        OtherItems=(),
        SquadLeaderItems=()
    )}
}
