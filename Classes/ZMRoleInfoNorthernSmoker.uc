class ZMRoleInfoNorthernSmoker extends ZMRoleInfoNorthernInfantry;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    super.ExtraPawnModifiers(NP);

    NP.HealthMax *= 1.5;
    NP.Health *= 1.5;
}

DefaultProperties
{
	RoleType=RORIT_Scout
	ClassTier=2
	ClassIndex=`ROCI_SCOUT // 1

    Items[RORIGM_Default]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool', class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool', class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool', class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool', class'ROGame.ROWeap_RDG1_Smoke'),
        SquadLeaderItems=()
    )}

	ClassIcon=Texture2D'VN_UI_Textures.menu.class_icon_scout'
	ClassIconLarge=Texture2D'VN_UI_Textures.menu.ProfileStats.class_icon_large_scout'
}
