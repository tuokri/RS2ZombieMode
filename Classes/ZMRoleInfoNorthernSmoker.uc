class ZMRoleInfoNorthernSmoker extends ZMRoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    super.ExtraPawnModifiers(NP);
}

DefaultProperties
{
	RoleType=RORIT_Scout
	ClassTier=2
	ClassIndex=`ROCI_SCOUT // 1

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=(class'ROGame.ROItem_TunnelTool')
    )}

	ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_scout'
	ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_scout'
}
