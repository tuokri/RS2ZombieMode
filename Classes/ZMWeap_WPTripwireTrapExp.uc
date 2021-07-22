//=============================================================================
// Willy Pete Tripwire Trap Explosion
//=============================================================================
// Trap for south side to kill zombies
//=============================================================================
// Zombie mode for Rising Storm 2: Vietnam
// Authored by adriaN$t3@m
//=============================================================================

class ZMWeap_WPTripwireTrapExp extends TripwireTrap;

defaultproperties
{
    MyDamageType=class'RODmgType_M34Grenade'
    //for da wp damage
    FumeDamageType=class'RODmgType_WhitePhosphorusFumes'
    ContinuousDamage=100//40
    IncDamageRadius=400 //200
    MaxIncDamageRadius=500 //300
    RadiusGrowFactor=1.0//1.1
    bAlwaysRelevant=true
    bNetTemporary=false

    Damage=200
    DamageRadius=600
    MomentumTransfer=0
    ExplosionSound=AkEvent'WW_EXP_M34.Play_EXP_M34WP_Explosion'
    MyExplosionSound=AkEvent'WW_EXP_M34.Play_EXP_M34WP_Explosion'
    MyExplosionMediumSound=AkEvent'WW_EXP_M34.Play_EXP_M34WP_Explosion'
    MyDamageType=class'RODmgType_M34Grenade'

    PrimeSound=AkEvent'WW_EXP_Shared.Play_Trap_Trip'
    DisarmSound=AkEvent'WW_EXP_Shared.Play_Trap_Disarm'

    ProjExplosionTemplate=ParticleSystem'FX_VN_Phosphor.Explosions.FX_VN_Phosphorus_Grenade'
}
