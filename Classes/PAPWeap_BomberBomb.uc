class PAPWeap_BomberBomb extends ROWeap_C4_Explosive;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
}

simulated function bool CanPlantCharge()
{
    return False;
}

simulated event ReplicatedEvent(name VarName)
{
    super.ReplicatedEvent(VarName);
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
            NewCharge.OwningWeapon = self;
            NewCharge.SetReplicationValues(false);
            NewCharge.SetBase(self);
            NewCharge.bPlantedOnWall = !bPlantLocIsGround;

            // if the thrower (or dropper) is dead, use our cached controller
            if( NewCharge.InstigatorController == none )
            {
                NewCharge.InstigatorController = ThrowingController;
            }

            ROPlayerController(Instigator.Controller).AddCharge(NewCharge);

            UpdateStoredCharges();

            /*
            if ( ThrowingBattleChatterIndex != -1 && !Instigator.bIsCrouched && !Instigator.bIsProning
                && !ROPawn(Instigator).IsInCover() && ROPawn(Instigator).IsMovingJogSpeed(true) )
            {
                ROGameInfo(WorldInfo.Game).HandleBattleChatterEvent(Instigator, ThrowingBattleChatterIndex);
            }
            */
        }
    }

    // if(bDebugWeapon)
    // {
    //  DumpStatus("PlantACharge");
    // }
}

DefaultProperties
{
    bIsPersistant=False
    bCanBeThrown=False

    Weight=0

    InitialNumPrimaryMags=1
    MaxAmmoCount=0
}
