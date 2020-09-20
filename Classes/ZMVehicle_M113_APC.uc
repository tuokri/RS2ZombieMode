class ZMVehicle_M113_APC extends ROVehicleTransport
    abstract;


var array<MaterialInstanceConstant> ReplacedInteriorMICs;
var MaterialInstanceConstant        InteriorMICs[2];        // 0 = ...
var bool                            bGeneratedInteriorMICs;

var array<MaterialInstanceConstant> ReplacedExteriorMICs;
var MaterialInstanceConstant        ExteriorMICs[2];        // 0 = Exterior Texture...
var bool                            bGeneratedExteriorMICs;

var MaterialInterface DestroyedMaterial2;
var MaterialInterface DestroyedMaterial3;

var StaticMeshComponent     ExtExtraMesh;


// Replicated information about the passenger positions
var repnotify byte PassengerOneCurrentPositionIndex;
var repnotify bool bDrivingPassengerOne;
var repnotify byte PassengerTwoCurrentPositionIndex;
var repnotify bool bDrivingPassengerTwo;
var repnotify byte PassengerThreeCurrentPositionIndex;
var repnotify bool bDrivingPassengerThree;
var repnotify byte PassengerFourCurrentPositionIndex;
var repnotify bool bDrivingPassengerFour;

/** Seat proxy death hit info */
var repnotify TakeHitInfo DeathHitInfo_ProxyDriver;
var repnotify TakeHitInfo DeathHitInfo_ProxyHullMG;
var repnotify TakeHitInfo DeathHitInfo_ProxyPassOne;
var repnotify TakeHitInfo DeathHitInfo_ProxyPassTwo;
var repnotify TakeHitInfo DeathHitInfo_ProxyPassThree;
var repnotify TakeHitInfo DeathHitInfo_ProxyPassFour;

var(Periscope) const ROSceneCapture2DDPGComponent SceneCapture2;
var TextureRenderTarget2D PeriscopeTextureTarget2;
var const MaterialInstanceConstant PeriscopeLenseMICTemplate2;
var MaterialInstanceConstant PeriscopeLenseMIC2;
var(Periscope) name InterpParamName;


replication
{
    if (bNetDirty)
        PassengerOneCurrentPositionIndex, PassengerTwoCurrentPositionIndex,
        PassengerThreeCurrentPositionIndex, PassengerFourCurrentPositionIndex,
        bDrivingPassengerOne,bDrivingPassengerTwo,bDrivingPassengerThree,
        bDrivingPassengerFour;

    if (bNetDirty)
        DeathHitInfo_ProxyDriver, DeathHitInfo_ProxyHullMG, DeathHitInfo_ProxyPassOne,
        DeathHitInfo_ProxyPassTwo, DeathHitInfo_ProxyPassThree, DeathHitInfo_ProxyPassFour;
}


simulated event PostBeginPlay()
{
    local int i;

    super.PostBeginPlay();

    if ( !bGeneratedExteriorMICs )
    {
        ReplacedExteriorMICs.AddItem(MaterialInstanceConstant(Mesh.GetMaterial(0)));

        for ( i = 0; i < ReplacedExteriorMICs.Length; i++ )
        {
            ExteriorMICs[i] = new class'MaterialInstanceConstant';
            ExteriorMICs[i].SetParent(ReplacedExteriorMICs[i]);
        }

        ReplaceExteriorMICs(GetVehicleMeshAttachment('ExtBodyComponent'));
        ReplaceExteriorMICs(Mesh);

        bGeneratedExteriorMICs = true;
    }

    if ( !bGeneratedInteriorMICs )
    {
        ReplacedInteriorMICs.AddItem(MaterialInstanceConstant(GetVehicleMeshAttachment('IntBodyComponent').GetMaterial(0)));

        for ( i = 0; i < ReplacedInteriorMICs.Length; i++ )
        {
            InteriorMICs[i] = new class'MaterialInstanceConstant';
            InteriorMICs[i].SetParent(ReplacedInteriorMICs[i]);
        }

        // Replace MIC for vehicle skeletal mesh
        ReplaceInteriorMICs(mesh);

        // Replace MIC for the interior static mesh attachments
        ReplaceInteriorMICs(GetVehicleMeshAttachment('IntBodyComponent'));

        bGeneratedInteriorMICs = true;
    }

    if( WorldInfo.NetMode != NM_DedicatedServer )
    {
        mesh.MinLodModel = 1;

        Mesh.AttachComponent(ExtExtraMesh, 'chassis');

        ExtExtraMesh.SetShadowParent(Mesh);
    }
}

/**
 * This event is triggered when a repnotify variable is received
 *
 * @param   VarName     The name of the variable replicated
 */
simulated event ReplicatedEvent(name VarName)
{
    if (VarName == 'DeathHitInfo_ProxyDriver')
    {
        PlaySeatProxyDeathHitEffects(0, DeathHitInfo_ProxyDriver);
    }
    else if (VarName == 'DeathHitInfo_ProxyHullMG')
    {
        PlaySeatProxyDeathHitEffects(1, DeathHitInfo_ProxyHullMG);
    }
    else if (VarName == 'DeathHitInfo_ProxyPassOne')
    {
        PlaySeatProxyDeathHitEffects(2, DeathHitInfo_ProxyPassOne);
    }
    else if (VarName == 'DeathHitInfo_ProxyPassTwo')
    {
        PlaySeatProxyDeathHitEffects(3, DeathHitInfo_ProxyPassTwo);
    }
    else if (VarName == 'DeathHitInfo_ProxyPassThree')
    {
        PlaySeatProxyDeathHitEffects(4, DeathHitInfo_ProxyPassThree);
    }
    else if (VarName == 'DeathHitInfo_ProxyPassFour')
    {
        PlaySeatProxyDeathHitEffects(5, DeathHitInfo_ProxyPassFour);
    }
    else
    {
       super.ReplicatedEvent(VarName);
    }
}

/** Turn the vehicle interior visibility on or off. */
simulated function SetInteriorVisibility(bool bVisible)
{
    local int i;

    super.SetInteriorVisibility(bVisible);

    if ( bVisible && !bGeneratedInteriorMICs )
    {
        ReplacedInteriorMICs.AddItem(MaterialInstanceConstant(GetVehicleMeshAttachment('IntBodyComponent').GetMaterial(0)));

        for ( i = 0; i < ReplacedInteriorMICs.Length; i++ )
        {
            InteriorMICs[i] = new class'MaterialInstanceConstant';
            InteriorMICs[i].SetParent(ReplacedInteriorMICs[i]);
        }

        // Replace MIC for vehicle skeletal mesh
        ReplaceInteriorMICs(mesh);

        // Replace MIC for the interior static mesh attachments
        ReplaceInteriorMICs(GetVehicleMeshAttachment('IntBodyComponent'));

        bGeneratedInteriorMICs = true;
    }
}

simulated function ReplaceInteriorMICs(MeshComponent MeshComp)
{
    local MaterialInterface MeshMaterial;
    local int i, j;

    for ( i = 0; i < MeshComp.GetNumElements(); i++ )
    {
        MeshMaterial = MeshComp.GetMaterial(i);

        if ( MeshMaterial != none )
        {
            for ( j = 0; j < ReplacedInteriorMICs.Length; j++ )
            {
                if ( MeshMaterial == ReplacedInteriorMICs[j] )
                {
                    MeshComp.SetMaterial(i, InteriorMICs[j]);
                }
            }
        }
    }
}

simulated function ReplaceExteriorMICs(MeshComponent MeshComp)
{
    local MaterialInterface MeshMaterial;
    local int i, j;

    for ( i = 0; i < MeshComp.GetNumElements(); i++ )
    {
        MeshMaterial = MeshComp.GetMaterial(i);

        if ( MeshMaterial != none )
        {
            for ( j = 0; j < ReplacedExteriorMICs.Length; j++ )
            {
                if ( MeshMaterial == ReplacedExteriorMICs[j] )
                {
                    MeshComp.SetMaterial(i, ExteriorMICs[j]);
                }
            }
        }
    }
}

/** Leave blood splats on a specific area in a vehicle
 * @param InSeatIndex The seat around which we should leave blood splats
 */
simulated function LeaveBloodSplats(int InSeatIndex)
{
    if( InSeatIndex < Seats.Length )
    {
        // This vehicle only has one interior mesh with a single MIC index
        InteriorMICs[0].SetScalarParameterValue(Seats[InSeatIndex].VehicleBloodMICParameterName, 1.0);
        // This vehicle is open, so set gore on exterior mesh as well for external viewers
        ExteriorMICs[0].SetScalarParameterValue(Seats[InSeatIndex].VehicleBloodMICParameterName, 1.0);
    }
}

// Overridden to switch to the 6th seat position instead of changing fire mode
simulated exec function SwitchFireMode()
{
    ServerChangeSeat(5);
}

// UC has unusual texture slots for the destroyed mesh. Handle it here.
simulated state DyingVehicle
{
    /** client-side only effects */
    simulated function PlayDeathEffects()
    {
        SwapToDestroyedMesh();

        if ( DestroyedMaterial != none )
        {
            Mesh.SetMaterial(0, DestroyedMaterial);
        }

        if ( DestroyedMaterial2 != none )
        {
            Mesh.SetMaterial(3, DestroyedMaterial2);
        }

        if ( DestroyedMaterial3 != none )
        {
            Mesh.SetMaterial(4, DestroyedMaterial3);
        }

        PlayVehicleExplosion(false);

        VehicleEvent('Destroyed');
    }
}

/**
 * Handle giving damage to seat proxies
 * @param SeatProxyIndex the Index in the SeatProxies array of the Proxy to Damage
 * @param Damage the base damage to apply
 * @param InstigatedBy the Controller responsible for the damage
 * @param HitLocation world location where the hit occurred
 * @param Momentum force caused by this hit
 * @param DamageType class describing the damage that was done
 * @param DamageCauser the Actor that directly caused the damage (i.e. the Projectile that exploded, the Weapon that fired, etc)
 */
function DamageSeatProxy(int SeatProxyIndex, int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional Actor DamageCauser)
{
    // Update the hit info for each seat proxy pertaining to this vehicle
    switch( SeatProxyIndex )
    {
    case 0:
        // Driver
        DeathHitInfo_ProxyDriver.Damage = Damage;
        DeathHitInfo_ProxyDriver.HitLocation = HitLocation;
        DeathHitInfo_ProxyDriver.Momentum = Momentum;
        DeathHitInfo_ProxyDriver.DamageType = DamageType;
        break;
    case 1:
        // HullMG
        DeathHitInfo_ProxyHullMG.Damage = Damage;
        DeathHitInfo_ProxyHullMG.HitLocation = HitLocation;
        DeathHitInfo_ProxyHullMG.Momentum = Momentum;
        DeathHitInfo_ProxyHullMG.DamageType = DamageType;
        break;
    case 2:
        // Passenger One
        DeathHitInfo_ProxyPassOne.Damage = Damage;
        DeathHitInfo_ProxyPassOne.HitLocation = HitLocation;
        DeathHitInfo_ProxyPassOne.Momentum = Momentum;
        DeathHitInfo_ProxyPassOne.DamageType = DamageType;
        break;
    case 3:
        // Passenger Two
        DeathHitInfo_ProxyPassTwo.Damage = Damage;
        DeathHitInfo_ProxyPassTwo.HitLocation = HitLocation;
        DeathHitInfo_ProxyPassTwo.Momentum = Momentum;
        DeathHitInfo_ProxyPassTwo.DamageType = DamageType;
        break;
    case 4:
        // Passenger Three
        DeathHitInfo_ProxyPassThree.Damage = Damage;
        DeathHitInfo_ProxyPassThree.HitLocation = HitLocation;
        DeathHitInfo_ProxyPassThree.Momentum = Momentum;
        DeathHitInfo_ProxyPassThree.DamageType = DamageType;
        break;
    case 5:
        // Passenger Four
        DeathHitInfo_ProxyPassFour.Damage = Damage;
        DeathHitInfo_ProxyPassFour.HitLocation = HitLocation;
        DeathHitInfo_ProxyPassFour.Momentum = Momentum;
        DeathHitInfo_ProxyPassFour.DamageType = DamageType;
        break;
    }

    // Call super!
    Super.DamageSeatProxy(SeatProxyIndex, Damage, InstigatedBy, HitLocation, Momentum, DamageType, DamageCauser);
}

DefaultProperties
{
    Health=600
    Team=`ALLIES_TEAM_INDEX

    bOpenVehicle=true
    //bUseLoopedMGSound=false

    ExitRadius=180

    Begin Object Name=CollisionCylinder
        CollisionHeight=60.0
        CollisionRadius=200.0
        Translation=(X=0.0,Y=0.0,Z=0.0)
    End Object
    CylinderComponent=CollisionCylinder

    bDontUseCollCylinderForRelevancyCheck=true
    RelevancyHeight=70.0
    RelevancyRadius=130.0

    Begin Object class=PointLightComponent name=InteriorLight_0
        Radius=100.0
        LightColor=(R=255,G=170,B=130)
        UseDirectLightMap=FALSE
        Brightness=0.3 // 1.0
        LightingChannels=(Unnamed_1=TRUE,BSP=FALSE,Static=FALSE,Dynamic=FALSE,CompositeDynamic=FALSE)
    End Object

    Begin Object class=PointLightComponent name=InteriorLight_1
        Radius=100.0
        LightColor=(R=255,G=170,B=130)
        UseDirectLightMap=FALSE
        Brightness=0.3 // 1.0
        LightingChannels=(Unnamed_1=TRUE,BSP=FALSE,Static=FALSE,Dynamic=FALSE,CompositeDynamic=FALSE)
    End Object

    // TODO - See if these are actually needed - Ramm
    VehicleLights(0)={(AttachmentName=InteriorLightComponent0,Component=InteriorLight_0,bAttachToSocket=true,AttachmentTargetName=interior_light_0)}
    VehicleLights(1)={(AttachmentName=InteriorLightComponent1,Component=InteriorLight_1,bAttachToSocket=true,AttachmentTargetName=interior_light_1)}


    // SRS - Commenting this out because of the ROGameContent system. Move this to child class when created


    Seats(0)={( CameraTag=none,
            CameraOffset=-420,
            SeatAnimBlendName=DriverPositionNode,
            SeatPositions=( (bDriverVisible=true,bAllowFocus=true,PositionCameraTag=None,ViewFOV=70.0,PositionUpAnim=Driver_Peek_TO_Idle,PositionIdleAnim=Driver_idle,DriverIdleAnim=Driver_idle,AlternateIdleAnim=Driver_idle,SeatProxyIndex=0,
                                    bIsExterior=true,
                                    LeftHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_DriverLeftBrake,DefaultEffectorRotationTargetName=IK_DriverLeftBrake),
                                    RightHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_DriverRightBrake,DefaultEffectorRotationTargetName=IK_DriverRightBrake),
                                    LeftFootIKInfo=(PinEnabled=true),
                                    RightFootIKInfo=(PinEnabled=true),
                                    HipsIKInfo=(PinEnabled=true),
                                    PositionFlinchAnims=(Driver_idle),
                                    PositionDeathAnims=(Driver_Death)),
                            (bDriverVisible=true,bAllowFocus=true,PositionCameraTag=None,ViewFOV=70.0,PositionDownAnim=Driver_idle_TO_Peek,PositionIdleAnim=Driver_Peek_Idle,DriverIdleAnim=Driver_Peek_Idle,AlternateIdleAnim=Driver_Peek_Idle,SeatProxyIndex=0,
                                    bIsExterior=true,
                                    LeftHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_DriverLeftBrake,DefaultEffectorRotationTargetName=IK_DriverLeftBrake),
                                    RightHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_DriverRightBrake,DefaultEffectorRotationTargetName=IK_DriverRightBrake),
                                    LeftFootIKInfo=(PinEnabled=true),
                                    RightFootIKInfo=(PinEnabled=true),
                                    HipsIKInfo=(PinEnabled=true),
                                    PositionFlinchAnims=(Driver_Peek_Idle),
                                    PositionDeathAnims=(Driver_Peek_Death))),
            bSeatVisible=true,
            SeatBone=Root_Driver,
            DriverDamageMult=1.0,
            InitialPositionIndex=0,
            SeatRotation=(Pitch=0,Yaw=0,Roll=0),
            VehicleBloodMICParameterName=Gore03,
            )}

    Seats(1)={( GunClass=class'ZMVWeap_APC_HullMG',
                // Modified.
                // SightOverlayTexture=Texture2D'ui_textures.VehicleOptics.ui_hud_vehicle_optics_mg',
                // VignetteOverlayTexture=Texture2D'ui_textures.VehicleOptics.ui_hud_vehicle_optics_vignette',

                GunSocket=(MG_Barrel),
                GunPivotPoints=(MG_Pitch),
                TurretControls=(MG_Rot_Yaw,MG_Rot_Pitch),
                CameraTag=None,
                CameraOffset=-420,
                SeatAnimBlendName=HullMGPositionNode,
                SeatPositions=((bDriverVisible=true,bAllowFocus=true,PositionCameraTag=none,ViewFOV=0.0,
                                    bIsExterior=true, bIgnoreWeapon=true,bRotateGunOnCommand=true,
                                    PositionUpAnim=MG_Hull_Idle_TO_Duck,PositionIdleAnim=MG_Hull_Duck_Idle,DriverIdleAnim=MG_Hull_Duck_Idle,AlternateIdleAnim=MG_Hull_Duck_Idle,SeatProxyIndex=1,
                                    LeftHandIKInfo=(PinEnabled=true),
                                    RightHandIKInfo=(PinEnabled=true),
                                    HipsIKInfo=(PinEnabled=true),
                                    LeftFootIKInfo=(PinEnabled=true),
                                    RightFootIKInfo=(PinEnabled=true),
                                    PositionFlinchAnims=(MG_Hull_Duck_Idle),
                                    PositionDeathAnims=(MG_Hull_Duck_Death),
                                    ChestIKInfo=(PinEnabled=true)),
                                // Above gun sights
                                (bDriverVisible=true,bAllowFocus=true,PositionCameraTag=MG_Camera_High,ViewFOV=0.0,bCamRotationFollowSocket=true,bViewFromCameraTag=true,bUseDOF=true,
                                    bIsExterior=true,
                                    PositionUpAnim=MG_Hull_Idle_AI,PositionDownAnim=MG_Hull_Duck_TO_Idle,PositionIdleAnim=MG_Hull_Idle,bConstrainRotation=false,YawContraintIndex=0,PitchContraintIndex=1,DriverIdleAnim=MG_Hull_Idle,AlternateIdleAnim=MG_Hull_Idle,SeatProxyIndex=1,
                                    LeftHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_HullMGLeftHand,DefaultEffectorRotationTargetName=IK_HullMGLeftHand),
                                    RightHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_HullMGRightHand,DefaultEffectorRotationTargetName=IK_HullMGRightHand),
                                    HipsIKInfo=(PinEnabled=true),
                                    LeftFootIKInfo=(PinEnabled=true),
                                    RightFootIKInfo=(PinEnabled=true),
                                    PositionFlinchAnims=(MG_Hull_Idle),
                                    PositionDeathAnims=(MG_Hull_Death),
                                    ChestIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_HullMGChest,DefaultEffectorRotationTargetName=IK_HullMGChest)),
                                // Gun sights
                                (bDriverVisible=true,bAllowFocus=true,PositionCameraTag=MG_Camera,ViewFOV=45,bCamRotationFollowSocket=true,bViewFromCameraTag=true,bUseDOF=true,
                                    bIsExterior=true,
                                    PositionDownAnim=MG_Hull_Idle_AI,PositionIdleAnim=MG_Hull_Idle,bConstrainRotation=false,YawContraintIndex=0,PitchContraintIndex=1,DriverIdleAnim=MG_Hull_Idle,AlternateIdleAnim=MG_Hull_Idle,SeatProxyIndex=1,
                                    LeftHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_HullMGLeftHand,DefaultEffectorRotationTargetName=IK_HullMGLeftHand),
                                    RightHandIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_HullMGRightHand,DefaultEffectorRotationTargetName=IK_HullMGRightHand),
                                    HipsIKInfo=(PinEnabled=true),
                                    LeftFootIKInfo=(PinEnabled=true),
                                    RightFootIKInfo=(PinEnabled=true),
                                    PositionFlinchAnims=(MG_Hull_Idle),
                                    PositionDeathAnims=(MG_Hull_Death),
                                    ChestIKInfo=(IKEnabled=true,DefaultEffectorLocationTargetName=IK_HullMGChest,DefaultEffectorRotationTargetName=IK_HullMGChest))),
                TurretVarPrefix="HullMG",
                bSeatVisible=true,
                SeatBone=Root_MG,
                DriverDamageMult=1.0,
                InitialPositionIndex=2,
                FiringPositionIndex=2,
                SeatRotation=(Pitch=0,Yaw=0,Roll=0),
                WeaponRotation=(Pitch=0,Yaw=16384,Roll=0),
                VehicleBloodMICParameterName=Gore02,
                TracerFrequency=5,
                WeaponTracerClass=(class'M2BulletTracer',class'M2BulletTracer'),
                MuzzleFlashLightClass=(class'ROVehicleMGMuzzleFlashLight',class'ROVehicleMGMuzzleFlashLight') // (none, none),
                )}

    Seats(2)={( CameraTag=None,
        CameraOffset=-420,
        SeatAnimBlendName=Pass1PositionNode,
        SeatPositions=((bDriverVisible=true,bIsExterior=true,bAllowFocus=true,PositionCameraTag=none,ViewFOV=0.0,PositionIdleAnim=Pass01_Idle,DriverIdleAnim=Pass01_Idle,AlternateIdleAnim=Pass01_Idle,SeatProxyIndex=2,
                            bIsExterior=true,
                            PositionFlinchAnims=(Pass01_Idle),
                            PositionDeathAnims=(Pass01_Death))
                        ),
        TurretVarPrefix="PassengerOne",
        bSeatVisible=true,
        DriverDamageMult=1.0,
        InitialPositionIndex=0,
        SeatRotation=(Pitch=0,Yaw=0,Roll=0),
        SeatBone=Root_Pass01,
        VehicleBloodMICParameterName=Gore02,
        )}

    Seats(3)={( CameraTag=None,
        CameraOffset=-420,
        SeatAnimBlendName=Pass2PositionNode,
        SeatPositions=((bDriverVisible=true,bIsExterior=true,bAllowFocus=true,PositionCameraTag=none,ViewFOV=0.0,PositionIdleAnim=Pass02_Idle,DriverIdleAnim=Pass02_Idle,AlternateIdleAnim=Pass02_Idle,SeatProxyIndex=3,
                            bIsExterior=true,
                            PositionFlinchAnims=(Pass02_Idle),
                            PositionDeathAnims=(Pass02_Death))
                        ),
        TurretVarPrefix="PassengerTwo",
        bSeatVisible=true,
        DriverDamageMult=1.0,
        InitialPositionIndex=0,
        SeatRotation=(Pitch=0,Yaw=0,Roll=0),
        SeatBone=Root_Pass02,
        VehicleBloodMICParameterName=Gore02,
        )}

    Seats(4)={( CameraTag=None,
        CameraOffset=-420,
        SeatAnimBlendName=Pass3PositionNode,
        SeatPositions=((bDriverVisible=true,bIsExterior=true,bAllowFocus=true,PositionCameraTag=none,ViewFOV=0.0,PositionIdleAnim=Pass03_Idle,DriverIdleAnim=Pass03_Idle,AlternateIdleAnim=Pass03_Idle,SeatProxyIndex=4,
                            bIsExterior=true,
                            PositionFlinchAnims=(Pass03_Idle),
                            PositionDeathAnims=(Pass03_Death))
                        ),
        TurretVarPrefix="PassengerThree",
        bSeatVisible=true,
        DriverDamageMult=1.0,
        InitialPositionIndex=0,
        SeatRotation=(Pitch=0,Yaw=0,Roll=0),
        SeatBone=Root_Pass03,
        VehicleBloodMICParameterName=Gore02,
        )}

    Seats(5)={( CameraTag=None,
        CameraOffset=-420,
        SeatAnimBlendName=Pass4PositionNode,
        SeatPositions=((bDriverVisible=true,bIsExterior=true,bAllowFocus=true,PositionCameraTag=none,ViewFOV=0.0,PositionIdleAnim=Pass04_Idle,DriverIdleAnim=Pass04_Idle,AlternateIdleAnim=Pass04_Idle,SeatProxyIndex=5,
                            bIsExterior=true,
                            PositionFlinchAnims=(Pass04_Idle),
                            PositionDeathAnims=(Pass04_Death))
                        ),
        TurretVarPrefix="PassengerFour",
        bSeatVisible=true,
        DriverDamageMult=1.0,
        InitialPositionIndex=0,
        SeatRotation=(Pitch=0,Yaw=0,Roll=0),
        SeatBone=Root_Pass04,
        VehicleBloodMICParameterName=Gore02,
        )}

    PassengerAnimTree=AnimTree'CHR_Playeranimtree_Master.CHR_Tanker_animtree'
    CrewAnimSet=AnimSet'VH_VN_ARVN_M113_APC.Anim.CHR_M113_Anim_Master'

    LeftWheels(0)="L1_Wheel_Static"
    LeftWheels(1)="L2_Wheel"
    LeftWheels(2)="L3_Wheel"
    LeftWheels(3)="L4_Wheel"
    LeftWheels(4)="L5_Wheel"
    LeftWheels(5)="L6_Wheel"
    LeftWheels(6)="L7_Wheel_Static"
    //
    RightWheels(0)="R1_Wheel_Static"
    RightWheels(1)="R2_Wheel"
    RightWheels(2)="R3_Wheel"
    RightWheels(3)="R4_Wheel"
    RightWheels(4)="R5_Wheel"
    RightWheels(5)="R6_Wheel"
    RightWheels(6)="R7_Wheel_Static"

/** Physics Wheels */

    // Right Rear Wheel
    Begin Object Name=RRWheel
        BoneName="R_Wheel_06"
        BoneOffset=(X=-10.0,Y=0,Z=0.0)
        WheelRadius=20
    End Object

    // Right middle wheel
    Begin Object Name=RMWheel
        BoneName="R_Wheel_04"
        BoneOffset=(X=0.0,Y=0,Z=0.0)
        WheelRadius=20
    End Object

    // Right Front Wheel
    Begin Object Name=RFWheel
        BoneName="R_Wheel_02"
        BoneOffset=(X=0.0,Y=0,Z=2.0)
        WheelRadius=20
    End Object

    // Left Rear Wheel
    Begin Object Name=LRWheel
        BoneName="L_Wheel_06"
        BoneOffset=(X=-10.0,Y=0,Z=0.0)
        WheelRadius=20
    End Object

    // Left Middle Wheel
    Begin Object Name=LMWheel
        BoneName="L_Wheel_04"
        BoneOffset=(X=0.0,Y=0,Z=0.0)
        WheelRadius=20
    End Object

    // Left Front Wheel
    Begin Object Name=LFWheel
        BoneName="L_Wheel_02"
        BoneOffset=(X=0.0,Y=0,Z=2.0)
        WheelRadius=20
    End Object

    Begin Object Name=SimObject
        WheelSuspensionStiffness=325
        WheelSuspensionDamping=25.0
        // Transmission - GearData
        GearArray(0)={(
            GearRatio=-5.64,
            AccelRate=10.25,
            TorqueCurve=(Points={(
                (InVal=0,OutVal=-2100),
                (InVal=300,OutVal=-700),
                (InVal=2800,OutVal=-2100),
                (InVal=3000,OutVal=-700),
                (InVal=3200,OutVal=-0.0)
                )}),
            TurningThrottle=1.0
            )}
        GearArray(1)={(
            // [N/A]  reserved for neutral
            )}
        GearArray(2)={(
            // Real world - [4.22] ~10.0 kph
            GearRatio=4.22,
            AccelRate=7.60,
            TorqueCurve=(Points={(
                (InVal=0,OutVal=2500),
                (InVal=300,OutVal=1800),
                (InVal=2800,OutVal=4000),
                (InVal=3000,OutVal=1000),
                (InVal=3200,OutVal=0.0)
                )}),
            TurningThrottle=1.0
            )}
        GearArray(3)={(
            // Real world - [2.1] ~20.0 kph
            GearRatio=2.1,
            AccelRate=9.20,
            TorqueCurve=(Points={(
                (InVal=0,OutVal=3000),
                (InVal=2800,OutVal=6200),
                (InVal=3000,OutVal=2000),
                (InVal=3200,OutVal=0.0)
                )}),
            TurningThrottle=1.0
            )}
        GearArray(4)={(
            // Real world - [1.4] ~30.0 kph
            GearRatio=1.4,
            AccelRate=9.70,
            TorqueCurve=(Points={(
                (InVal=0,OutVal=3500),
                (InVal=2800,OutVal=9000),
                (InVal=3000,OutVal=3500),
                (InVal=3200,OutVal=0.0)
                )}),
            TurningThrottle=1.0
            )}
        GearArray(5)={(
            // Real world - [1.05] ~40.0 kph
            GearRatio=1.05,
            AccelRate=10.20,
            TorqueCurve=(Points={(
                (InVal=0,OutVal=5000),
                (InVal=2800,OutVal=11700),
                (InVal=3000,OutVal=6000),
                (InVal=3200,OutVal=0.0)
                )}),
            TurningThrottle=1.0
            )}
        // Transmission - Misc
        FirstForwardGear=2
    End Object

    bInfantryCanUse=true

    DrivingPhysicalMaterial=PhysicalMaterial'VH_VN_ARVN_M113_APC.Phys.M113_PhysMat_Moving'
    DefaultPhysicalMaterial=PhysicalMaterial'VH_VN_ARVN_M113_APC.Phys.M113_PhysMat'

    TreadSpeedParameterName=Tank_Tread_Speed
    TrackSoundParamScale=0.000033
    TreadSpeedScale=2.5

    RPM3DGaugeMaxAngle=-43690
    EngineIdleRPM=100
    EngineNormalRPM=2000
    EngineMaxRPM=4000
    Speedo3DGaugeMaxAngle=-67215//-43690 // HUD speedo goes to 100, physical only does 65 (40mph), so divide this value by 0.65
    EngineOil3DGaugeMinAngle=-16384
    EngineOil3DGaugeMaxAngle=-43690
    EngineOil3DGaugeDamageAngle=-8192
    GearboxOil3DGaugeMinAngle=-15000
    GearboxOil3DGaugeNormalAngle=-22500
    GearboxOil3DGaugeMaxAngle=-43690
    GearboxOil3DGaugeDamageAngle=-5000
    EngineTemp3DGaugeNormalAngle=-16384
    EngineTemp3DGaugeEngineDamagedAngle=-22500
    EngineTemp3DGaugeFireDamagedAngle=-28250
    EngineTemp3DGaugeFireDestroyedAngle=-32580

    // // Muzzle Flashes
    VehicleEffects(TankVFX_Firing1)=(EffectStartTag=UCHullMG,EffectTemplate=ParticleSystem'FX_VN_Weapons.MuzzleFlashes.FX_VN_MuzzleFlash_3rdP_DShK',EffectSocket=MG_Barrel)
    // // Driving effects
    // VehicleEffects(TankVFX_Exhaust)=(EffectStartTag=EngineStart,EffectEndTag=EngineStop,EffectTemplate=ParticleSystem'FX_Vehicles_Two.UniversalCarrier.FX_UnivCarrier_exhaust',EffectSocket=Exhaust)
    // VehicleEffects(TankVFX_TreadWing)=(EffectStartTag=EngineStart,EffectEndTag=EngineStop,bStayActive=true,EffectTemplate=ParticleSystem'FX_VEH_Tank_Three.FX_VEH_Tank_A_Wing_Dirt_T34',EffectSocket=attachments_body_ground)
    // // Damage
    // VehicleEffects(TankVFX_DmgSmoke)=(EffectStartTag=DamageSmoke,EffectEndTag=NoDamageSmoke,bRestartRunning=false,EffectTemplate=ParticleSystem'FX_Vehicles_Two.UniversalCarrier.FX_UnivCarrier_damaged_burning',EffectSocket=attachments_body)
    // VehicleEffects(TankVFX_DmgInterior)=(EffectStartTag=DamageInterior,EffectEndTag=NoInternalSmoke,bRestartRunning=false,bInteriorEffect=true,EffectTemplate=ParticleSystem'FX_VEH_Tank_Two.FX_VEH_Tank_Interior_Penetrate',EffectSocket=attachments_body)
    // Death
    VehicleEffects(TankVFX_DeathSmoke1)=(EffectStartTag=Destroyed,EffectEndTag=NoDeathSmoke,EffectTemplate=ParticleSystem'FX_VN_Helicopters.Emitter.FX_VN_HelicopterBurning',EffectSocket=FX_Fire)
    // VehicleEffects(TankVFX_DeathSmoke2)=(EffectStartTag=Destroyed,EffectEndTag=NoDeathSmoke,EffectTemplate=ParticleSystem'FX_VEH_Tank_Two.FX_VEH_Tank_A_SmallSmoke',EffectSocket=FX_Smoke_2)
    // VehicleEffects(TankVFX_DeathSmoke3)=(EffectStartTag=Destroyed,EffectEndTag=NoDeathSmoke,EffectTemplate=ParticleSystem'FX_VEH_Tank_Two.FX_VEH_Tank_A_SmallSmoke',EffectSocket=FX_Smoke_3)

    BigExplosionSocket=FX_Fire
    ExplosionTemplate=ParticleSystem'FX_VN_Helicopters.Emitter.FX_VN_HelicopterExplosion'

    ExplosionDamageType=class'RODmgType_VehicleExplosion'
    ExplosionDamage=100.0
    ExplosionRadius=300.0
    ExplosionMomentum=60000
    ExplosionInAirAngVel=1.5
    InnerExplosionShakeRadius=400.0
    OuterExplosionShakeRadius=1000.0
    ExplosionLightClass=class'ROGame.ROGrenadeExplosionLight' // None
    MaxExplosionLightDistance=4000.0
    TimeTilSecondaryVehicleExplosion=0//2.0f
    SecondaryExplosion=none//ParticleSystem'FX_VEH_Tank_Two.FX_VEH_Tank_C_Explosion_Ammo'
    bHasTurretExplosion=false

    EngineStartOffsetSecs=2.0
    EngineStopOffsetSecs=0.5

    ArmorTextureOffsets(0)=(PositionOffset=(X=36,Y=-3,Z=0),MySizeX=68,MYSizeY=68)
    ArmorTextureOffsets(1)=(PositionOffset=(X=36,Y=74,Z=0),MySizeX=68,MYSizeY=68)
    ArmorTextureOffsets(2)=(PositionOffset=(X=43,Y=35,Z=0),MySizeX=16,MYSizeY=74)
    ArmorTextureOffsets(3)=(PositionOffset=(X=82,Y=35,Z=0),MySizeX=16,MYSizeY=74)

    SprocketTextureOffsets(0)=(PositionOffset=(X=46,Y=102,Z=0),MySizeX=8,MYSizeY=16)
    SprocketTextureOffsets(1)=(PositionOffset=(X=88,Y=102,Z=0),MySizeX=8,MYSizeY=16)

    TransmissionTextureOffset=(PositionOffset=(X=52,Y=90,Z=0),MySizeX=38,MYSizeY=36)

    TreadTextureOffsets(0)=(PositionOffset=(X=37,Y=35,Z=0),MySizeX=8,MYSizeY=80)
    TreadTextureOffsets(1)=(PositionOffset=(X=95,Y=35,Z=0),MySizeX=8,MYSizeY=80)

    //AmmoStorageTextureOffsets(0)=(PositionOffset=(X=41,Y=56,Z=0),MySizeX=16,MYSizeY=16)
    //AmmoStorageTextureOffsets(1)=(PositionOffset=(X=82,Y=56,Z=0),MySizeX=16,MYSizeY=16)

    FuelTankTextureOffsets(0)=(PositionOffset=(X=45,Y=78,Z=0),MySizeX=16,MYSizeY=16)
    FuelTankTextureOffsets(1)=(PositionOffset=(X=80,Y=78,Z=0),MySizeX=16,MYSizeY=16)

    EngineTextureOffset=(PositionOffset=(X=58,Y=73,Z=0),MySizeX=24,MYSizeY=24)

    //CoaxMGTextureOffset=(PositionOffset=(X=+3,Y=-26,Z=0),MySizeX=6,MYSizeY=14)

    SeatTextureOffsets(0)=(PositionOffSet=(X=+10,Y=-22,Z=0),bTurretPosition=0)
    SeatTextureOffsets(1)=(PositionOffSet=(X=-9,Y=-22,Z=0),bTurretPosition=0)
    SeatTextureOffsets(2)=(PositionOffSet=(X=-11,Y=-1,Z=0),bTurretPosition=0)
    SeatTextureOffsets(3)=(PositionOffSet=(X=11,Y=-1,Z=0),bTurretPosition=0)
    SeatTextureOffsets(4)=(PositionOffSet=(X=-11,Y=23,Z=0),bTurretPosition=0)
    SeatTextureOffsets(5)=(PositionOffSet=(X=11,Y=23,Z=0),bTurretPosition=0)

    SpeedoMinDegree=5461
    SpeedoMaxDegree=56000
    SpeedoMaxSpeed=1365 //100 km/h

    // CabinL_FXSocket=Sound_Cabin_L
    // CabinR_FXSocket=Sound_Cabin_R
    // Exhaust_FXSocket=Exhaust
    // TreadL_FXSocket=Sound_Tread_L
    // TreadR_FXSocket=Sound_Tread_R

    ArmorHitZones(0)=(ZoneName=LEFTSIDELOWER,PhysBodyBoneName=Chassis,ArmorPlateName=LEFTSIDELOWER)
    ArmorHitZones(1)=(ZoneName=LEFTSIDEUPPERONE,PhysBodyBoneName=Chassis,ArmorPlateName=LEFTSIDEUPPER)
    ArmorHitZones(2)=(ZoneName=LEFTSIDEUPPERTWO,PhysBodyBoneName=Chassis,ArmorPlateName=LEFTSIDEUPPER)
    ArmorHitZones(3)=(ZoneName=RIGHTSIDELOWER,PhysBodyBoneName=Chassis,ArmorPlateName=RIGHTSIDELOWER)
    ArmorHitZones(4)=(ZoneName=RIGHTSIDEUPPERONE,PhysBodyBoneName=Chassis,ArmorPlateName=RIGHTSIDEUPPER)
    ArmorHitZones(5)=(ZoneName=RIGHTSIDEUPPERTWO,PhysBodyBoneName=Chassis,ArmorPlateName=RIGHTSIDEUPPER)
    ArmorHitZones(6)=(ZoneName=FRONTUPPER,PhysBodyBoneName=Chassis,ArmorPlateName=FRONTUPPER)
    ArmorHitZones(7)=(ZoneName=FRONTUNDERSIDE,PhysBodyBoneName=Chassis,ArmorPlateName=UNDERSIDEFRONT)
    ArmorHitZones(8)=(ZoneName=RIGHTUNDERSIDE,PhysBodyBoneName=Chassis,ArmorPlateName=UNDERSIDERIGHT)
    ArmorHitZones(9)=(ZoneName=LEFTUNDERSIDE,PhysBodyBoneName=Chassis,ArmorPlateName=UNDERSIDELEFT)
    ArmorHitZones(10)=(ZoneName=GUNNERVIEW,PhysBodyBoneName=MG_Yaw,bInstaPenetrateZone=true)
    ArmorHitZones(11)=(ZoneName=REARCABINUPPERONE,PhysBodyBoneName=Chassis,ArmorPlateName=REARCABIN)
    ArmorHitZones(12)=(ZoneName=REARCABINUPPERTWO,PhysBodyBoneName=Chassis,ArmorPlateName=REARCABIN)
    ArmorHitZones(13)=(ZoneName=ROOFARMOR,PhysBodyBoneName=Chassis,ArmorPlateName=ROOFARMOR)
    ArmorHitZones(14)=(ZoneName=MGHATCH,PhysBodyBoneName=Chassis,ArmorPlateName=MGHATCH)
    ArmorHitZones(15)=(ZoneName=MGSHEILDONE,PhysBodyBoneName=MG_Yaw,ArmorPlateName=MGSHEILD)
    ArmorHitZones(16)=(ZoneName=MGSHEILDTWO,PhysBodyBoneName=MG_Yaw,ArmorPlateName=MGSHEILD)
    ArmorHitZones(17)=(ZoneName=MGSHEILDTHREE,PhysBodyBoneName=MG_Yaw,ArmorPlateName=MGSHEILD)

    ArmorPlates(0)=(PlateName=REARCABIN,ArmorZoneType=AZT_Back,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(1)=(PlateName=UNDERSIDELEFT,ArmorZoneType=AZT_Floor,PlateThickness=7,OverallHardness=400,bHighHardness=true)
    ArmorPlates(2)=(PlateName=UNDERSIDERIGHT,ArmorZoneType=AZT_Floor,PlateThickness=7,OverallHardness=400,bHighHardness=true)
    ArmorPlates(3)=(PlateName=UNDERSIDEFRONT,ArmorZoneType=AZT_Floor,PlateThickness=7,OverallHardness=400,bHighHardness=true)
    ArmorPlates(4)=(PlateName=FRONTUPPER,ArmorZoneType=AZT_Front,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(5)=(PlateName=RIGHTSIDEUPPER,ArmorZoneType=AZT_Right,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(6)=(PlateName=LEFTSIDEUPPER,ArmorZoneType=AZT_Left,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(7)=(PlateName=LEFTSIDELOWER,ArmorZoneType=AZT_Left,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(8)=(PlateName=RIGHTSIDELOWER,ArmorZoneType=AZT_Right,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(9)=(PlateName=ROOFARMOR,ArmorZoneType=AZT_Roof,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(10)=(PlateName=MGHATCH,ArmorZoneType=AZT_Roof,PlateThickness=10,OverallHardness=400,bHighHardness=true)
    ArmorPlates(11)=(PlateName=MGSHEILD,ArmorZoneType=AZT_Roof,PlateThickness=10,OverallHardness=400,bHighHardness=true)



    VehHitZones(0)=(ZoneName=LEFTDRIVEWHEEL,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=400)
    VehHitZones(1)=(ZoneName=RIGHTDRIVEWHEEL,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=400)
    VehHitZones(2)=(ZoneName=FUELTANKLEFT,DamageMultiplier=5.0,VehicleHitZoneType=VHT_Fuel,ZoneHealth=100,KillPercentage=0.2,VisibleFrom=7)
    VehHitZones(3)=(ZoneName=FUELTANKRIGHT,DamageMultiplier=5.0,VehicleHitZoneType=VHT_Fuel,ZoneHealth=100,KillPercentage=0.2,VisibleFrom=11)
    VehHitZones(4)=(ZoneName=GEARBOX,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Mechanicals,ZoneHealth=100,VisibleFrom=15)
    VehHitZones(5)=(ZoneName=GEARBOXCORE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Mechanicals,ZoneHealth=200,VisibleFrom=15)
    VehHitZones(6)=(ZoneName=ENGINEBLOCK,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Engine,ZoneHealth=100,VisibleFrom=13)
    VehHitZones(7)=(ZoneName=ENGINECORE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Engine,ZoneHealth=300,VisibleFrom=13)
    VehHitZones(8)=(ZoneName=LEFTTRACKONE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    VehHitZones(9)=(ZoneName=LEFTTRACKTWO,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(10)=(ZoneName=LEFTTRACKTHREE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(11)=(ZoneName=LEFTTRACKFOUR,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(12)=(ZoneName=LEFTTRACKFIVE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(13)=(ZoneName=LEFTTRACKSIX,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(14)=(ZoneName=LEFTTRACKSEVEN,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(15)=(ZoneName=LEFTTRACKEIGHT,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(16)=(ZoneName=LEFTTRACKNINE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(17)=(ZoneName=LEFTTRACKTEN,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(18)=(ZoneName=LEFTTRACKELEVEN,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    VehHitZones(19)=(ZoneName=RIGHTTRACKONE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    VehHitZones(20)=(ZoneName=RIGHTTRACKTWO,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(21)=(ZoneName=RIGHTTRACKTHREE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(22)=(ZoneName=RIGHTTRACKFOUR,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(23)=(ZoneName=RIGHTTRACKFIVE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(24)=(ZoneName=RIGHTTRACKSIX,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(25)=(ZoneName=RIGHTTRACKSEVEN,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(26)=(ZoneName=RIGHTTRACKEIGHT,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(27)=(ZoneName=RIGHTTRACKNINE,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(28)=(ZoneName=RIGHTTRACKTEN,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(29)=(ZoneName=RIGHTTRACKELEVEN,DamageMultiplier=1.0,VehicleHitZoneType=VHT_Track,ZoneHealth=200)
    // VehHitZones(30)=(ZoneName=PASS1BODY,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewBody,CrewSeatIndex=2,SeatProxyIndex=2,CrewBoneName=passenger_l1_HITBOX)
    // VehHitZones(31)=(ZoneName=PASS1HEAD,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewHead,CrewSeatIndex=2,SeatProxyIndex=2,CrewBoneName=passenger_l1_head_HITBOX)
    // VehHitZones(32)=(ZoneName=PASS2BODY,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewBody,CrewSeatIndex=3,SeatProxyIndex=3,CrewBoneName=passenger_r1_HITBOX)
    // VehHitZones(33)=(ZoneName=PASS2HEAD,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewHead,CrewSeatIndex=3,SeatProxyIndex=3,CrewBoneName=passenger_r1_head_HITBOX)
    // VehHitZones(34)=(ZoneName=PASS3BODY,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewBody,CrewSeatIndex=4,SeatProxyIndex=4,CrewBoneName=passenger_l2_HITBOX)
    // VehHitZones(35)=(ZoneName=PASS3HEAD,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewHead,CrewSeatIndex=4,SeatProxyIndex=4,CrewBoneName=passenger_l2_head_HITBOX)
    // VehHitZones(36)=(ZoneName=PASS4BODY,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewBody,CrewSeatIndex=5,SeatProxyIndex=5,CrewBoneName=passenger_r2_HITBOX)
    // VehHitZones(37)=(ZoneName=PASS4HEAD,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewHead,CrewSeatIndex=5,SeatProxyIndex=5,CrewBoneName=passenger_r2_head_HITBOX)
    VehHitZones(38)=(ZoneName=MGGUNNERBODY,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewBody,CrewSeatIndex=1,SeatProxyIndex=1,CrewBoneName=Root_MG_HITBOX)
    VehHitZones(39)=(ZoneName=MGGUNNERHEAD,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewHead,CrewSeatIndex=1,SeatProxyIndex=1,CrewBoneName=Root_MG_head_HITBOX)
    VehHitZones(40)=(ZoneName=DRIVERBODY,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewBody,CrewSeatIndex=0,SeatProxyIndex=0,CrewBoneName=Root_Driver_HITBOX)
    VehHitZones(41)=(ZoneName=DRIVERHEAD,DamageMultiplier=1.0,VehicleHitZoneType=VHT_CrewHead,CrewSeatIndex=0,SeatProxyIndex=0,CrewBoneName=Root_Driver_head_HITBOX)

    CrewHitZoneStart=30
    CrewHitZoneEnd=41

    GroundSpeed=655
    MaxSpeed=655    // 48 km/h

    RanOverDamageType=RODamageType_RunOver
    TransportType=ROTT_UniversalCarrier

    // Periscope
    PeriscopeLenseMICTemplate2=MaterialInstanceConstant'ZM_VH_Drivable_M113_APC.MIC.PeriscopeRenderTarget_2'
    // PeriscopeLenseMICTemplate2.bUsedWithSkeletalMesh=True
}
