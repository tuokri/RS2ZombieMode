class PAPRoleInfoNorthernBomber extends PAPRoleInfoNorthernInfantry;

DefaultProperties
{
    RoleType=RORIT_MachineGunner
    ClassTier=2
    ClassIndex=`ROCI_MACHINEGUNNER // 2

    bAllowPistolsInRealism=False

    ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_mg'
    ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_mg'

    Items[RORIGM_Default]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(class'PicksAndPistols.PAPWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(class'PicksAndPistols.PAPWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(class'PicksAndPistols.PAPWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(class'PicksAndPistols.PAPWeap_BomberBomb'),
        OtherItems=(class'ROGame.ROItem_TunnelTool'),
        SquadLeaderItems=()
    )}
}
