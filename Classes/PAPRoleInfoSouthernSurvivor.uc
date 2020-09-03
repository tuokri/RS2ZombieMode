class PAPRoleInfoSouthernSurvivor extends PAPRoleInfoSouthernInfantry;

DefaultProperties
{
    bAllowPistolsInRealism=True

    Items[RORIGM_Default]={(
        PrimaryWeapons=(
            class'ROGame.ROWeap_M1911_Pistol',
            class'ROGame.ROWeap_BHP_Pistol',
            class'ROWeap_M1917_Pistol',
            class'ROWeap_PM_Pistol',
            class'ROWeap_TT33_Pistol'
        ),
    )}

    Items[RORIGM_Campaign_Early]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Mid]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Late]=Items[RORIGM_Default]
}
