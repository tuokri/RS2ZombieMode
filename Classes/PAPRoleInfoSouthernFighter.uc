class PAPRoleInfoSouthernFighter extends PAPRoleInfoSouthernInfantry;

DefaultProperties
{
    bAllowPistolsInRealism=False

    Items[RORIGM_Default]={(
        PrimaryWeapons=(class'ROGame.ROWeap_IZH43_Shotgun')
    )}

    Items[RORIGM_Campaign_Early]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Mid]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Late]=Items[RORIGM_Default]
}
