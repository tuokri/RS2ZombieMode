class ZMAmmo_127x99_M2Belt_APC extends ROAmmunition
    abstract;

defaultproperties
{
	CompatibleWeaponClasses(1)=class'ROWeap_M2_HMG_Tripod'
	CompatibleWeaponClasses(2)=class'ZMVWeap_APC_HullMG'

    InitialAmount=550
    Weight=10.0
    ClipsPerSlot=1
}
