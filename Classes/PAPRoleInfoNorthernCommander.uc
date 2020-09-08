class PAPRoleInfoNorthernCommander extends RORoleInfoNorthernCommander;

simulated function ExtraPawnModifiers(PAPNorthPawn NP)
{
    NP.HealthMax *= 1.5;
    NP.Health *= 1.5;
}

DefaultProperties
{
    bAllowPistolsInRealism=False

    Items[RORIGM_Default]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(),
        SecondaryWeapons=(),
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}
}
