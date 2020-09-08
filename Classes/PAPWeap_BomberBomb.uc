class PAPWeap_BomberBomb extends ROWeap_C4_Explosive;

simulated function PostBeginPlay()
{
    `paplog("PAPWeap_BomberBomb.PostBeginPlay()", 'Debug');
    super.PostBeginPlay();

    PlantACharge();
    if (Role == ROLE_Authority)
    {
        ServerGrenadeWasThrown();
    }

    // SetTimer(0.1, True, 'LogLocation');
}

simulated function LogLocation()
{
    `paplog("bomb location=" $ Location, 'Debug');
}

simulated function PlantACharge()
{
    local RORemoteExplosiveProjectile NewCharge;

    // Make sure a camera shift hasn't moved our aim to somewhere that we can't plant
    /*
    if( !CanPlantCharge() )
    {
        CancelWeaponAction(true, true);
        GotoActiveState();
        return;
    }
    */

    if( Role == ROLE_Authority )
    {
        NewCharge = RORemoteExplosiveProjectile(SpawnPlantedCharge());
        if( NewCharge != none )
        {
            // PlantedCharges[NumPlantedCharges - 1].OwningWeapon = self;
            // PlantedCharges[NumPlantedCharges - 1].SetReplicationValues(false);
            // PlantedCharges[NumPlantedCharges - 1].SetBase(VehicleToAttach);
            // PlantedCharges[NumPlantedCharges - 1].bPlantedOnWall = !bPlantLocIsGround;

            NewCharge.OwningWeapon = self;
            NewCharge.SetReplicationValues(false);
            NewCharge.SetBase(Instigator);
            NewCharge.bPlantedOnWall = false;

            // if the thrower (or dropper) is dead, use our cached controller
            if( NewCharge.InstigatorController == none )
            {
                NewCharge.InstigatorController = ThrowingController;
            }

            ROPlayerController(Instigator.Controller).AddCharge(NewCharge);

            UpdateStoredCharges();

            /*
            if ( ThrowingBattleChatterIndex != -1 && !Instigator.bIsCrouched && !Instigator.bIsProning && !ROPawn(Instigator).IsInCover() && ROPawn(Instigator).IsMovingJogSpeed(true) )
            {
                ROGameInfo(WorldInfo.Game).HandleBattleChatterEvent(Instigator, ThrowingBattleChatterIndex);
            }
            */
        }
    }

    if(bDebugWeapon)
    {
        DumpStatus("PlantACharge");
    }
}

simulated function bool InDetonateRange(vector ChargeLocation)
{
    `paplog("InDetonateRange(): self.Location=" $ self.Location
        $ ", ChargeLocation=" $ ChargeLocation, 'Debug');
    return True;
}

simulated function ForceCalcChargeLoc(vector HitLocation, vector HitNormal)
{
    local Vector X, Y, View;
    local Rotator TempRot;

    `paplog("BOMBER_BOMB: ForceCalcChargeLoc()", 'Debug');

    // Don't move with the camera!
    if( IsInState('PlantingCharge') )
    {
        return;
    }

    TempRot.Yaw = Rotation.Yaw;

    View = Vector(TempRot);
    Y = HitNormal cross View;
    X = Y cross HitNormal;

    // DEBUG:
    DrawDebugLine(HitLocation, HitLocation + 10 * X,255,0,0,false); // Red Line
    DrawDebugLine(HitLocation, HitLocation + 10 * Y,0,255,0,false); // Green Line
    DrawDebugLine(HitLocation, HitLocation + 10 * HitNormal,0,0,255,false); // Blue Line

    ChargePlantRot = OrthoRotation(X, Y, HitNormal);

    ChargePlantLoc = Instigator.Location;

    ChargePlantNorm = HitNormal;
}

DefaultProperties
{
    bIsPersistant=False
    bCanBeThrown=False

    Weight=0

    InitialNumPrimaryMags=1
    MaxAmmoCount=1

    bDebugWeapon=True

    WeaponContentClass(0)="PicksAndPistols.PAPWeap_BomberBomb_Content"

    // MAIN FIREMODE
    WeaponProjectiles(0)=class'PicksAndPistols.PAPC4ExplosiveCharge'
    WeaponThrowAnim(0)=C4_throw
    WeaponIdleAnims(0)=C4_idle
    ExplosiveBlindFireRightAnim(0)=C4_R_throw
    ExplosiveBlindFireLeftAnim(0)=C4_L_throw
    ExplosiveBlindFireUpAnim(0)=C4_Up_throw

    // ALT FIREMODE
    WeaponProjectiles(ALTERNATE_FIREMODE)=class'PicksAndPistols.PAPC4ExplosiveCharge'
    WeaponThrowAnim(ALTERNATE_FIREMODE)=C4_toss
    WeaponIdleAnims(ALTERNATE_FIREMODE)=C4_idle
    ExplosiveBlindFireRightAnim(ALTERNATE_FIREMODE)=C4_R_toss
    ExplosiveBlindFireLeftAnim(ALTERNATE_FIREMODE)=C4_L_throw
    ExplosiveBlindFireUpAnim(ALTERNATE_FIREMODE)=C4_toss
}
