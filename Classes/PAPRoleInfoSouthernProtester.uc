class PAPRoleInfoSouthernProtester extends PAPRoleInfoSouthernInfantry;

DefaultProperties
{
    bAllowPistolsInRealism=True

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ROGame.ROWeap_PM_Pistol'),
        OtherItems=(class'ROGame.ROWeap_Molotov')
    )}

    Items[RORIGM_Campaign_Early]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Mid]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Late]=Items[RORIGM_Default]
}
