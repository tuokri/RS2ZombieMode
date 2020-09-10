class ZMRoleInfoNorthernCommander extends RORoleInfoNorthernCommander;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    NP.HealthMax *= 1.5;
    NP.Health *= 1.5;
}

DefaultProperties
{
    bAllowPistolsInRealism=False

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}
}
