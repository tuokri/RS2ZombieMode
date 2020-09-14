class ZMRoleInfoNorthernCommander extends RORoleInfoNorthernCommander;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    NP.HealthMax *= 1.5;
    NP.Health *= 1.5;

    // NP.HealthMax *= 1.105;
    // NP.Health *= 1.105;
}

DefaultProperties
{
    bAllowPistolsInRealism=False

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M34_WP')
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M34_WP')
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M34_WP')
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROWeap_M34_WP')
    )}
}
