class PAPRoleInfoSouthernCommander extends RORoleInfoSouthernCommander;

simulated function ExtraPawnModifiers(PAPSouthPawn SP)
{
}

DefaultProperties
{
    bAllowPistolsInRealism=True

    Items[RORIGM_Default]={(
        PrimaryWeapons=(
            class'ROGame.ROWeap_BHP_Pistol',
            class'ROGame.ROWeap_M1911_Pistol',
            class'ROWeap_M1917_Pistol',
            class'ROWeap_PM_Pistol',
            class'ROWeap_TT33_Pistol'
        ),
        SecondaryWeapons=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Early]={(
        PrimaryWeapons=(
            class'ROGame.ROWeap_BHP_Pistol',
            class'ROGame.ROWeap_M1911_Pistol',
            class'ROWeap_M1917_Pistol',
            class'ROWeap_PM_Pistol',
            class'ROWeap_TT33_Pistol'
        ),
        SecondaryWeapons=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Mid]={(
        PrimaryWeapons=(
            class'ROGame.ROWeap_BHP_Pistol',
            class'ROGame.ROWeap_M1911_Pistol',
            class'ROWeap_M1917_Pistol',
            class'ROWeap_PM_Pistol',
            class'ROWeap_TT33_Pistol'
        ),
        SecondaryWeapons=(),
        OtherItems=()
    )}

    Items[RORIGM_Campaign_Late]={(
        PrimaryWeapons=(
            class'ROGame.ROWeap_BHP_Pistol',
            class'ROGame.ROWeap_M1911_Pistol',
            class'ROWeap_M1917_Pistol',
            class'ROWeap_PM_Pistol',
            class'ROWeap_TT33_Pistol'
        ),
        SecondaryWeapons=(),
        OtherItems=()
    )}
}
