class ZMHUDWidgetKillMessages extends ROHUDWidgetKillMessages;

static function class<ROWeapon> GetWeaponClassByIndex(int InvIndex)
{
	if (InvIndex < `ZMII_Min)
	{
		return super.GetWeaponClassByIndex(InvIndex);
	}
	else
	{
		switch (InvIndex)
		{
			case class'ZMWeap_Katana'.default.InvIndex:
				return class'ZMWeap_Katana';

			case class'ZMWeap_Katana_Secondary_Level2'.default.InvIndex:
				return class'ZMWeap_Katana_Secondary_Level2';

			case class'ZMWeap_DesertEagle_Pistol'.default.InvIndex:
				return class'ZMWeap_DesertEagle_Pistol';

			case class'ZMWeap_DesertEagle_Gold_Pistol'.default.InvIndex:
				return class'ZMWeap_DesertEagle_Gold_Pistol';

			case class'ZMWeap_M9_Flamethrower'.default.InvIndex:
				return class'ZMWeap_M9_Flamethrower';

			case class'ZMWeap_ZombieClaws'.default.InvIndex:
				return class'ZMWeap_ZombieClaws';
		}
	}
}

static function int GetInvIndexFromDamageType(class<DamageType> DamageType)
{
	switch (DamageType)
	{
		case class'ZMWeap_Katana'.default.InstantHitDamageTypes[0]:
		case class'ZMWeap_Katana'.default.InstantHitDamageTypes[2]:
		case class'ZMWeap_Katana'.default.DismemberDamageType:
			return class'ZMWeap_Katana'.default.InvIndex;

		case class'ZMWeap_Katana_Secondary_Level2'.default.InstantHitDamageTypes[0]:
		case class'ZMWeap_Katana_Secondary_Level2'.default.InstantHitDamageTypes[2]:
		case class'ZMWeap_Katana_Secondary_Level2'.default.DismemberDamageType:
			return class'ZMWeap_Katana_Secondary_Level2'.default.InvIndex;

		case class'ZMWeap_M9_Flamethrower'.default.InstantHitDamageTypes[0]:
			return class'ZMWeap_M9_Flamethrower'.default.InvIndex;

		case class'ZMWeap_DesertEagle_Pistol'.default.InstantHitDamageTypes[0]:
		case class'ZMWeap_DesertEagle_Pistol'.default.InstantHitDamageTypes[1]:
			return class'ZMWeap_DesertEagle_Pistol'.default.InvIndex;

		default:
			return super.GetInvIndexFromDamageType(DamageType);
	}
}
