class ZMC4ExplosiveProjectile extends RORemoteExplosiveProjectile;

DefaultProperties
{
    TossZ=140.0//130.0//150.0
    UnderhandTossZ=80//100

    Damage=500 // Might need to play with this value.
    DamageRadius=1500//1000// this is the ro2 satchel radius, we should use this as a safe base //500 // 10M. (1M = 50uu's).
    RadialDamageFalloffExponent=3.0 // Might need to play with this value.

    Speed=0//500//300
    MinSpeed=0//450//350
    MaxSpeed=0//750//450
    MinTossSpeed=0
    MaxTossSpeed=0

    Bounces=0//3//10

    MyDamageType=class'RODmgType_C4_Explosive'

    TacticalIcon=Texture2D'VN_UI_Textures.HUD.DeathMessage.UI_Kill_Icon_C4'

    DecalHeight=1500
    DecalWidth=1500

    Begin Object Name=CollisionCylinder
    CollisionRadius=0//18uu diameter - should prevent the C4 from getting thrown into obsecurely small locations
    CollisionHeight=0//3
    AlwaysLoadOnClient=True
    AlwaysLoadOnServer=True
    End Object

    Begin Object Name=ThowableMeshComponent
        SkeletalMesh=None
        PhysicsAsset=None
    End Object

    DampenFactor=0.22 //0.05
    DampenFactorParallel=0.2//0.8
    AccelRate = 1.0;
    ShakeScale=3.0//2.3
    //MaxSuppressBlurDuration=10.0
    SuppressBlurScalar=1.0
    SuppressAnimationScalar=0.5
    ExplodeExposureScale=0.6

    MomentumTransfer=50000

    bAllowFluidSurfaceInteraction=true
}
