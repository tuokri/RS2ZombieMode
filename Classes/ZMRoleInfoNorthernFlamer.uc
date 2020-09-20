class ZMRoleInfoNorthernFlamer extends ZMRoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    super.ExtraPawnModifiers(NP);

    NP.Jumpz *= 2;
    NP.MaxFallSpeed *= 2;
    NP.AirControl *= 5;
    NP.AirSpeed *= 3;
}

DefaultProperties
{
	bAllowPistolsInRealism=False

	RoleType=RORIT_Scout
    ClassTier=2
    ClassIndex=`ROCI_HEAVY // 5

	ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_sapper'
	ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_sapper'

	Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_M9_Flamethrower'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_M9_Flamethrower'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_M9_Flamethrower'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_M9_Flamethrower'),
        SecondaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        OtherItems=(),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}
}
