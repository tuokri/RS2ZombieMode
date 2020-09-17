// .44 Magnum 240 gr (16 g) JHP Cor-Bon
class ZMBullet_DesertEagle extends ROBullet;

DefaultProperties
{
	BallisticCoefficient=0.200 // TODO: Check this.

	// Damage=230
	Damage=300 // 110
	MyDamageType=class'ZMDmgType_DesertEagleBullet'
	Speed=22950		// 450 m/s - 12750=255 m/s
	MaxSpeed=22950	// 450 m/s - 12750=255 m/s

	// RS2. Energy transfer function
	// M1911, M3A1
	VelocityDamageFalloffCurve=(Points=((InVal=49000000,OutVal=0.1),(InVal=162562500,OutVal=0.95)))
	// VelocityDamageFalloffCurve=(Points=((InVal=0.5,OutVal=1.0),(InVal=1.0,OutVal=0.9)))
}
