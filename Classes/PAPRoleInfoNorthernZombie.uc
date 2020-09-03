class PAPRoleInfoSouthernCommander extends PAPRoleInfoSouthernInfantry;

DefaultProperties
{
    bAllowPistolsInRealism=False

    Items[RORIGM_Default]={(
        OtherItems=(class'ROGame.ROItem_TunnelTool')
    )}

    Items[RORIGM_Campaign_Early]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Mid]=Items[RORIGM_Default]
    Items[RORIGM_Campaign_Late]=Items[RORIGM_Default]
}
