class PAPRoleInfoSouthernProtester extends RORoleInfoSouthernInfantry;

DefaultProperties
{
    RoleType=RORIT_MachineGunner
    ClassTier=2
    ClassIndex=`ROCI_MACHINEGUNNER // 2

    bAllowPistolsInRealism=True

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_mg'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_mg'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ROGame.ROWeap_PM_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_Molotov'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ROGame.ROWeap_PM_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_Molotov'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ROGame.ROWeap_PM_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_Molotov'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ROGame.ROWeap_PM_Pistol'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_Molotov'),
        SquadLeaderItems=()
    )}
}
