class ZMRoleInfoNorthernCommander extends RORoleInfoNorthernCommander;

simulated function ExtraPawnModifiers(ZMNorthPawn NP)
{
    if (NP.HealthMax == 100 && NP.Health == 100)
    {
        NP.HealthMax *= 1.45;
        NP.Health *= 1.45;
    }
}

DefaultProperties
{
    bAllowPistolsInRealism=False

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(class'ZombieMode.ZMWeap_Katana_Level3'),
        SecondaryWeapons=(),
        // OtherItems=(class'ROGame.ROWeap_M34_WP')
        OtherItems=()
    )}
}
