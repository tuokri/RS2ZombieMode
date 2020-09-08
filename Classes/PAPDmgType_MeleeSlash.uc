class PAPDmgType_MeleeSlash extends RODamageType;

var ParticleSystem  HitEffectTemplate;

/* Used for melee collision with environment */
static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
    //local ParticleSystemComponent Emitter;

    if ( P.WorldInfo.NetMode != NM_DedicatedServer && P.Mesh != none )
    {
        P.WorldInfo.MyEmitterPool.SpawnEmitter(default.HitEffectTemplate, HitLocation, rotator(Momentum), P);
    }
}

/** Check to see if we should call LeaveABodyWoundDecal for this damage */
static function bool ShouldLeaveBodyWoundDecal()
{
    return true;
}

DefaultProperties
{
    bTrackHits=false
    KDamageImpulse=375

    HitEffectTemplate=ParticleSystem'FX_WEP_Gun_Three.Impacts.FX_WEP_Gun_A_Melee_Impact_World'
}
